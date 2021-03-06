require 'spec_helper'

describe "StaticPages" do

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_content(heading) }
    it { should have_title(full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading)     { 'Sample App' }
    let(:page_title)  { '' }

    it_should_behave_like "all static pages"
    it { should_not have_title("| Home") }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lerem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end
    end

    describe "should have a micropost of" do
      let(:user) { FactoryGirl.create(:user) }

      describe "single form" do
        before do
          FactoryGirl.create(:micropost, user: user, content: "Lerem ipsum")
          sign_in user
          visit root_path
        end

        it { should have_content("1 micropost") }
      end

      describe "plural form" do
        before do
          FactoryGirl.create(:micropost, user: user, content: "Lerem ipsum")
          FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
          sign_in user
          visit root_path
        end

        it { should have_content("2 microposts") }
      end
    end
  end

  describe "Help page" do
    before { visit help_path }

    it { should have_content('Help') }
    it { should have_title(full_title('Help')) }
  end

  describe "About page" do
    before { visit about_path }

    it { should have_content('About') }
    it { should have_title(full_title('About')) }
  end

  describe "Contact page" do
    before { visit contact_path }

    it { should have_content('Contact') }
    it { should have_title(full_title('Contact')) }
  end

  it "should have the right links on the layout" do
    visit root_path
    click_link "sample app"
    click_link "About"
    click_link "Contact"
    click_link "News"
    click_link "Home"
    click_link "Help"
    click_link "Rails Tutorial"
  end

end
