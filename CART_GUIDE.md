# 🛒 The Curry Leaf: Integration Guide

This guide explains how to implement Theme Switching (Day/Night Mode)
and a LocalStorage-based Shopping Cart for your project.

------------------------------------------------------------------------

## 1. CSS Variables & Theme Styling

**File:** `public/css/style.css`

``` css
/* --- 1. THEME DEFINITIONS --- */
:root {
    --bg: #f8f9fa;
    --card-bg: #ffffff;
    --text: #333333;
    --header-bg: #ffffff;
    --primary: #ff6f00;
    --primary-hover: #e65100;
    --nav-btn-bg: #ffe5d1;
    --shadow: 0 4px 12px rgba(0,0,0,0.1);
}

body.dark-mode {
    --bg: #121212;
    --card-bg: #1e1e1e;
    --text: #f0f0f0;
    --header-bg: #1a1a1a;
    --nav-btn-bg: #333333;
    --shadow: 0 4px 12px rgba(0,0,0,0.5);
}

body {
    background-color: var(--bg);
    color: var(--text);
    transition: background 0.3s, color 0.3s;
    margin: 0;
    font-family: 'Segoe UI', sans-serif;
}

.header { 
    background: var(--header-bg); 
    position: sticky; top: 0; z-index: 1000;
    box-shadow: var(--shadow);
    padding: 15px 5%;
    display: flex; justify-content: space-between; align-items: center;
}

.cart-container { position: relative; }

#cart-count {
    position: absolute; top: -8px; right: -8px;
    background: #ff0000; color: white; border-radius: 50%;
    padding: 2px 6px; font-size: 11px; font-weight: bold;
}

.theme-toggle {
    background: none; border: 1.5px solid var(--primary);
    color: var(--primary); padding: 6px 12px;
    border-radius: 20px; cursor: pointer; margin-left: 15px;
    font-weight: bold;
}
```

------------------------------------------------------------------------

## 2. JavaScript (Theme & Cart Logic)

**File:** `public/js/home.js`

``` javascript
function toggleTheme() {
    const body = document.body;
    const isDark = body.classList.contains('dark-mode');
    const newTheme = isDark ? 'light-mode' : 'dark-mode';
    
    body.classList.remove('light-mode', 'dark-mode');
    body.classList.add(newTheme);
    localStorage.setItem('theme', newTheme);
}

function addToCart(name, price) {
    let cart = JSON.parse(localStorage.getItem('curryLeafCart')) || [];
    cart.push({ id: Date.now(), name: name, price: price });
    localStorage.setItem('curryLeafCart', JSON.stringify(cart));
    updateCartBadge();
    alert(name + " added to your cart!");
}

function updateCartBadge() {
    const cart = JSON.parse(localStorage.getItem('curryLeafCart')) || [];
    const badge = document.getElementById('cart-count');
    if (badge) badge.innerText = cart.length;
}

document.addEventListener('DOMContentLoaded', () => {
    const savedTheme = localStorage.getItem('theme') || 'light-mode';
    document.body.classList.add(savedTheme);
    updateCartBadge();
});
```

------------------------------------------------------------------------

## 3. Updated Header View

**File:** `views/home.ejs`

``` html
<header class="header">
    <a href="/" class="logo">The Curry Leaf</a>
    
    <nav style="display: flex; align-items: center;">
        <a href="/" class="nav-btn">Home</a>
        <a href="/menu" class="nav-btn">Menu</a>
        
        <div class="cart-container" style="margin-left: 15px;">
            <a href="/cart" class="nav-btn">
                🛒 <span id="cart-count">0</span>
            </a>
        </div>

        <button class="theme-toggle" onclick="toggleTheme()">🌓 Mode</button>
    </nav>
</header>
```

------------------------------------------------------------------------

## 4. Cart Page

**File:** `views/cart.ejs`

``` html
<!DOCTYPE html>
<html>
<head>
    <title>Your Cart | The Curry Leaf</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <div class="container">
        <h1>Your Selected Dishes</h1>
        
        <div id="cart-items-list"></div>
        
        <div style="margin-top: 30px; border-top: 2px solid var(--primary); padding-top: 20px;">
            <h3>Total Amount: Rs. <span id="cart-total">0</span></h3>
            <button class="btn-order" onclick="checkout()">Place Order</button>
        </div>
    </div>

    <script src="/js/home.js"></script>
    <script>
        function displayCart() {
            const cart = JSON.parse(localStorage.getItem('curryLeafCart')) || [];
            const container = document.getElementById('cart-items-list');
            let total = 0;

            if (cart.length === 0) {
                container.innerHTML = "<p>Your cart is empty. Go get some food!</p>";
                return;
            }

            container.innerHTML = cart.map(item => {
                total += item.price;
                return `
                    <div class="card" style="margin-bottom: 15px; padding: 20px; display: flex; justify-content: space-between;">
                        <div>
                            <strong>${item.name}</strong><br>
                            <small>Rs. ${item.price}</small>
                        </div>
                        <button onclick="removeItem(${item.id})" style="color:red; cursor:pointer; background:none; border:none;">Remove</button>
                    </div>
                `;
            }).join('');

            document.getElementById('cart-total').innerText = total;
        }

        function removeItem(id) {
            let cart = JSON.parse(localStorage.getItem('curryLeafCart')) || [];
            cart = cart.filter(item => item.id !== id);
            localStorage.setItem('curryLeafCart', JSON.stringify(cart));
            displayCart();
            updateCartBadge();
        }

        function checkout() {
            alert("Thank you! Your order has been received.");
            localStorage.removeItem('curryLeafCart');
            window.location.href = "/";
        }

        displayCart();
    </script>
</body>
</html>
```

------------------------------------------------------------------------

## 5. Server Route

**File:** `src/routes/index.js`

``` javascript
router.get('/cart', (req, res) => {
    res.render('cart');
});
```
