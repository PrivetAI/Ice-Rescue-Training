import Foundation

// MARK: - Content Data
struct ContentData {
    
    // MARK: - Lessons
    static let lessons: [Lesson] = [
        Lesson(
            id: "lesson_1",
            title: "Ice Safety Basics",
            subtitle: "Learn to assess ice conditions",
            icon: "book",
            sections: [
                LessonSection(id: "s1_1", title: "Ice Thickness", steps: [
                    LessonStep(id: "st1", title: "Minimum Safe Thickness", content: "For walking: minimum 4 inches (10 cm) of clear ice. For snowmobiles: minimum 5-6 inches. For cars: minimum 8-12 inches.", important: true),
                    LessonStep(id: "st2", title: "Ice Quality Matters", content: "Clear blue ice is strongest. White opaque ice is weaker. Gray ice indicates water and is unsafe.", important: true),
                    LessonStep(id: "st3", title: "Testing Ice", content: "Use an ice chisel or auger. Check thickness every 150 feet. Ice thickness can vary across the same body of water.", important: false)
                ]),
                LessonSection(id: "s1_2", title: "Danger Signs", steps: [
                    LessonStep(id: "st4", title: "Visual Warning Signs", content: "Cracks, holes, dark spots, flowing water, pressure ridges all indicate dangerous conditions.", important: true),
                    LessonStep(id: "st5", title: "Environmental Factors", content: "Warm weather, rain, sun exposure, and currents can weaken ice. Springs and inlets are especially dangerous.", important: false)
                ])
            ]
        ),
        Lesson(
            id: "lesson_2",
            title: "Self-Rescue Techniques",
            subtitle: "How to save yourself if you fall through",
            icon: "target",
            sections: [
                LessonSection(id: "s2_1", title: "Immediate Actions", steps: [
                    LessonStep(id: "st6", title: "Stay Calm", content: "Control your breathing. You have 1-3 minutes before cold shock passes. Focus on keeping your head above water.", important: true),
                    LessonStep(id: "st7", title: "Turn Back", content: "Turn toward the direction you came from. The ice was strong enough to hold you there.", important: true),
                    LessonStep(id: "st8", title: "Arms on Ice", content: "Extend your arms onto the ice surface. Spread them wide to distribute your weight.", important: false)
                ]),
                LessonSection(id: "s2_2", title: "Getting Out", steps: [
                    LessonStep(id: "st9", title: "Kick and Pull", content: "Kick your legs like swimming while pulling yourself forward onto the ice. Get horizontal.", important: true),
                    LessonStep(id: "st10", title: "Roll Away", content: "Once on ice, do not stand up. Roll away from the hole until you reach solid ice.", important: true),
                    LessonStep(id: "st11", title: "Seek Warmth", content: "Get to shelter immediately. Remove wet clothes. Warm the core first.", important: true)
                ])
            ]
        ),
        Lesson(
            id: "lesson_3",
            title: "Helping Others",
            subtitle: "Safe rescue techniques",
            icon: "emergency",
            sections: [
                LessonSection(id: "s3_1", title: "Rescue Priorities", steps: [
                    LessonStep(id: "st12", title: "Call for Help First", content: "Call emergency services immediately. Never enter the water yourself.", important: true),
                    LessonStep(id: "st13", title: "Reach-Throw-Go", content: "First try to reach with object, then throw rope/flotation, only go on ice as last resort.", important: true)
                ]),
                LessonSection(id: "s3_2", title: "Rescue Methods", steps: [
                    LessonStep(id: "st14", title: "Reaching", content: "Use poles, branches, ladders, or clothing tied together. Stay on solid ground or ice.", important: false),
                    LessonStep(id: "st15", title: "Throwing", content: "Throw rope, life ring, or any flotation device. Aim past the victim so they can grab the line.", important: false),
                    LessonStep(id: "st16", title: "Going", content: "If you must go on ice, lie flat and crawl. Use a ladder or board to spread weight. Have someone hold your feet.", important: true)
                ])
            ]
        ),
        Lesson(
            id: "lesson_4",
            title: "Safety Equipment",
            subtitle: "Essential gear for ice activities",
            icon: "gear",
            sections: [
                LessonSection(id: "s4_1", title: "Personal Equipment", steps: [
                    LessonStep(id: "st17", title: "Ice Picks", content: "Wear around your neck. Used to grip ice when pulling yourself out. Essential for ice fishing.", important: true),
                    LessonStep(id: "st18", title: "Flotation Suit", content: "Provides buoyancy and insulation. Required for snowmobiling on ice in many areas.", important: false),
                    LessonStep(id: "st19", title: "Whistle", content: "Loud signal device when you cannot yell. Cold water can make shouting impossible.", important: false)
                ]),
                LessonSection(id: "s4_2", title: "Group Equipment", steps: [
                    LessonStep(id: "st20", title: "Throw Rope", content: "50-100 feet of floating rope. Keep accessible. Practice throwing accurately.", important: true),
                    LessonStep(id: "st21", title: "Ice Chisel", content: "Check ice thickness regularly. Test before and during your trip.", important: false)
                ])
            ]
        ),
        Lesson(
            id: "lesson_5",
            title: "Prevention",
            subtitle: "Avoiding dangerous situations",
            icon: "snowflake",
            sections: [
                LessonSection(id: "s5_1", title: "Before You Go", steps: [
                    LessonStep(id: "st22", title: "Check Conditions", content: "Get local ice reports. Ask locals or authorities about current conditions.", important: true),
                    LessonStep(id: "st23", title: "Tell Someone", content: "Share your plans, location, and expected return time with someone not going with you.", important: true),
                    LessonStep(id: "st24", title: "Dress Properly", content: "Wear layers. Bring extra dry clothes in waterproof bag.", important: false)
                ]),
                LessonSection(id: "s5_2", title: "On the Ice", steps: [
                    LessonStep(id: "st25", title: "Spread Out", content: "Keep distance between group members. Less weight on any single area.", important: true),
                    LessonStep(id: "st26", title: "Watch for Changes", content: "Be alert for cracking sounds, shifting, or water appearing. Leave immediately if conditions change.", important: true)
                ])
            ]
        ),
        Lesson(
            id: "lesson_6",
            title: "First Aid",
            subtitle: "Treating hypothermia",
            icon: "warning",
            sections: [
                LessonSection(id: "s6_1", title: "Recognition", steps: [
                    LessonStep(id: "st27", title: "Mild Hypothermia", content: "Shivering, confusion, slurred speech. Body temp 90-95F (32-35C). Person can still help themselves.", important: true),
                    LessonStep(id: "st28", title: "Severe Hypothermia", content: "Shivering stops, extreme confusion or unconsciousness. Body temp below 90F (32C). Medical emergency.", important: true)
                ]),
                LessonSection(id: "s6_2", title: "Treatment", steps: [
                    LessonStep(id: "st29", title: "Get to Warmth", content: "Move to shelter. Remove wet clothes. Wrap in blankets or sleeping bag.", important: true),
                    LessonStep(id: "st30", title: "Warm the Core", content: "Apply warm compresses to neck, armpits, groin. Give warm sweet drinks if conscious.", important: true),
                    LessonStep(id: "st31", title: "Do Not", content: "Do not rub limbs, give alcohol, or apply direct heat to arms/legs. This can cause cardiac arrest.", important: true)
                ])
            ]
        )
    ]
    
    // MARK: - Scenarios
    static let scenarios: [Scenario] = [
        Scenario(
            id: "scenario_1",
            title: "You Fell Through",
            description: "Practice self-rescue when you break through ice",
            icon: "target",
            difficulty: .easy,
            steps: [
                ScenarioStep(
                    id: "sc1_1",
                    situation: "You've just broken through the ice into freezing water. Your first reaction should be:",
                    options: [
                        ScenarioOption(id: "a", text: "Swim to the nearest shore"),
                        ScenarioOption(id: "b", text: "Control breathing and stay calm"),
                        ScenarioOption(id: "c", text: "Remove heavy clothing immediately"),
                        ScenarioOption(id: "d", text: "Call for help as loud as possible")
                    ],
                    correctOptionId: "b",
                    explanation: "Cold shock causes rapid breathing. Controlling your breathing is critical in the first 1-3 minutes."
                ),
                ScenarioStep(
                    id: "sc1_2",
                    situation: "You've controlled your breathing. Now you need to get out. Which direction should you go?",
                    options: [
                        ScenarioOption(id: "a", text: "Toward the nearest land"),
                        ScenarioOption(id: "b", text: "The direction you came from"),
                        ScenarioOption(id: "c", text: "The direction with thickest-looking ice"),
                        ScenarioOption(id: "d", text: "Any direction, just get out fast")
                    ],
                    correctOptionId: "b",
                    explanation: "The ice was strong enough to hold you on the way in, so that direction is your best option."
                ),
                ScenarioStep(
                    id: "sc1_3",
                    situation: "You've managed to pull yourself onto the ice. What should you do now?",
                    options: [
                        ScenarioOption(id: "a", text: "Stand up and walk to safety quickly"),
                        ScenarioOption(id: "b", text: "Crawl on hands and knees to shore"),
                        ScenarioOption(id: "c", text: "Roll away from the hole until on solid ice"),
                        ScenarioOption(id: "d", text: "Rest for a moment to recover energy")
                    ],
                    correctOptionId: "c",
                    explanation: "Rolling distributes your weight and prevents breaking through again. Never stand up near weak ice."
                )
            ]
        ),
        Scenario(
            id: "scenario_2",
            title: "Helping a Stranger",
            description: "Someone falls through ice near you",
            icon: "emergency",
            difficulty: .medium,
            steps: [
                ScenarioStep(
                    id: "sc2_1",
                    situation: "You see someone fall through ice 30 feet away. Your immediate action should be:",
                    options: [
                        ScenarioOption(id: "a", text: "Run to help them out"),
                        ScenarioOption(id: "b", text: "Call emergency services first"),
                        ScenarioOption(id: "c", text: "Find something to throw to them"),
                        ScenarioOption(id: "d", text: "Go back and get help from others")
                    ],
                    correctOptionId: "b",
                    explanation: "Always call for professional help first. You can continue rescue attempts while waiting."
                ),
                ScenarioStep(
                    id: "sc2_2",
                    situation: "You've called 911. The victim is struggling. What's the safest way to help?",
                    options: [
                        ScenarioOption(id: "a", text: "Walk carefully to the edge of the hole"),
                        ScenarioOption(id: "b", text: "Throw or reach something to them from solid ground"),
                        ScenarioOption(id: "c", text: "Make a human chain with others"),
                        ScenarioOption(id: "d", text: "Jump in to support them until help arrives")
                    ],
                    correctOptionId: "b",
                    explanation: "Reach or throw rescue aids from solid ground. Never go onto questionable ice or into water."
                )
            ]
        ),
        Scenario(
            id: "scenario_3",
            title: "Child on Thin Ice",
            description: "A child is walking on dangerous ice",
            icon: "warning",
            difficulty: .medium,
            steps: [
                ScenarioStep(
                    id: "sc3_1",
                    situation: "You notice a child walking on ice that looks unsafe. They haven't fallen yet. You should:",
                    options: [
                        ScenarioOption(id: "a", text: "Yell loudly for them to run back"),
                        ScenarioOption(id: "b", text: "Calmly tell them to slowly walk back the way they came"),
                        ScenarioOption(id: "c", text: "Go out on the ice to get them"),
                        ScenarioOption(id: "d", text: "Call the police immediately")
                    ],
                    correctOptionId: "b",
                    explanation: "Stay calm. Sudden movements or running can cause the ice to break. Guide them back slowly."
                ),
                ScenarioStep(
                    id: "sc3_2",
                    situation: "The child fell through the ice. You have a rope in your car. How should you use it?",
                    options: [
                        ScenarioOption(id: "a", text: "Tie it around yourself and go to them"),
                        ScenarioOption(id: "b", text: "Throw the end past the child so they can grab it"),
                        ScenarioOption(id: "c", text: "Crawl on the ice holding the rope to them"),
                        ScenarioOption(id: "d", text: "Make a lasso and throw it around them")
                    ],
                    correctOptionId: "b",
                    explanation: "Throw the rope past them. They can grab the line. Stay on solid ground to pull them out."
                )
            ]
        ),
        Scenario(
            id: "scenario_4",
            title: "Group Ice Fishing",
            description: "Managing group safety on ice",
            icon: "chart",
            difficulty: .easy,
            steps: [
                ScenarioStep(
                    id: "sc4_1",
                    situation: "Your group is heading onto a frozen lake for ice fishing. What's the best formation?",
                    options: [
                        ScenarioOption(id: "a", text: "Walk close together for warmth"),
                        ScenarioOption(id: "b", text: "Spread out with significant distance between people"),
                        ScenarioOption(id: "c", text: "Form a single-file line"),
                        ScenarioOption(id: "d", text: "Have everyone run to the fishing spot")
                    ],
                    correctOptionId: "b",
                    explanation: "Spreading out reduces the weight on any single area of ice and ensures not everyone falls if ice breaks."
                ),
                ScenarioStep(
                    id: "sc4_2",
                    situation: "While fishing, you hear a loud crack. What should everyone do?",
                    options: [
                        ScenarioOption(id: "a", text: "Run to shore immediately"),
                        ScenarioOption(id: "b", text: "Stay still and slowly move apart"),
                        ScenarioOption(id: "c", text: "Gather together and walk as a group"),
                        ScenarioOption(id: "d", text: "Lie down flat and crawl to shore")
                    ],
                    correctOptionId: "d",
                    explanation: "Lying flat spreads your weight. Crawl slowly toward shore, away from the sound."
                )
            ]
        ),
        Scenario(
            id: "scenario_5",
            title: "Night Emergency",
            description: "Someone falls through in darkness",
            icon: "info",
            difficulty: .hard,
            steps: [
                ScenarioStep(
                    id: "sc5_1",
                    situation: "You hear someone fall through ice at night. You can't see them clearly. Your first priority is:",
                    options: [
                        ScenarioOption(id: "a", text: "Use your phone flashlight to find them"),
                        ScenarioOption(id: "b", text: "Call emergency services with your location"),
                        ScenarioOption(id: "c", text: "Shout to ask where they are"),
                        ScenarioOption(id: "d", text: "Carefully walk toward the sounds")
                    ],
                    correctOptionId: "b",
                    explanation: "Call emergency services first. Provide your exact location. They can coordinate the rescue."
                ),
                ScenarioStep(
                    id: "sc5_2",
                    situation: "Help is coming but will take 15 minutes. You can now see the person. They're quiet and not moving much. This means:",
                    options: [
                        ScenarioOption(id: "a", text: "They're doing well conserving energy"),
                        ScenarioOption(id: "b", text: "They may be losing consciousness from cold"),
                        ScenarioOption(id: "c", text: "They've found stable ice to rest on"),
                        ScenarioOption(id: "d", text: "They're waiting for you to help")
                    ],
                    correctOptionId: "b",
                    explanation: "Quietness and reduced movement are signs of severe hypothermia. Keep talking to them and attempt safe rescue."
                )
            ]
        ),
        Scenario(
            id: "scenario_6",
            title: "No Equipment Available",
            description: "Rescue with improvised tools",
            icon: "gear",
            difficulty: .hard,
            steps: [
                ScenarioStep(
                    id: "sc6_1",
                    situation: "Someone is in the water. You have no rope or rescue equipment. What can you use to reach them?",
                    options: [
                        ScenarioOption(id: "a", text: "Your belt"),
                        ScenarioOption(id: "b", text: "Tree branches"),
                        ScenarioOption(id: "c", text: "Clothing tied together"),
                        ScenarioOption(id: "d", text: "All of the above")
                    ],
                    correctOptionId: "d",
                    explanation: "Any of these can be used. Tree branches, tied clothing, or even a car floor mat can save a life."
                ),
                ScenarioStep(
                    id: "sc6_2",
                    situation: "You're extending a tree branch to them but can't quite reach. Should you:",
                    options: [
                        ScenarioOption(id: "a", text: "Step onto the ice to get closer"),
                        ScenarioOption(id: "b", text: "Have the victim swim toward you"),
                        ScenarioOption(id: "c", text: "Find a longer branch or tie items together"),
                        ScenarioOption(id: "d", text: "Throw the branch to them")
                    ],
                    correctOptionId: "c",
                    explanation: "Never go on weak ice. Find more length or throw if possible. They may be too cold to swim."
                )
            ]
        ),
        Scenario(
            id: "scenario_7",
            title: "Hypothermia Response",
            description: "Treating someone rescued from cold water",
            icon: "warning",
            difficulty: .medium,
            steps: [
                ScenarioStep(
                    id: "sc7_1",
                    situation: "A person has been pulled from the ice water. They're shivering violently, confused, and can't walk well. Your first action:",
                    options: [
                        ScenarioOption(id: "a", text: "Have them do jumping jacks to warm up"),
                        ScenarioOption(id: "b", text: "Get them to shelter and remove wet clothes"),
                        ScenarioOption(id: "c", text: "Give them hot coffee or tea"),
                        ScenarioOption(id: "d", text: "Rub their arms and legs vigorously")
                    ],
                    correctOptionId: "b",
                    explanation: "Shelter and dry clothes first. Wet clothes continue cooling the body."
                ),
                ScenarioStep(
                    id: "sc7_2",
                    situation: "They're now in dry clothes and blankets but still very cold. What's the best way to warm them?",
                    options: [
                        ScenarioOption(id: "a", text: "Put them in a hot bath"),
                        ScenarioOption(id: "b", text: "Apply warm compresses to neck, armpits, and groin"),
                        ScenarioOption(id: "c", text: "Give them alcohol to warm from inside"),
                        ScenarioOption(id: "d", text: "Place hot water bottles on their feet")
                    ],
                    correctOptionId: "b",
                    explanation: "Warm the core first at major blood vessels. Warming extremities first can cause cardiac arrest."
                )
            ]
        ),
        Scenario(
            id: "scenario_8",
            title: "Recognizing Bad Ice",
            description: "Identifying unsafe ice conditions",
            icon: "snowflake",
            difficulty: .easy,
            steps: [
                ScenarioStep(
                    id: "sc8_1",
                    situation: "You're checking ice before stepping onto a lake. Which ice color is safest?",
                    options: [
                        ScenarioOption(id: "a", text: "Clear blue ice"),
                        ScenarioOption(id: "b", text: "White opaque ice"),
                        ScenarioOption(id: "c", text: "Gray ice"),
                        ScenarioOption(id: "d", text: "Snow-covered ice")
                    ],
                    correctOptionId: "a",
                    explanation: "Clear blue ice is the strongest. White ice is weaker. Gray ice contains water and is very dangerous."
                ),
                ScenarioStep(
                    id: "sc8_2",
                    situation: "The ice looks good but you see water flowing under a nearby bridge. You should:",
                    options: [
                        ScenarioOption(id: "a", text: "Avoid only the area near the bridge"),
                        ScenarioOption(id: "b", text: "Test the ice near the bridge with a chisel"),
                        ScenarioOption(id: "c", text: "Avoid the entire area - currents weaken ice"),
                        ScenarioOption(id: "d", text: "Cross quickly before currents affect you")
                    ],
                    correctOptionId: "c",
                    explanation: "Moving water prevents ice from forming properly. The weak spot extends well beyond the visible current."
                )
            ]
        )
    ]
    
    // MARK: - Questions
    static let questions: [Question] = [
        Question(id: "q1", text: "What is the minimum ice thickness for safe walking?", options: [QuestionOption(id: "a", text: "2 inches"), QuestionOption(id: "b", text: "4 inches"), QuestionOption(id: "c", text: "6 inches"), QuestionOption(id: "d", text: "8 inches")], correctOptionId: "b", explanation: "4 inches of clear ice is the minimum for safe walking.", category: "basics"),
        Question(id: "q2", text: "Which ice color indicates the safest condition?", options: [QuestionOption(id: "a", text: "White"), QuestionOption(id: "b", text: "Gray"), QuestionOption(id: "c", text: "Clear blue"), QuestionOption(id: "d", text: "Green")], correctOptionId: "c", explanation: "Clear blue ice is the strongest type of ice.", category: "basics"),
        Question(id: "q3", text: "What should you do first if you fall through ice?", options: [QuestionOption(id: "a", text: "Swim to shore"), QuestionOption(id: "b", text: "Remove clothing"), QuestionOption(id: "c", text: "Control your breathing"), QuestionOption(id: "d", text: "Call for help")], correctOptionId: "c", explanation: "Cold shock causes rapid breathing that must be controlled first.", category: "self-rescue"),
        Question(id: "q4", text: "Which direction should you exit the water?", options: [QuestionOption(id: "a", text: "Toward shore"), QuestionOption(id: "b", text: "The way you came"), QuestionOption(id: "c", text: "Any direction"), QuestionOption(id: "d", text: "Against the current")], correctOptionId: "b", explanation: "The ice held you coming in, so it's your safest exit path.", category: "self-rescue"),
        Question(id: "q5", text: "After getting out of the water, you should:", options: [QuestionOption(id: "a", text: "Stand and run"), QuestionOption(id: "b", text: "Roll away from the hole"), QuestionOption(id: "c", text: "Crawl quickly"), QuestionOption(id: "d", text: "Wait for help")], correctOptionId: "b", explanation: "Rolling spreads your weight and prevents falling through again.", category: "self-rescue"),
        Question(id: "q6", text: "When helping someone in the water, you should first:", options: [QuestionOption(id: "a", text: "Jump in to help"), QuestionOption(id: "b", text: "Run onto the ice"), QuestionOption(id: "c", text: "Call emergency services"), QuestionOption(id: "d", text: "Find a boat")], correctOptionId: "c", explanation: "Always call for professional help first.", category: "rescue"),
        Question(id: "q7", text: "The Reach-Throw-Go method means:", options: [QuestionOption(id: "a", text: "Reach for your phone, throw it, go home"), QuestionOption(id: "b", text: "Reach first, throw aid, go only as last resort"), QuestionOption(id: "c", text: "Run to reach them, throw them out"), QuestionOption(id: "d", text: "Reach into water, throw them rope")], correctOptionId: "b", explanation: "Try to reach first, then throw aid, only go on ice as last resort.", category: "rescue"),
        Question(id: "q8", text: "Ice picks are worn:", options: [QuestionOption(id: "a", text: "On your belt"), QuestionOption(id: "b", text: "In your pocket"), QuestionOption(id: "c", text: "Around your neck"), QuestionOption(id: "d", text: "In your tackle box")], correctOptionId: "c", explanation: "Ice picks worn around your neck are immediately accessible if you fall in.", category: "equipment"),
        Question(id: "q9", text: "How often should you check ice thickness?", options: [QuestionOption(id: "a", text: "Once at the shore"), QuestionOption(id: "b", text: "Every 150 feet"), QuestionOption(id: "c", text: "Only when it looks thin"), QuestionOption(id: "d", text: "At the end of the trip")], correctOptionId: "b", explanation: "Ice thickness varies, so check every 150 feet.", category: "basics"),
        Question(id: "q10", text: "Shivering stopping in a cold water victim indicates:", options: [QuestionOption(id: "a", text: "They're warming up"), QuestionOption(id: "b", text: "Severe hypothermia"), QuestionOption(id: "c", text: "They're feeling better"), QuestionOption(id: "d", text: "They can walk now")], correctOptionId: "b", explanation: "When shivering stops, the body is losing its ability to warm itself.", category: "first-aid"),
        Question(id: "q11", text: "Gray colored ice indicates:", options: [QuestionOption(id: "a", text: "Old, thick ice"), QuestionOption(id: "b", text: "Water beneath, very dangerous"), QuestionOption(id: "c", text: "Fresh ice forming"), QuestionOption(id: "d", text: "Safe conditions")], correctOptionId: "b", explanation: "Gray ice contains water and is extremely dangerous.", category: "basics"),
        Question(id: "q12", text: "When warming a hypothermia victim:", options: [QuestionOption(id: "a", text: "Put them in hot water immediately"), QuestionOption(id: "b", text: "Rub their arms and legs"), QuestionOption(id: "c", text: "Give them alcohol"), QuestionOption(id: "d", text: "Warm the core first")], correctOptionId: "d", explanation: "Warming extremities first can cause cardiac arrest.", category: "first-aid"),
        Question(id: "q13", text: "A group on ice should:", options: [QuestionOption(id: "a", text: "Stay close together"), QuestionOption(id: "b", text: "Spread out"), QuestionOption(id: "c", text: "Walk single file"), QuestionOption(id: "d", text: "Run to distribute weight")], correctOptionId: "b", explanation: "Spreading out reduces weight on any single area.", category: "prevention"),
        Question(id: "q14", text: "If you hear ice cracking:", options: [QuestionOption(id: "a", text: "Run to shore"), QuestionOption(id: "b", text: "Stand still"), QuestionOption(id: "c", text: "Lie flat and crawl away"), QuestionOption(id: "d", text: "Jump to spread weight")], correctOptionId: "c", explanation: "Lying flat spreads your weight. Crawl slowly to safety.", category: "prevention"),
        Question(id: "q15", text: "Ice near flowing water is:", options: [QuestionOption(id: "a", text: "Extra strong"), QuestionOption(id: "b", text: "The same as other ice"), QuestionOption(id: "c", text: "Weaker and dangerous"), QuestionOption(id: "d", text: "Good for fishing")], correctOptionId: "c", explanation: "Moving water prevents ice from forming properly.", category: "basics"),
        Question(id: "q16", text: "Mild hypothermia symptoms include:", options: [QuestionOption(id: "a", text: "Unconsciousness"), QuestionOption(id: "b", text: "Shivering and confusion"), QuestionOption(id: "c", text: "No shivering"), QuestionOption(id: "d", text: "Memory loss")], correctOptionId: "b", explanation: "Shivering and confusion are early warning signs.", category: "first-aid"),
        Question(id: "q17", text: "You should NOT give a hypothermia victim:", options: [QuestionOption(id: "a", text: "Warm sweet drinks"), QuestionOption(id: "b", text: "Dry blankets"), QuestionOption(id: "c", text: "Alcohol"), QuestionOption(id: "d", text: "Body heat")], correctOptionId: "c", explanation: "Alcohol dilates blood vessels and increases heat loss.", category: "first-aid"),
        Question(id: "q18", text: "Before going on ice, you should:", options: [QuestionOption(id: "a", text: "Tell someone your plans"), QuestionOption(id: "b", text: "Check local conditions"), QuestionOption(id: "c", text: "Bring safety equipment"), QuestionOption(id: "d", text: "All of the above")], correctOptionId: "d", explanation: "All precautions are important for ice safety.", category: "prevention"),
        Question(id: "q19", text: "Throw rope length should be:", options: [QuestionOption(id: "a", text: "10-20 feet"), QuestionOption(id: "b", text: "25-40 feet"), QuestionOption(id: "c", text: "50-100 feet"), QuestionOption(id: "d", text: "Over 200 feet")], correctOptionId: "c", explanation: "50-100 feet gives enough reach while remaining manageable.", category: "equipment"),
        Question(id: "q20", text: "Cold shock from falling in cold water lasts:", options: [QuestionOption(id: "a", text: "10-20 seconds"), QuestionOption(id: "b", text: "1-3 minutes"), QuestionOption(id: "c", text: "5-10 minutes"), QuestionOption(id: "d", text: "30 minutes")], correctOptionId: "b", explanation: "Cold shock causes gasping and rapid breathing for 1-3 minutes.", category: "self-rescue")
    ]
    
    // MARK: - Emergency Steps
    static let emergencySteps: [EmergencyStep] = [
        EmergencyStep(id: "e1", stepNumber: 1, title: "Keep Calm", description: "Control your breathing. Cold shock will pass in 1-3 minutes.", icon: "info", isWarning: false),
        EmergencyStep(id: "e2", stepNumber: 2, title: "Turn Around", description: "Face the direction you came from - the ice was strong there.", icon: "target", isWarning: false),
        EmergencyStep(id: "e3", stepNumber: 3, title: "Arms Out", description: "Extend arms wide on the ice to distribute weight.", icon: "book", isWarning: false),
        EmergencyStep(id: "e4", stepNumber: 4, title: "Kick and Pull", description: "Kick legs like swimming while pulling yourself horizontal onto ice.", icon: "target", isWarning: false),
        EmergencyStep(id: "e5", stepNumber: 5, title: "Roll Away", description: "Do NOT stand. Roll away from the hole until on solid ice.", icon: "warning", isWarning: true),
        EmergencyStep(id: "e6", stepNumber: 6, title: "Get Warm", description: "Find shelter immediately. Remove wet clothes. Warm your core.", icon: "emergency", isWarning: true)
    ]
    
    static let hypothermiaSigns: [HypothermiaSign] = [
        HypothermiaSign(id: "h1", stage: "Mild", signs: ["Shivering", "Confusion", "Slurred speech", "Poor coordination"], temperature: "90-95°F (32-35°C)", severity: .mild),
        HypothermiaSign(id: "h2", stage: "Moderate", signs: ["Violent shivering or shivering stops", "Extreme confusion", "Drowsiness", "Weak pulse"], temperature: "82-90°F (28-32°C)", severity: .moderate),
        HypothermiaSign(id: "h3", stage: "Severe", signs: ["No shivering", "Unconsciousness", "Shallow breathing", "Weak or no pulse"], temperature: "Below 82°F (28°C)", severity: .severe)
    ]
}
