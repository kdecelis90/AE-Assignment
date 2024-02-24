# Fetch

Hi! Please see details below regarding the assignment given:

1. Review Existing Unstructured Data and Diagram a New Structured Relational Data Model
    - Fetch.sql is in this repository showing the codes written and ran in Microsoft SQL Server. 
    - A relational diagram is also provided as a .png file in this repository.
2. Write a query that directly answers a predetermined question from a business stakeholder
   - The queries are located in the same .sql file.
   - I have identified that data issues hinder me the ability to answer any of the business questions. I have included some notes in the .sql file to help guide the reviewer about my thought process.
3. Evaluate Data Quality Issues in the Data Provided
   - As mentioned, the queries above helped me identify four data issues.
4. Communicate with Stakeholders
   - I found Slack to be a great tool of communication within the organizations I have been in. Using Slack, below is what I am going to convey:

     Hi <name>! I wanted to update you on a crucial aspect of our ongoing efforts to understand customer purchase behavior and enhance our data assets. My team has created three tables:
     1. Users - Provides information on user sign-up, recency, and active status.
     2. Brands - Contains detailed brand information at an item level.
     3. Receipts - Presents data at a receipt level, including scan date, bonus points earned, amount spent, and more.
    
    While delving into the datasets, we uncovered a few critical data issues:
    1. Barcode Missing in Receipts: Out of 4.8K records in the Receipts dataset, a staggering 2.75K lack barcodes. This discrepancy significantly impacts our ability to derive insights.
    2. Incomplete Brand Data: The Brand dataset appears incomplete, limited to records with barcodes starting with '51'. We know there should be more data available, considering the barcodes present in the Receipts dataset.
    3. Missing Records with Reward Status: The Receipts dataset lacks records with reward status "Accepted" or "Rejected," showing only "Finished" status. 

 Next Steps:
 Addressing these issues is our top priority, as they currently impede our ability to answer key business questions regarding user behavior. Our plan is to collaborate closely with our data engineers to trace the data flow, understand the root causes, and ideally obtain retroactive data.
 I'm mindful that additional issues may surface during our investigation, and we are committed to a thorough examination to ensure the integrity of our data.
  
  If you have any questions or insights regarding the issues outlined above, please feel free to reach out. Rest assured, we are actively working on these matters and will provide key stakeholders with updates to keep them informed. Thank you!
