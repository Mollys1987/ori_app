User.create!(nickname: "管理人",
            age: "90歳代",
            sex: "男性",
            prefucture: "天国",
            city: "天国",
            classification: "なし",
            nursing: "なし",
            status: "テスト",
            key_word1: "ppp",
            key_word2: "ppp",
            key_word3: "ppp",
            answer_digest: BCrypt::Password.create("つぶがい"),
            admin: true
            )

User.create!(nickname: "ステイサム",
            age: "50歳代",
            sex: "男性",
            prefucture: "ハリウッド",
            city: "ビバリーヒルズ",
            classification: "医療者",
            nursing: "実母",
            status: "テスト",
            key_word1: "介護疲れ",
            key_word2: "腰痛",
            key_word3: "認知症",
            answer_digest: BCrypt::Password.create("カレー")
            )

User.create!(nickname: "ますお",
            age: "30歳代",
            sex: "男性",
            prefucture: "東京都",
            city: "世田谷区",
            classification: "介護者",
            nursing: "義父",
            status: "テスト２",
            key_word1: "介護疲れ",
            key_word2: "腰痛",
            key_word3: "認知症",
            answer_digest: BCrypt::Password.create("カレー")
            )
            
30.times do |n|
    User.create!(
      nickname: "テストユーザー#{n + 1}",
      age: "50歳代",
      sex: "女性",
      prefucture: "ハリウッド",
      city: "ビバリーヒルズ",
      classification: "医療者",
      nursing: "実母",
      status: "テスト",
      key_word1: "介護疲れ",
      key_word2: "腰痛",
      key_word3: "認知症",
      answer_digest: BCrypt::Password.create("カレー")
    )
end

30.times do |n|
    Post.create!(
      title: "テスト#{n + 1}",
      content: "テスト文章#{n + 1}",
      key_word1: "介護疲れ",
      user_id: 2
    )
end