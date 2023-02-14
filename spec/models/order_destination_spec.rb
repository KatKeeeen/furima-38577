require 'rails_helper'

RSpec.describe OrderDestination, type: :model do
  describe '商品購入機能' do
    before do
      buyer = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_destination = FactoryBot.build(:order_destination, user_id: buyer.id, item_id: item.id)
    end

    context '内容に問題ない場合' do
      it "項目が全て存在していれば保存できる" do
        expect(@order_destination).to be_valid
      end

      it "building_nameが空でも保存できる" do
        @order_destination.building_name = nil
        expect(@order_destination).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it "tokenが空では登録できないこと" do
        @order_destination.token = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Token can't be blank")
      end

      it "郵便番号が空では登録できないこと" do
        @order_destination.post_code = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Post code can't be blank")
      end

      it "郵便番号が全角では登録できないこと" do
        @order_destination.post_code = "１２３-４５６７"
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Post code is invalid. Enter it as follows (e.g. 123-4567)")
      end

      it "郵便番号にハイフンが入っていないと登録できないこと" do
        @order_destination.post_code = "1234567"
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Post code is invalid. Enter it as follows (e.g. 123-4567)")
      end

      it "都道府県が空では登録できないこと" do
        @order_destination.prefecture_id = 1
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Prefecture can't be blank")
      end

      it "市区町村が空では登録できないこと" do
        @order_destination.city = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("City can't be blank")
      end

      it "番地が空では登録できないこと" do
        @order_destination.address = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Address can't be blank")
      end

      it "電話番号が空では登録できないこと" do
        @order_destination.phone_number = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Phone number can't be blank")
      end

      it "電話番号が10文字以上でないと登録できないこと" do
        @order_destination.phone_number = "123456789"
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Phone number is invalid. Input within ten to eleven words")
      end

      it "電話番号が11文字以内でないと登録できないこと" do
        @order_destination.phone_number = "123456789012"
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Phone number is invalid. Input within ten to eleven words")
      end

      it "電話番号が全角では登録できないこと" do
        @order_destination.phone_number = "１２３４５６７８９０"
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Phone number is invalid. Input only number")
      end

      it "ユーザーが紐づいていないと登録できないこと" do
        @order_destination.user_id = nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("User can't be blank")
      end

      it "商品が紐づいていないと登録できないこと" do
        @order_destination.item_id= nil
        @order_destination.valid?
        expect(@order_destination.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
