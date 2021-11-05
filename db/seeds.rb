User.create!(nickname: "ステイサム",
            age: "50s",
            sex: "men",
            prefucture: "ハリウッド",
            city: "ビバリーヒルズ",
            classification: "医療者",
            nursing: "実母",
            status: "テスト",
            key_word1: "介護疲れ",
            key_word2: "腰痛",
            key_word3: "認知症",
            answer_digest: "カレー"
            )

User.create!(nickname: "ますお",
            age: "30s",
            sex: "men",
            prefucture: "東京都",
            city: "世田谷区",
            classification: "介護者",
            nursing: "義父",
            status: "テスト２",
            key_word1: "介護疲れ",
            key_word2: "腰痛",
            key_word3: "認知症",
            answer_digest: "カレー"
            )
            
20.times do |n|
    User.create!(
      nickname: "テストユーザー#{n + 1}",
      answer_digest: "カレー"
    )
  end