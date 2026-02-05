import SwiftUI

struct KnowledgeView: View {
    @Binding var selectedTab: AppTab
    @State private var searchText: String = ""
    @State private var selectedCategory: KnowledgeArticle.KnowledgeCategory?
    @State private var selectedArticle: KnowledgeArticle?
    
    var filteredArticles: [KnowledgeArticle] {
        var articles = ContentData.knowledgeArticles
        
        if let category = selectedCategory {
            articles = articles.filter { $0.category == category }
        }
        
        if !searchText.isEmpty {
            articles = articles.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.content.localizedCaseInsensitiveContains(searchText) ||
                $0.tags.contains { $0.localizedCaseInsensitiveContains(searchText) }
            }
        }
        
        return articles
    }
    
    var body: some View {
        if let article = selectedArticle {
            ArticleDetailView(article: article) {
                selectedArticle = nil
            }
        } else {
            articlesList
        }
    }
    
    var articlesList: some View {
        VStack(spacing: 0) {
            HeaderView(title: "Knowledge Base", subtitle: "Safety Information", showBack: true) {
                selectedTab = .home
            }
            
            // Search bar
            HStack(spacing: 12) {
                SearchIcon(size: 20, color: Theme.textMuted)
                
                TextField("Search articles...", text: $searchText)
                    .font(Theme.bodyFont())
                    .foregroundColor(Theme.textPrimary)
                
                if !searchText.isEmpty {
                    Button {
                        searchText = ""
                    } label: {
                        EmergencyIcon(size: 16, color: Theme.textMuted)
                    }
                }
            }
            .padding(12)
            .background(Theme.backgroundLight)
            .cornerRadius(Theme.cornerRadius)
            .padding(.horizontal)
            .padding(.bottom, 12)
            
            // Category filter
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    CategoryPill(title: "All", isSelected: selectedCategory == nil) {
                        selectedCategory = nil
                    }
                    
                    ForEach(KnowledgeArticle.KnowledgeCategory.allCases, id: \.self) { category in
                        CategoryPill(title: category.rawValue, isSelected: selectedCategory == category) {
                            selectedCategory = category
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 12)
            
            // Articles list
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(filteredArticles) { article in
                        ArticleCard(article: article) {
                            selectedArticle = article
                        }
                    }
                    
                    if filteredArticles.isEmpty {
                        VStack(spacing: 12) {
                            SearchIcon(size: 48, color: Theme.textMuted)
                            Text("No articles found")
                                .font(Theme.headlineFont())
                                .foregroundColor(Theme.textSecondary)
                        }
                        .padding(.top, 40)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
        }
        .background(Theme.backgroundGradient.ignoresSafeArea())
    }
}

struct CategoryPill: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(Theme.captionFont())
                .foregroundColor(isSelected ? .white : Theme.textSecondary)
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(isSelected ? Theme.iceBlue : Theme.backgroundLight)
                )
        }
    }
}

struct ArticleCard: View {
    let article: KnowledgeArticle
    let action: () -> Void
    
    var categoryColor: Color {
        switch article.category {
        case .iceSafety: return Theme.iceBlue
        case .selfRescue: return Theme.successGreen
        case .helpingOthers: return Theme.warningOrange
        case .equipment: return Theme.textSecondary
        case .firstAid: return Theme.emergencyRed
        }
    }
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(article.category.rawValue)
                        .font(Theme.smallFont())
                        .foregroundColor(categoryColor)
                    
                    Spacer()
                    
                    Path { path in
                        path.move(to: CGPoint(x: 0, y: 0))
                        path.addLine(to: CGPoint(x: 6, y: 8))
                        path.addLine(to: CGPoint(x: 0, y: 16))
                    }
                    .stroke(Theme.textMuted, style: StrokeStyle(lineWidth: 2, lineCap: .round))
                    .frame(width: 6, height: 16)
                }
                
                Text(article.title)
                    .font(Theme.headlineFont())
                    .foregroundColor(Theme.textPrimary)
                    .multilineTextAlignment(.leading)
                
                Text(article.content)
                    .font(Theme.captionFont())
                    .foregroundColor(Theme.textSecondary)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
            }
            .padding(Theme.cardPadding)
            .frame(maxWidth: .infinity, alignment: .leading)
            .cardStyle()
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

struct ArticleDetailView: View {
    let article: KnowledgeArticle
    let onBack: () -> Void
    
    var categoryColor: Color {
        switch article.category {
        case .iceSafety: return Theme.iceBlue
        case .selfRescue: return Theme.successGreen
        case .helpingOthers: return Theme.warningOrange
        case .equipment: return Theme.textSecondary
        case .firstAid: return Theme.emergencyRed
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView(title: article.title, subtitle: article.category.rawValue, showBack: true, backAction: onBack)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Category badge
                    Text(article.category.rawValue)
                        .font(Theme.captionFont())
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Capsule().fill(categoryColor))
                    
                    // Content
                    Text(article.content)
                        .font(Theme.bodyFont())
                        .foregroundColor(Theme.textPrimary)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineSpacing(4)
                    
                    // Tags
                    if !article.tags.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Related Topics")
                                .font(Theme.captionFont())
                                .foregroundColor(Theme.textMuted)
                            
                            FlowLayout(spacing: 8) {
                                ForEach(article.tags, id: \.self) { tag in
                                    Text(tag)
                                        .font(Theme.smallFont())
                                        .foregroundColor(Theme.iceBlue)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 5)
                                        .background(
                                            Capsule()
                                                .stroke(Theme.iceBlue.opacity(0.5), lineWidth: 1)
                                        )
                                }
                            }
                        }
                        .padding(.top, 8)
                    }
                }
                .padding(Theme.cardPadding)
                .frame(maxWidth: .infinity, alignment: .leading)
                .cardStyle()
                .padding()
            }
        }
        .background(Theme.backgroundGradient.ignoresSafeArea())
    }
}

struct FlowLayout: Layout {
    var spacing: CGFloat = 8
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = arrange(proposal: proposal, subviews: subviews)
        return result.size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = arrange(proposal: proposal, subviews: subviews)
        for (index, frame) in result.frames.enumerated() {
            subviews[index].place(at: CGPoint(x: bounds.minX + frame.origin.x, y: bounds.minY + frame.origin.y), proposal: ProposedViewSize(frame.size))
        }
    }
    
    private func arrange(proposal: ProposedViewSize, subviews: Subviews) -> (size: CGSize, frames: [CGRect]) {
        let maxWidth = proposal.width ?? .infinity
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        var lineHeight: CGFloat = 0
        var frames: [CGRect] = []
        
        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            
            if currentX + size.width > maxWidth && currentX > 0 {
                currentX = 0
                currentY += lineHeight + spacing
                lineHeight = 0
            }
            
            frames.append(CGRect(origin: CGPoint(x: currentX, y: currentY), size: size))
            currentX += size.width + spacing
            lineHeight = max(lineHeight, size.height)
        }
        
        return (CGSize(width: maxWidth, height: currentY + lineHeight), frames)
    }
}
