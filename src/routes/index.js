/* ====================================
   ROUTE DEFINITIONS FOR THE APP
   This file sets up all the URL paths (routes)
   and connects them to their controller functions
   ==================================== */

// Import the Express library to create routes
const express = require('express');

// Create a new router object to define routes
// Think of it like creating a map for different web addresses
const router = express.Router();

// Import the controller that contains the functions to handle requests
// This controller has the logic for what happens when someone visits a page
const ctrl = require('../controllers/homeController');

/* ====================================
   ROUTE 1: HOME PAGE
   ==================================== */
// When someone visits the root URL (example.com/)
// Call the ctrl.home function to handle it and show the home page
router.get('/', ctrl.home);

/* ====================================
   ROUTE 2: MENU PAGE
   ==================================== */
// When someone visits /menu (example.com/menu)
// Call the ctrl.menu function to handle it and show the menu page
router.get('/menu', ctrl.menu);

/* ====================================
   HOW TO ADD A NEW PAGE/ROUTE
   ==================================== */
/* STEP 1: Add a new function in homeController.js
   -------
   Go to src/controllers/homeController.js and add:
   
   exports.aboutPage = (req, res) => {
       const data = getFood();  // or any data you need
       res.render('about', { data });  // 'about' is the .ejs file name
   };

   STEP 2: Add the new route here in this file
   -------
   Add the line below BEFORE module.exports:
   
   router.get('/about', ctrl.aboutPage);
   
   This means: when someone visits /about, run the aboutPage function

   STEP 3: Create the view file
   -------
   Create a new file: views/about.ejs
   Add your HTML content there using EJS syntax

   STEP 4: (Optional) Add a navigation link in your HTML
   -------
   Add a button or link that points to /about so users can navigate to it
*/

/* ====================================
   EXPORT THE ROUTER
   ==================================== */
// Share this router with other parts of the app
// The main app.js file will use this to handle all these routes
module.exports = router;
