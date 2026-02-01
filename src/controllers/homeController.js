/* ====================================
   HOME CONTROLLER
   Handles routing logic for home and menu pages
   ==================================== */

// Import file system module to read files from disk
const fs = require('fs');
// Import path module to handle file paths correctly across different operating systems
const path = require('path');

/* ====================================
   HELPER FUNCTION: getFood()
   Reads and parses the food.json data file
   Returns: Array of food items
   ==================================== */
const getFood = () => {
    // Build the file path to food.json (goes up 2 directories from this file, then into data folder)
    const p = path.join(__dirname, '../../data/food.json');
    // Read the file as text (utf8 encoding) and convert JSON string to JavaScript object
    return JSON.parse(fs.readFileSync(p, 'utf8'));
};

/* ====================================
   EXPORT: home controller function
   Handles requests to the home page
   Filters foods to show only popular items
   ==================================== */
exports.home = (req, res) => {
    // Get all food items and filter to only those marked as popular
    const popular = getFood().filter(i => i.popular);
    // Render the home.ejs template and pass the popular foods to display
    res.render('home', { popular });
};

/* ====================================
   EXPORT: menu controller function
   Handles requests to the menu page
   Filters foods by category (from URL query parameter)
   ==================================== */
exports.menu = (req, res) => {
    // Get the category from URL query string, default to 'Main' if not provided
    // Example: /menu?category=Dessert retrieves category from request query
    const cat = req.query.category || 'Main';
    // Filter food items to only those matching the selected category
    const dishes = getFood().filter(i => i.category === cat);
    // Render the menu.ejs template and pass the filtered dishes and category name
    res.render('menu', { dishes, cat });
};
//I started edit from here if anything wrong delete these
exports.cart = (req, res) => {
    // Get the category from URL query string, default to 'Main' if not provided
    // Example: /menu?category=Dessert retrieves category from request query
    const cat = req.query.category || 'Main';
    // Filter food items to only those matching the selected category
    const dishes = getFood().filter(i => i.category === cat);
    // Render the menu.ejs template and pass the filtered dishes and category name
    res.render('cart', { dishes, cat });
};