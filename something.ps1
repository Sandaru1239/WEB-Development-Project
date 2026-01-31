# ==========================================
# THE CURRY LEAF - AUTOMATED SETUP (FULL)
# ==========================================
Write-Host "--- 1. Setting up Directories & Installing Engine ---" -ForegroundColor Cyan

# Create Folders
$folders = @(
    "data",
    "public/css",
    "public/images",
    "public/js",
    "src/controllers",
    "src/routes",
    "views"
)

foreach ($f in $folders) {
    if (!(Test-Path $f)) {
        New-Item -ItemType Directory -Force -Path $f | Out-Null
    }
}

# Install Dependencies (Fixes 'Cannot find module' error)
# We use 'call' operator (&) to ensure npm runs correctly in script
Write-Host "Installing Express and EJS..." -ForegroundColor Yellow
if (!(Test-Path "package.json")) {
    cmd /c "npm init -y" | Out-Null
}
cmd /c "npm install express ejs"

Write-Host "Structure created and dependencies installed." -ForegroundColor Green

# ==========================================
# PART 2: THE DATABASE (JSON)
# ==========================================
Write-Host "--- 2. Creating Database (food.json) ---" -ForegroundColor Cyan

$foodData = @"
[
  { "name": "Devilled Fish", "description": "Spicy fried fish tossed in a tangy sauce.", "price": 1950, "category": "Starter", "imageUrl": "devilled-fish.jpg", "popular": true },
  { "name": "Chicken Cutlet", "description": "Breaded chicken patty with curry leaves.", "price": 450, "category": "Starter", "imageUrl": "chicken-cutlet.jpg", "popular": true },
  { "name": "Plantain Chips", "description": "Crispy salted green plantain chips.", "price": 320, "category": "Starter", "imageUrl": "plantain-chips.jpg", "popular": false },
  { "name": "Egg Hoppers", "description": "Rice flour pancakes with a soft egg center.", "price": 430, "category": "Starter", "imageUrl": "egg-hoppers.jpg", "popular": true },
  { "name": "Kottu Roti", "description": "Chopped roti stir-fried with veggies and eggs.", "price": 2400, "category": "Main", "imageUrl": "rice-and-kottu.png", "popular": true },
  { "name": "Lamprais", "description": "Rice baked in banana leaf with mixed meats.", "price": 3200, "category": "Main", "imageUrl": "lamprais.jpg", "popular": true },
  { "name": "Chicken Curry", "description": "Chicken in fragrant coconut milk gravy.", "price": 2800, "category": "Main", "imageUrl": "chicken-curry.jpg", "popular": true },
  { "name": "Mutton Curry", "description": "Slow-cooked spicy lamb shoulder.", "price": 3500, "category": "Main", "imageUrl": "mutton-curry.jpg", "popular": false },
  { "name": "Pepper Crab", "description": "Mud crab in rich black pepper sauce.", "price": 4500, "category": "Main", "imageUrl": "pepper-crab.jpg", "popular": true },
  { "name": "Watalappan", "description": "Coconut custard with jaggery and cashews.", "price": 850, "category": "Dessert", "imageUrl": "watalappan.jpg", "popular": true },
  { "name": "Kokis", "description": "Crispy, patterned rice flour cookies.", "price": 220, "category": "Dessert", "imageUrl": "kokis.jpg", "popular": true },
  { "name": "Kalu Dodol", "description": "Dark caramelized jaggery sweet.", "price": 500, "category": "Dessert", "imageUrl": "kalu-dodol.jpg", "popular": true }
]
"@
$foodData | Out-File -FilePath "data/food.json" -Encoding utf8

# ==========================================
# PART 3: SERVER & ROUTES
# ==========================================
Write-Host "--- 3. Configuring Server & Routes ---" -ForegroundColor Cyan

# 1. Server Entry (src/app.js)
$appJs = @"
const express = require('express');
const path = require('path');
const routes = require('./routes/index');

const app = express();

// View Engine Setup
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, '../views'));

// Serve Static Files (CSS/Images)
app.use(express.static(path.join(__dirname, '../public')));

// Routes
app.use('/', routes);

const PORT = 3000;
app.listen(PORT, () => console.log('Server running: http://localhost:3000'));
"@
$appJs | Out-File -FilePath "src/app.js" -Encoding utf8

# 2. Traffic Controller (src/routes/index.js)
$routesJs = @"
const express = require('express');
const router = express.Router();
const ctrl = require('../controllers/homeController');

router.get('/', ctrl.home);
router.get('/menu', ctrl.menu);

module.exports = router;
"@
$routesJs | Out-File -FilePath "src/routes/index.js" -Encoding utf8

# ==========================================
# PART 4: MODULAR CSS
# ==========================================
Write-Host "--- 4. Building Modular CSS ---" -ForegroundColor Cyan

$css = @"
:root {
    --primary: #ff6f00;
    --primary-hover: #e65100;
    --bg: #f8f9fa;
    --white: #ffffff;
    --text: #333;
    --shadow: 0 4px 12px rgba(0,0,0,0.1);
}

body { font-family: 'Segoe UI', sans-serif; background: var(--bg); margin: 0; color: var(--text); }

/* Sticky Header */
.header {
    position: sticky; top: 0; z-index: 1000;
    background: var(--white); padding: 15px 5%;
    display: flex; justify-content: space-between; align-items: center;
    box-shadow: var(--shadow);
}

.logo { color: var(--primary); font-size: 1.5rem; font-weight: bold; text-decoration: none; }

/* Navigation Buttons */
.nav-btn {
    text-decoration: none; padding: 8px 20px; border-radius: 20px;
    background: #ffe5d1; color: var(--text); margin-left: 10px;
    transition: 0.3s; font-weight: 500;
}
.nav-btn:hover { background: #ffd1b3; }
.nav-btn.active { background: var(--primary); color: white; }

/* Grid Layout */
.container { padding: 40px 10%; }
.section-title { text-align: center; margin-bottom: 30px; color: var(--text); }

.grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
    gap: 30px;
}

/* Card Component */
.card {
    background: var(--white); border-radius: 15px; overflow: hidden;
    box-shadow: var(--shadow); transition: transform 0.3s;
    display: flex; flex-direction: column;
}
.card:hover { transform: translateY(-5px); }

.card-img {
    width: 100%; height: 200px; object-fit: cover;
}

.card-body { padding: 20px; flex-grow: 1; display: flex; flex-direction: column; }
.card-title { margin: 0 0 10px 0; font-size: 1.2rem; }
.card-desc { font-size: 0.9rem; color: #666; margin-bottom: 15px; flex-grow: 1; }
.card-price { color: var(--primary); font-weight: bold; font-size: 1.1rem; }

/* Order Button */
.btn-order {
    background: var(--primary); color: white; border: none;
    padding: 10px; width: 100%; border-radius: 8px;
    cursor: pointer; font-weight: bold; margin-top: 10px;
}
.btn-order:hover { background: var(--primary-hover); }
"@
$css | Out-File -FilePath "public/css/style.css" -Encoding utf8

# ==========================================
# PART 5: CONTROLLER LOGIC
# ==========================================
Write-Host "--- 5. Writing Controller Logic ---" -ForegroundColor Cyan

$ctrlJs = @"
const fs = require('fs');
const path = require('path');

// Helper to get data
const getFood = () => {
    const p = path.join(__dirname, '../../data/food.json');
    return JSON.parse(fs.readFileSync(p, 'utf8'));
};

exports.home = (req, res) => {
    // Show only Popular items on home page
    const popular = getFood().filter(i => i.popular);
    res.render('home', { popular });
};

exports.menu = (req, res) => {
    // Filter by category or default to 'Main'
    const cat = req.query.category || 'Main';
    const dishes = getFood().filter(i => i.category === cat);
    res.render('menu', { dishes, cat });
};
"@
$ctrlJs | Out-File -FilePath "src/controllers/homeController.js" -Encoding utf8

# ==========================================
# PART 6: VIEWS & SCRIPTS
# ==========================================
Write-Host "--- 6. Creating Views & Scripts ---" -ForegroundColor Cyan

# 1. Cart Script (public/js/home.js)
$js = @"
function addToCart(name, price) {
    alert(name + ' added to cart (Rs. ' + price + ')');
}
"@
$js | Out-File -FilePath "public/js/home.js" -Encoding utf8

# 2. Home Page (views/home.ejs) - FIX: Changed variable name to homeEjs
$homeEjs = @"
<!DOCTYPE html>
<html>
<head>
    <title>Home | The Curry Leaf</title>
    <link rel='stylesheet' href='/css/style.css'>
</head>
<body>
    <header class='header'>
        <a href='/' class='logo'>The Curry Leaf</a>
        <nav>
            <a href='/' class='nav-btn active'>Home</a>
            <a href='/menu' class='nav-btn'>Menu</a>
        </nav>
    </header>

    <div class='container'>
        <h1 class='section-title'>Popular Favorites</h1>
        <div class='grid'>
            <% popular.forEach(item => { %>
                <div class='card'>
                    <img src='/images/<%= item.imageUrl %>' class='card-img' alt='<%= item.name %>'>
                    <div class='card-body'>
                        <h3 class='card-title'><%= item.name %></h3>
                        <p class='card-price'>Rs. <%= item.price %></p>
                        <button class='btn-order' onclick='addToCart("<%= item.name %>", <%= item.price %>)'>Add to Cart</button>
                    </div>
                </div>
            <% }) %>
        </div>
    </div>
    <script src='/js/home.js'></script>
</body>
</html>
"@
$homeEjs | Out-File -FilePath "views/home.ejs" -Encoding utf8

# 3. Menu Page (views/menu.ejs) - FIX: Changed variable name to menuEjs
$menuEjs = @"
<!DOCTYPE html>
<html>
<head>
    <title>Menu | The Curry Leaf</title>
    <link rel='stylesheet' href='/css/style.css'>
</head>
<body>
    <header class='header'>
        <a href='/' class='logo'>The Curry Leaf</a>
        <nav>
            <a href='/' class='nav-btn'>Home</a>
            <a href='/menu' class='nav-btn active'>Menu</a>
        </nav>
    </header>

    <div class='container'>
        <div style='text-align:center; margin-bottom:30px;'>
            <a href='/menu?category=Starter' class='nav-btn <%= cat==="Starter"?"active":"" %>'>Starters</a>
            <a href='/menu?category=Main' class='nav-btn <%= cat==="Main"?"active":"" %>'>Mains</a>
            <a href='/menu?category=Dessert' class='nav-btn <%= cat==="Dessert"?"active":"" %>'>Desserts</a>
        </div>

        <div class='grid'>
            <% dishes.forEach(item => { %>
                <div class='card'>
                    <img src='/images/<%= item.imageUrl %>' class='card-img' alt='<%= item.name %>'>
                    <div class='card-body'>
                        <h3 class='card-title'><%= item.name %></h3>
                        <p class='card-desc'><%= item.description %></p>
                        <p class='card-price'>Rs. <%= item.price %></p>
                        <button class='btn-order' onclick='addToCart("<%= item.name %>", <%= item.price %>)'>Add to Cart</button>
                    </div>
                </div>
            <% }) %>
        </div>
    </div>
    <script src='/js/home.js'></script>
</body>
</html>
"@
$menuEjs | Out-File -FilePath "views/menu.ejs" -Encoding utf8

Write-Host "--- SETUP COMPLETE ---" -ForegroundColor Green
Write-Host "1. Ensure images are in 'public/images/'" -ForegroundColor Yellow
Write-Host "2. Run: node src/app.js" -ForegroundColor Yellow