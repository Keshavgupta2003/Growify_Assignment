# Growify_Assignment
Before the data was loaded into the database, the following Python/Pandas preprocessing steps were performed:

Handling Missing Values:

Text Columns: All null values in categorical columns (like brand or campaign_name) were filled with "Unknown" to maintain data integrity during grouping.

Numerical Columns: Missing values in metrics like spend, clicks, or sales were filled with 0 to prevent calculation errors.

Deduplication: Identified and removed duplicate rows to ensure that spend and sales figures are not artificially inflated.

Type Casting: Ensured date columns were converted to proper datetime objects and financial columns were set as floats.
