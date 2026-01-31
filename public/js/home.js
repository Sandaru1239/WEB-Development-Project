/* ====================================
   SHOPPING CART FUNCTIONALITY
   This file contains JavaScript functions that run in the browser
   when users interact with buttons on the website
   ==================================== */

/* ====================================
   FUNCTION: addToCart()
   What it does: Shows a message when user clicks "Add to Cart" button
   Parameters:
   - name: The name of the food item
   - price: The price of the food item
   ==================================== */
function addToCart(name, price) {
    // Display a popup message showing what was added
    // Example: "Biryani added to cart (Rs. 250)"
    alert(name + ' added to cart (Rs. ' + price + ')');
}

/* ====================================
   HOW TO EDIT THIS FILE
   ==================================== */
/*
   WANT TO ADD MORE BUTTON FUNCTIONALITY?
   
   1. Create a new function:
   -------
   function myNewFunction(param1, param2) {
       // Your code here
       console.log('Something happened!');
   }
   
   2. Call it from HTML button:
   -------
   In your .ejs file, add:
   <button onclick='myNewFunction("value1", "value2")'>Click Me</button>
   
   3. Test it in browser:
   -------
   Open developer tools (F12) and check Console tab for any errors
   
   COMMON FUNCTIONS TO ADD:
   - Remove from cart function
   - Update quantity function
   - Search function
   - Filter function
   
   TIPS:
   - Use console.log() for debugging
   - Test in browser before uploading
   - Keep function names clear and simple
*/
