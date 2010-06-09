require 'spec_helper'

describe "products/show.html.erb" do
  before(:each) do
    assign(:product, @product = stub_model(Product,
      :name => "MyString",
      :description => "MyText",
      :price => "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
   rendered.should contain("MyString")
   rendered.should contain("MyText")
   rendered.should contain("9.99")
  end
end
