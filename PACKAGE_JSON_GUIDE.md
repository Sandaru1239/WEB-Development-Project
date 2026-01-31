# package.json - Complete Guide

## What is package.json?
Think of it like a **recipe card for your app**. It tells Node.js:
- What your project is called
- What version it is
- What tools (dependencies) it needs to run
- How to run your project

## Current package.json Breakdown

```json
{
  "name": "something",
  // The name of your project - identifies your app

  "version": "1.0.0",
  // Current version number (major.minor.patch)
  // Example: 1.0.0 means version 1, no minor updates, no patches

  "description": "",
  // What your app does - currently empty, you can describe it

  "main": "index.js",
  // The main entry point - which file starts the app
  // In your case, you use src/app.js to start (this is slightly outdated)

  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  // Commands you can run from terminal
  // Currently only has a test command that doesn't do anything
  // To use: npm run test

  "keywords": [],
  // Tags for searching (like #hashtags) - currently empty

  "author": "",
  // Your name or team name - currently empty

  "license": "ISC",
  // Legal license for your code
  // ISC = Internet Software Consortium (a permissive license)

  "type": "commonjs",
  // Module system being used
  // commonjs = uses require() and module.exports
  // alternative: "module" = uses import/export

  "dependencies": {
    "ejs": "^4.0.1",
    // EJS templating engine - for creating dynamic HTML
    // ^4.0.1 means version 4.0.1 or higher (auto-update minor versions)

    "express": "^5.2.1"
    // Express web framework - creates your web server and routes
    // ^5.2.1 means version 5.2.1 or higher (auto-update minor versions)
  }
}
```

---

## How to Edit package.json

### 1. Add Project Description
```json
"description": "A restaurant website for The Curry Leaf",
```

### 2. Set Your Name as Author
```json
"author": "Your Name",
```

### 3. Add a Custom Start Command
Add this inside "scripts":
```json
"scripts": {
  "start": "node src/app.js",
  "test": "echo \"Error: no test specified\" && exit 1"
}
```
Now you can run: `npm start`

### 4. Add a Watch/Dev Command
For automatic restart when files change, install nodemon first:
```
npm install --save-dev nodemon
```

Then add to scripts:
```json
"scripts": {
  "start": "node src/app.js",
  "dev": "nodemon src/app.js",
  "test": "echo \"Error: no test specified\" && exit 1"
}
```
Now run: `npm run dev`

### 5. Install a New Package
Command line:
```
npm install express-validator
```

This automatically adds it to "dependencies" in package.json

### 6. Install a Development Tool (Not needed for running app)
Command line:
```
npm install --save-dev eslint
```

Creates a new "devDependencies" section with tools that help during development

---

## Common Packages to Add

### Form Validation
```
npm install express-validator
```

### Database Connection
```
npm install mongoose
npm install mongodb
```

### Environment Variables
```
npm install dotenv
```

### Request Handling
```
npm install body-parser
```

---

## Important Commands

| Command | What it does |
|---------|------------|
| `npm install` | Installs all packages listed in package.json |
| `npm start` | Runs the start script (if defined) |
| `npm run dev` | Runs the dev script (if defined) |
| `npm list` | Shows all installed packages |
| `npm install package-name` | Installs a new package |
| `npm uninstall package-name` | Removes a package |

---

## Don't Edit These Directly in VS Code

- `package-lock.json` - Auto-generated, tracks exact versions
- `node_modules/` - Auto-generated folder with all packages

These are created automatically by npm commands.

---

## Quick Reference

```json
{
  "name": "restaurant-app",           // Your project name
  "version": "1.0.0",                 // Your version
  "description": "Restaurant website", // What it does
  "main": "src/app.js",              // Starting file
  "scripts": {
    "start": "node src/app.js",      // npm start
    "dev": "nodemon src/app.js"      // npm run dev
  },
  "author": "Your Name",             // Your name
  "license": "ISC",                  // License type
  "dependencies": {
    "ejs": "^4.0.1",                // HTML templating
    "express": "^5.2.1"             // Web server
  }
}
```
