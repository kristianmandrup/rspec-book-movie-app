require 'spec_helper'

describe "products/edit.html.erb" do
  before(:each) do
    assign(:product, @product = stub_model(Product,
      :new_record? => false,
      :name => "MyString",
      :description => "MyText",
      :price => "9.99"
    ))
  end

  it "renders the edit product form" do
    render

    rendered.should have_selector("form", :action => product_path(@product), :method => "post") do |form|
      form.should have_selector("input#product_name", :name => "product[name]")
      form.should have_selector("textarea#product_description", :name => "product[description]")
      form.should have_selector("input#product_price", :name => "product[price]")
    end
  end
end
