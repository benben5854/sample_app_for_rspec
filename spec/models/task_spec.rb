require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validation' do
    it '全てのカラムが正しい場合は正常処理' do
      task = FactoryBot.build(:task)
      expect(task).to be_valid
    end

    it 'タイトルがない場合はエラー' do
      task = FactoryBot.build(:task, title: nil)
      task.valid?
      expect(task.errors[:title]).to include("can't be blank")
    end

    it 'タイトルが重複している場合はエラー' do
      FactoryBot.create(:task, title: "test")
      task = FactoryBot.build(:task, title: "test")
      task.valid?
      expect(task.errors[:title]).to include("has already been taken")
    end

    it 'タイトルが別の場合は正常処理' do
      FactoryBot.create(:task, title: "test")
      task = FactoryBot.build(:task, title: "test2")
      expect(task).to be_valid
    end

    it 'ステータスがない場合はエラー' do
      task = FactoryBot.build(:task, status: nil)
      task.valid?
      expect(task.errors[:status]).to include("can't be blank")
    end
  end
end
