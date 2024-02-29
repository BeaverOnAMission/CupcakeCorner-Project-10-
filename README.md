"CupcakeCorner" food-order app sending orders to server, handling data transmission, errors and server interaction seamlessly through the CheckOutView using asynchronous operations.


Featuring:  
`Handling data transmission and server interaction`(When the user clicks "Place order," the user's order details are encoded into JSON format. Then, a URLRequest is created. The order data is uploaded asynchronously using URLSession.shared.upload, which sends the request to the server and waits for the response),  
`AsyncImage`(It allows the application to fetch the image from a remote server asynchronously, preventing any UI blocking while the image is being retrieved, by showing loading spinner),  
`Await`(Button action wrapped inside a Task block and marked with await, allowing the app to await the completion of the placeOrder() function without blocking the UI thread),  
`didSet`(automatically update certain properties and user interface elements based on user input. In the Order class, the properties name, address, city, and zip are observed. Whenever any of these properties change, the corresponding didSet blocks update the corresponding values in UserDefaults. This ensures that user input is persisted across app launches)
