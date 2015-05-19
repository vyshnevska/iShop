# Clear and populate db with simple product
Product.delete_all

Product.create!(title: 'Programming Ruby 1.9 & 2.0',
  description:
    %{<p>
        Ruby is the fastest growing and most exciting dynamic language
        out there. If you need to get working programs delivered fast,
        you should add Ruby to your toolbox.
      </p>},
  image: File.open('test/fixtures/files/test.gif'),
  price: 49.95)
