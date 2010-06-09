require 'spec_helper'

describe "products/index.html.erb" do
  before(:each) do
    assign(:products, [
      stub_model(Product,
        :name => "MyString",
        :description => "MyText",
        :price => "9.99"
      ),
      stub_model(Product,
        :name => "MyString",
        :description => "MyText",
        :price => "9.99"
      )
    ])
  end

  it "renders a list of products" do
    render
    rendered.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "9.99".to_s, :count => 2)
  end
end
