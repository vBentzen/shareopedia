require 'rails_helper'
include RandomData

RSpec.describe WikisController, type: :controller do

  let(:my_wiki) { Wiki.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns [my_wiki] to @wikis" do
      get :index
      expect(assigns(:wikis)).to eq([my_wiki])
    end
  end

  describe "GET new" do
    it "should return http success" do
      expect(response).to have_http_status(:success)
    end

    it "should render the #new view" do
      get :new
      expect(response).to render_template :new
    end

    it "should instantiate @wiki" do
      get :new
      expect(assigns(:wiki)).not_to be_nil
    end
  end

  describe "POST create" do
    it "should increase the number of Wiki by 1" do
      expect{ post :create, wiki: { title: RandomData.random_sentence, body: RandomData.random_paragraph }}.to change(Wiki,:count).by(1)
    end

    it "should should assign the new wiki to @wiki" do
      post :create, wiki: { title: RandomData.random_sentence, body: RandomData.random_paragraph }
      expect(assigns(:wiki)).to eq Wiki.last
    end

    it "should redirect to the new wiki" do
      post :create, wiki: { title: RandomData.random_sentence, body: RandomData.random_paragraph }
      expect(response).to redirect_to Wiki.last
    end
  end

  describe "GET show" do
    it "should return http success" do
      get :show, id: my_wiki.id
      expect(response).to have_http_status(:success)
    end

    it "should render the #show view" do
      get :show, id: my_wiki.id
      expect(response).to render_template :show
    end

    it "should assign my_wiki to @wiki" do
      get :show, id: my_wiki.id
      expect(assigns(:wiki)).to eq(my_wiki)
    end
  end

  describe "GET edit" do
    it "should return http success" do
      get :edit, id: my_wiki.id
      expect(response).to have_http_status(:success)
    end

    it "should render the #edit view" do
      get :edit, id: my_wiki.id
      expect(response).to render_template :edit
    end

    it "should assign the wiki to be updated to @wiki" do
      get :edit, id: my_wiki.id

      wiki_instance = assigns(:wiki)

      expect(wiki_instance.id).to eq my_wiki.id
      expect(wiki_instance.title).to eq my_wiki.title
      expect(wiki_instance.body).to eq my_wiki.body
    end
  end

  describe "PUT update" do
    it "should update wiki with expected attributes" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph

      put :update, id: my_wiki.id, wiki: {title: new_title, body: new_body}

      updated_wiki = assigns(:wiki)
      expect(updated_wiki.id).to eq my_wiki.id
      expect(updated_wiki.title).to eq new_title
      expect(updated_wiki.body).to eq new_body
    end

    it "should redirect to the updated wiki" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph

      put :update, id: my_wiki, wiki: {title: new_title, body: new_body}
      expect(response).to redirect_to my_wiki
    end
  end

  describe "DELETE destroy" do
    it "should delete the post" do
      delete :destroy, id: my_wiki.id
      count = Wiki.where({id: my_wiki.id}).size
      expect(count).to eq 0
    end

    it "should redirect to wiki index" do
      delete :destroy, id: my_wiki.id
      expect(response).to redirect_to wikis_path
    end
  end
end
