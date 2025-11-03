# LuxDevHQ DataEngineering Intership Month Two Project: Build and Publish a Synthetic Data Generator Library

### **Objective**
The goal of this assignment is to design, implement, and publish a **Python-based data generation library** that can create realistic synthetic datasets for testing, analytics, and machine learning experiments.

The library should be modular, reproducible, and deployable to the **Python Package Index (PyPI)**.

---

## 🧩 Scope of Work
You will build a reusable and modular Python package named **`datagen`**, capable of generating the following datasets:

1. **Profile Data** – user details such as name, email, gender, address, date of birth, and geographic coordinates.  
2. **Salary Data** – job titles, employee levels (e.g., Junior, Mid, Senior), base pay, bonus, and total compensation.  
3. **Region Data** – region identifiers, countries, time zones, and assigned managers.  
4. **Cars Data** – vehicle make, model, year, color, transmission type, and price.  

Each dataset should be generated **deterministically** (i.e., reproducible given the same random seed).

---

## ⚙️ Core Requirements

### **1. Package Structure**
Your package should be well-structured and modular. Example layout:

