import SwiftUI

struct ChecklistView: View {
    @EnvironmentObject var storage: StorageService
    @Binding var selectedTab: AppTab
    @State private var selectedCategory: EquipmentCategory?
    
    var filteredItems: [EquipmentItem] {
        if let category = selectedCategory {
            return ContentData.equipmentItems.filter { $0.category == category }
        }
        return ContentData.equipmentItems
    }
    
    var checkedCount: Int {
        storage.checkedEquipment.count
    }
    
    var totalCount: Int {
        ContentData.equipmentItems.count
    }
    
    var essentialCheckedCount: Int {
        ContentData.equipmentItems.filter { $0.essential && storage.checkedEquipment.contains($0.id) }.count
    }
    
    var essentialTotalCount: Int {
        ContentData.equipmentItems.filter { $0.essential }.count
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView(title: "Equipment Checklist", subtitle: "Prepare for Ice Safety", showBack: true) {
                selectedTab = .home
            }
            
            // Progress summary
            VStack(spacing: 12) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Packed")
                            .font(Theme.captionFont())
                            .foregroundColor(Theme.textMuted)
                        Text("\(checkedCount)/\(totalCount)")
                            .font(Theme.headlineFont())
                            .foregroundColor(Theme.iceBlue)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("Essential Ready")
                            .font(Theme.captionFont())
                            .foregroundColor(Theme.textMuted)
                        Text("\(essentialCheckedCount)/\(essentialTotalCount)")
                            .font(Theme.headlineFont())
                            .foregroundColor(essentialCheckedCount == essentialTotalCount ? Theme.successGreen : Theme.warningOrange)
                    }
                }
                
                ProgressBarView(progress: Double(checkedCount) / Double(totalCount) * 100, color: Theme.iceBlue)
                
                if checkedCount == totalCount {
                    HStack {
                        CheckmarkIcon(size: 20, color: Theme.successGreen)
                        Text("All equipment packed!")
                            .font(Theme.captionFont())
                            .foregroundColor(Theme.successGreen)
                    }
                } else if essentialCheckedCount == essentialTotalCount {
                    HStack {
                        CheckmarkIcon(size: 20, color: Theme.successGreen)
                        Text("All essential items ready")
                            .font(Theme.captionFont())
                            .foregroundColor(Theme.successGreen)
                    }
                }
            }
            .padding(Theme.cardPadding)
            .cardStyle()
            .padding(.horizontal)
            .padding(.bottom, 12)
            
            // Category filter
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    CategoryPill(title: "All", isSelected: selectedCategory == nil) {
                        selectedCategory = nil
                    }
                    
                    ForEach(EquipmentCategory.allCases, id: \.self) { category in
                        CategoryPill(title: category.rawValue, isSelected: selectedCategory == category) {
                            selectedCategory = category
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 12)
            
            // Equipment list
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(filteredItems) { item in
                        EquipmentItemRow(
                            item: item,
                            isChecked: storage.checkedEquipment.contains(item.id)
                        ) {
                            storage.toggleEquipment(item.id)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
            
            // Reset button
            Button("Reset Checklist") {
                storage.resetChecklist()
            }
            .font(Theme.captionFont())
            .foregroundColor(Theme.textMuted)
            .padding(.bottom, 20)
        }
        .background(Theme.backgroundGradient.ignoresSafeArea())
    }
}

struct EquipmentItemRow: View {
    let item: EquipmentItem
    let isChecked: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                // Checkbox
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(isChecked ? Theme.successGreen : Theme.textMuted, lineWidth: 2)
                        .frame(width: 24, height: 24)
                    
                    if isChecked {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Theme.successGreen)
                            .frame(width: 24, height: 24)
                        
                        Path { path in
                            path.move(to: CGPoint(x: 6, y: 12))
                            path.addLine(to: CGPoint(x: 10, y: 16))
                            path.addLine(to: CGPoint(x: 18, y: 8))
                        }
                        .stroke(Color.white, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                        .frame(width: 24, height: 24)
                    }
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(item.name)
                            .font(Theme.bodyFont())
                            .foregroundColor(isChecked ? Theme.textSecondary : Theme.textPrimary)
                            .strikethrough(isChecked, color: Theme.textMuted)
                        
                        if item.essential {
                            Text("Essential")
                                .font(Theme.smallFont())
                                .foregroundColor(Theme.warningOrange)
                        }
                    }
                    
                    Text(item.description)
                        .font(Theme.smallFont())
                        .foregroundColor(Theme.textMuted)
                        .lineLimit(1)
                }
                
                Spacer()
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: Theme.cornerRadius)
                    .fill(isChecked ? Theme.successGreen.opacity(0.1) : Theme.backgroundLight)
            )
        }
        .buttonStyle(ScaleButtonStyle())
    }
}
