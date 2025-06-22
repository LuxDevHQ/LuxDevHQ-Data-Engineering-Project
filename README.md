### LuxDevHQ Data Engineering Project

During Weeks 14 and 15 of the LuxDevHQ Bootcamp, participants work on individual projects before the finalists proceed to their final capstone project. These projects are designed to reflect real-world applications. Each cohort is assigned its own set of projects, although in some cases, finalists may repeat previous ones or tackle entirely new challenges.


### Why Do We Encourage Dedicating These Weeks to Projects?

#### 1.  Hands-On Exposure to Real-World Challenges
These projects simulate actual industry problems, allowing learners to apply what they’ve learned in a meaningful way.

They help bridge the gap between theoretical knowledge and practical implementation.

---

#### 2. Iterative Learning Before the Capstone
Learners get to experiment, fail safely, and refine their skills before the high-stakes final project.

This improves problem-solving, collaboration, and technical decision-making under semi-real conditions.

---

#### 3. Portfolio & Confidence Booster
Completing real-world projects adds serious value to a learner’s portfolio and boosts their confidence.

It also prepares them to talk about practical experience in interviews — something many bootcamps struggle to offer at this depth.

---
### **CH03-2025 Project 101: A Real-Time Crypto Data Pipeline from Binance API to Cassandra with CDC and Visualization.**

Build a real-time data pipeline that pulls data from the Binance API, stores it in PostgreSQL or MySQL, replicates changes to Cassandra via Change Data Capture (CDC), and visualizes live metrics (e.g., top 5 performing cryptocurrencies by 24h percentage gain) using Grafana dashboards.
---
### ✅ Phase 1: Binance API Integration

Extract real-time market data from, https://www.binance.com/en/binance-api

| **Data Type**         | **Endpoint**                  |
|------------------------|-------------------------------|
| Latest prices          | `/api/v3/ticker/price`        |
| Order book             | `/api/v3/depth`               |
| Recent trades          | `/api/v3/trades`              |
| Klines (candlesticks)  | `/api/v3/klines`              |
| 24h Ticker stats       | `/api/v3/ticker/24hr`         |
---
#### **Phase 1:**
Store the incoming Binance data in a structured format within PostgreSQL or MySQL, using proper indexing and timestamps to ensure efficient and reliable querying. Use this relational layer as a clean, queryable staging area for further replication.
---
#### **Phase 2:**
Implement a Change Data Capture (CDC) mechanism—such as Debezium or custom timestamp tracking—to detect new or updated rows and replicate them to Cassandra. This allows scalable storage and fast access to time-series data across crypto symbols.

---
#### **Phase 3:**
Connect the data to Grafana, and create dashboards that visualize key crypto metrics in real time. Focus on displaying the top 5 cryptocurrencies by 24h percentage gain, candlestick patterns, and price trends for monitoring and insight generation.

---



