import SwiftUI

struct KanjiQuestion: Identifiable {
    let id = UUID()
    let kanji: String
    let readings: [String]
    let correctReading: String
    let strokeCount: Int
    let exampleSentence: String
}

struct ContentView: View {
    // 模拟 PDF 提取的数据
    @State private var questions: [KanjiQuestion] = [
        KanjiQuestion(kanji: "日", readings: ["にち", "ひ", "び"], correctReading: "にち", strokeCount: 4, exampleSentence: "今日は日曜日です。"),
        KanjiQuestion(kanji: "学", readings: ["がく", "まなぶ", "ま"], correctReading: "がく", strokeCount: 8, exampleSentence: "学校へ行きます。"),
        KanjiQuestion(kanji: "勉", readings: ["べん", "つと"], correctReading: "べん", strokeCount: 10, exampleSentence: "勉強を頑張ります。"),
        KanjiQuestion(kanji: "強", readings: ["きょう", "つよ"], correctReading: "きょう", strokeCount: 11, exampleSentence: "風が強いです。")
    ]
    
    @State private var currentIndex = 0
    @State private var showFeedback = false
    @State private var feedbackText = ""

    var body: some View {
        VStack(spacing: 40) {
            Text("漢字達人")
                .font(.largeTitle)
                .bold()
                .padding(.top)

            // 汉字显示
            Text(questions[currentIndex].kanji)
                .font(.system(size: 120))
                .frame(width: 180, height: 180)
                .background(Color.secondary.opacity(0.1))
                .cornerRadius(20)

            // 例句
            Text(questions[currentIndex].exampleSentence)
                .font(.title3)
                .padding()

            // 读音选项
            VStack(spacing: 15) {
                ForEach(questions[currentIndex].readings, id: \.self) { reading in
                    Button(action: {
                        checkAnswer(reading)
                    }) {
                        Text(reading)
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .overlay(
            ZStack {
                if showFeedback {
                    Text(feedbackText)
                        .font(.largeTitle)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
            }
        )
    }

    func checkAnswer(_ answer: String) {
        if answer == questions[currentIndex].correctReading {
            feedbackText = "正解！🎯"
            showFeedback = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                showFeedback = false
                currentIndex = (currentIndex + 1) % questions.count
            }
        } else {
            feedbackText = "残念！❌"
            showFeedback = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                showFeedback = false
            }
        }
    }
}
