iShop App (https://ishopapp.herokuapp.com)
---------

      Rails   4.1
      Ruby    2.1
      DB:     MySql
      Assets: Sass, Bootstrap3, Twitter-Bootstrap, JQuery, CarrierWave File Uploader
      Tests:  MiniTest, Fixtures
      Debug:  Pry

A web-based shopping cart application
=========
Follow the book 'Agile Web Development with Rails 4'(Sam Ruby, Dave Thomas, David Heinemeier Hansson)

---------
*  **Incremental Development**

*  **Tests Coverage**

*  **Rails Best Practices**


API
=========
To retrieve the information using the public api(without token authentication):
```
 curl -X GET 'http://localhost:3000/api/v1/orders' 
 or
 https://ishopapp.herokuapp.com/api/v1/orders
```

To retrieve the information using token authentication:
```
 curl -i -H "Authorization: Token token=valid_token" 'http://localhost:3000/api/v2/orders'
```
