# Mastering SQL Server Audits

A complete workshop and demo repository for learning, teaching, and mastering **SQL Server Audit**.  
This project contains all presentation material, preparation scripts, and hands‑on demos used in the *Mastering SQL Server Audits* training session.

---

## 📂 Repository Structure

### **01 – Documents and Preparation**
This folder contains all materials required before running the audit demos.

- **01 - Preparation of demo databases.sql**  
  Creates and configures the demo databases used throughout the workshop.

- **02 - new sql server logins.sql**  
  Adds sample SQL Server logins for authentication and audit demonstrations.

- **03 - Login & Logout Demo.txt**  
  A helper file describing login/logout actions for testing audit events.

- **Mastering SQL Server Audits.pptx**  
  The full presentation deck used during the workshop.

This folder ensures your SQL Server instance is fully prepared for all subsequent audit scenarios.

---

## **02 – Auditing**
This is the main demo section of the workshop.  
Each subfolder represents a **complete audit scenario**, including:

- Creating the **Server Audit**
- Creating the **Audit Specification**
- Reading audit logs
- Cleaning up the environment

Every scenario follows a consistent structure for easy learning and reproducibility.

---

### **01 – Login & Logout**
Demonstrates how SQL Server Audit captures successful and unsuccessful login/logout events.

Includes:
- Server Audit creation  
- Server Audit Specification  
- Reading audit logs  
- Cleanup script  

---

### **02 – Failed Logins**
Shows how to audit failed login attempts, useful for security monitoring and intrusion detection.

---

### **03 – Monitor Instance Configuration**
Audits changes to instance‑level configuration settings.  
Ideal for compliance, change tracking, and security monitoring.

---

### **04 – Database Auditing – Single Table**
Demonstrates how to audit access to a specific table (`dbo.customers`).  
Includes both server‑level and database‑level audit specifications.

---

### **05 – Database Auditing – Schema & Filter**
Shows how to audit object access with filtering, such as limiting events to a specific schema or object name.

---

### **06 – Prefiltering Techniques**
Advanced audit filtering techniques to reduce noise and improve audit relevance.

Includes:
- Auditing sysadmin activity  
- Object access audit specification  
- Creating an audit information table  
- Collecting audit data  
- Demonstration of audit collection  
- Cleanup script  

This section is ideal for performance‑conscious audit configurations.

---

## 🧩 Solution Files (`.vs` folder)
The `.vs` folder contains Visual Studio solution metadata.  
It is not required for running demos but helps when opening the repository as a SQL Server project in Visual Studio.

---

## 📄 Root Files
- **README.md** — Project documentation.  
- **LICENSE** — Repository license.  
- **.gitignore** — Ignore rules for SQL Server and Visual Studio artifacts.

---

## 🚀 Getting Started

### **Prerequisites**
- SQL Server 2016 or later  
- sysadmin or equivalent permissions  
- Ability to create Server Audits and write to audit file locations  

### **Setup**
1. Run all scripts in **01 – Documents and Preparation**.  
2. Choose any scenario in **02 – Auditing**.  
3. Follow the numbered scripts in each folder.  
4. Use the cleanup script to reset the environment.

---

## 🎯 Purpose of This Repository
This repository is designed for:

- Workshops and conference sessions  
- Internal security training  
- Self‑study for DBAs and security engineers  
- Demonstrating SQL Server Audit capabilities in real environments  

Each scenario is reproducible, isolated, and easy to follow.