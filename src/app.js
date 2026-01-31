/* ====================================
   MAIN APP FILE - EXPRESS SERVER SETUP
   This is the main entry point that configures the entire application
   ==================================== */

// Import Express library to create a web server
const express = require('express');
// Import path library to handle file paths correctly
const path = require('path');
// Import all the route definitions from routes/index.js
const routes = require('./routes/index');

// Create the Express application
const app = express();

/* ====================================
   VIEW ENGINE SETUP - EJS TEMPLATES
   ==================================== */
// Tell Express to use EJS as the template engine
// EJS lets us mix HTML with JavaScript to create dynamic pages
app.set('view engine', 'ejs');
// Tell Express where to find the EJS template files (in the views folder)
app.set('views', path.join(__dirname, '../views'));

/* ====================================
   STATIC FILES - CSS, IMAGES, JAVASCRIPT
   ==================================== */
// Serve static files from the public folder
// Users can access: /css/style.css, /js/home.js, /images/food.jpg etc.
app.use(express.static(path.join(__dirname, '../public')));

/* ====================================
   ROUTE REGISTRATION
   ==================================== */
// Register all routes from routes/index.js
// This connects URLs to their controller functions
app.use('/', routes);

/* ====================================
   START THE SERVER
   ==================================== */
const PORT = 3000;
app.listen(PORT, () => console.log('Server running: http://localhost:3000'));

/* ====================================
   WHEN ADDING NEW ELEMENTS TO THE SITE
   ==================================== */
/* 
   SCENARIO 1: Adding New CSS or JavaScript Files
   -----------------------------------------------
   WHAT CHANGES:
   - Add your files to: public/css/ or public/js/
   - Link them in your .ejs files using: <link> or <script> tags
   NO CHANGES NEEDED IN THIS FILE
   The app.use(express.static(...)) already serves all files from public/

   SCENARIO 2: Adding a New Page
   -----------------------------------------------
   WHAT CHANGES:
   1. Create a new function in src/controllers/homeController.js
      Example: exports.contact = (req, res) => { ... }
   
   2. Create a new route in src/routes/index.js
      Example: router.get('/contact', ctrl.contact);
   
   3. Create a new template in views/ folder
      Example: views/contact.ejs
   
   NO CHANGES NEEDED IN THIS FILE
   The routes are already imported and registered with app.use('/', routes)

   SCENARIO 3: Adding Database or Middleware
   -----------------------------------------------
   ADD THESE LINES BEFORE app.use('/', routes):
   
   Example for body-parser (parse form data):
   app.use(express.json());
   app.use(express.urlencoded({ extended: true }));
   
   Example for custom middleware:
   app.use((req, res, next) => {
       console.log('Request received:', req.url);
       next();
   });
   
   THIS REQUIRES CHANGES IN app.js

   SCENARIO 4: Adding New Static File Types
   -----------------------------------------------
   If you add files like PDFs, videos, fonts to public/ folder:
   NO CHANGES NEEDED IN THIS FILE
   The express.static() already serves ANY file type from the public folder

   SCENARIO 5: Adding Multiple Routers/Features
   -----------------------------------------------
   If you create more routers (e.g., for admin, API, shop):
   ADD NEW IMPORT:
   const adminRoutes = require('./routes/admin');
   
   ADD NEW ROUTE REGISTRATION:
   app.use('/admin', adminRoutes);
   
   THIS REQUIRES CHANGES IN app.js
*/

/* ====================================
   QUICK REFERENCE CHECKLIST
   ==================================== */
/* 
   ✓ Adding HTML/CSS/JS files? → Just add to public/ folder
   ✓ Adding a new page? → Modify controller, routes, and create view
   ✓ Adding middleware? → Add before app.use('/', routes)
   ✓ Adding new router? → Import and add app.use() here
   ✓ Changing views folder location? → Update app.set('views', ...)
   ✓ Changing static files location? → Update app.use(express.static(...))
*/
