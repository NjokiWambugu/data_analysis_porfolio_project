# The Cosy Shop's Sales Analysis

### Project Overview

This data analysis project takes a personal retrospective look at an online store I founded in the year 2021. Through the lens of an analyst, we will time travel one last time to explore the shop's data. The purpose of this project is to uncover hidden patterns and interaction between product sold and the customer behaviour. This will then inform strategic marketing decisions and provide a deeper
understanding of the business' performance during it's operational period. 

![Alt text](TCStableaudashboard.png)

---
### Table of Contents
- [Data Sources](#data-sources)
- [Tools](#tools)
- [Data Cleaning/Preparation](#data-preparation)
- [Exploratory Data Analysis(EDA)](#exploratory-data-analysis)
- [Data Analysis](#data-analysis)
- [Results/Findings](#results/findings)
- [Recommendations](#recommendations)
- [Limitations](#limitations)
- [References](#references)
 
---

### Data Sources

The primary data for this analysis is 'Rawdata.xlsl', containing two worksheets; Products and Sales. It was intitially collected but was later refined by extending the entries to provide a more comprehensive dataset.

### Tools
In this project, I use a combination of four tools; Python, Excel, Tableau, and MySQL queries to showcase technical versatility.

- **Excel**
  - Data cleaning and Organization
  - Analysis
  - Visualization
- **Python(Pandas, Matplotlib, Seaborn)**
  - Data Preprosessing
  - Exploratory Data Analysis
  - Data Visualization
- **Tableau**
  - Visualization
- **MySQL**
  - Exploratory Data Analysis Questions SQL queries

### Data Cleaning/Preparation

I began by cleaning the raw data in Excel, using functions like removing duplicates and applying VLOOKUP to create a product_name column. This cleaned dataset was then used for further analysis and visualizations in Excel and later imported into MySQL for writing queries to answer exploratory data analysis (EDA) questions. Additionally, the data was imported into Tableau for dashboard creation.

For Python, I split the raw data into two CSV files; Products and Sales, which were then merged, cleaned, analyzed, and visualized in Jupyter Notebooks using Matplotlib and Seaborn.


### Exploratory Data Analysis(EDA)

EDA involved exploring the data looking for important findings on top of some key questions;

 1. What is the distribution of products sold?
 2. What are the top 10 customer locations based on sales volume?
 3. What is the average amount spent per customer location?
 4. What is the best performing product category?
 5. What is the top-selling product per customer location?
 6. What was the monthly bestseller?

### Data Analysis
  - Used Excel to perform in-depth data slicing and analysis, applying pivot tables, advanced formulas, and custom filters. I calculated metrics like sale distribution across different products and categories, average spend per location and average sale per location.
  - I answered the key EDA questions like " What was the monthly bestseller" using MySQL queries. A query for this particular
 question is;

```
SELECT selling_month, product_name, total_sold
FROM(SELECT MONTHNAME(STR_TO_DATE(s.date_of_purchase, '%e-%b-%Y')) AS selling_month,
        p.product_name,
        COUNT(*) AS total_sold,
        ROW_NUMBER() OVER (PARTITION BY MONTHNAME(STR_TO_DATE(s.date_of_purchase, '%e-%b-%Y'))
       ORDER BY COUNT(*) DESC)  AS row_rank
        From sales s
        JOIN products p ON s.product_ID = p.product_ID
        GROUP BY MONTHNAME(STR_TO_DATE(s.date_of_purchase, '%e-%b-%Y')), p.product_name
        ) AS monthly_sales
        WHERE row_rank = 1;
```
 - Used python's Jupyter notebook as a standalone tool and did everything from merging files, cleaning, data analysis and visualizations to answer the key EDA questions. For EDA question "Bestselling product per location?" this code will display location, product and quantity sold in descending order 

 ```# Top selling product per location
top_sold = merged_data.groupby(["customer_location", "product_name"]).size().reset_index(name="total_sold")
top_seller = top_sold.loc[top_sold.groupby(["customer_location"])["total_sold"].idxmax()].sort_values(
    by="total_sold", ascending = False).reset_index(drop=True)
top_seller
```
- Visualized the data in Tableau and created an interactive dashboard to validate key patterns from the other tools.

---
        
### Results/Findings
  Here are the answers to the EDA questions using visualizations from various used in this analysis ![Alt text](EDAvisualizations.png)
  
  Other findings:
1. Product visibility and engagement decline after sustained exposure, indicating noticeable fatigue over time. 
2. The clothing category, especially knitwear, consistently outperforms other product lines.
3. Nairobi emerges as the top-performing region, significantly surpassing other locations.
4. Retention rates are relatively low, highlighting an opportunity to improve long-term customer engagement.
 
### Recommendations

1. Diversify and implement fast product rotation for products that are performing well, such as sweaters, diffusers, candles, and cardigans.
2. Increase marketing campaigns in Westlands, Thika, Donholm, and Kileleshwa, as these areas show higher buying activity and spending.
3. Focus on increasing customer engagement through interactive content like polls, Q&A sessions, and user-generated content to build - 
stronger brand loyalty and foster a community feel, which can convert followers into repeat customers.

### Limitations
1. Limited historical data made it impossible to identify longterm trends and seasonal patterns.
2. Lack of user feedback to help validate the findings as the shop nolonger operates.
3. The data is oudated and the findings may no longer stand as everything from industry's landscape, customer preferences and product 
 popularity might have significantly changed in the last few years.

### References
 - SQL for Business by Werty
 - Data Science with Jupyter by Prateek Gupta



