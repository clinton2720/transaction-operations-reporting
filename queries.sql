--      Daily transaction volume
--Purpose:  Monitor transaction volume per day
--Used by:  Operations leadership
--Decision  supported: Adjust staffing levels based on volume
SELECT transaction_date, COUNT(*) AS total_transactions
FROM transactions
GROUP BY transaction_date
ORDER BY transaction_date;



--      Daily transaction amount
--Purpose:  Track daily total transaction value
--Used by:  Finance and operations teams
--Decision supported:  Find unusual fluctuations requiring investigations
SELECT transaction_date, SUM(transaction_amount) total_amt
FROM transactions
GROUP BY transaction_date
ORDER BY transaction_date


--      Daily failure rate
--Purpose:  Measure daily transaction failure rates
--Used by:  Operations and risk teams
--Decision supported:  Initiate RCA when failure rates exceed thresholds
SELECT transaction_date, SUM(CASE WHEN transaction_status IN ('Failed', 'Reversed') THEN 1
                                    ELSE 0
                                    END) failed_transactions,
                         ROUND(1.0 * SUM(CASE WHEN transaction_status IN ('Failed', 'Reversed') THEN 1
                                    ELSE 0
                                    END)/COUNT(*), 4) failure_rate
FROM transactions
GROUP BY transaction_date
ORDER BY transaction_date


--      Average processing time per day
--Purpose:  Track average transaction processing time
--Used by:  Operations managers
--Decision supported:  Identify performance bottlenecks to ensure SLA adherence
SELECT transaction_date, AVG(processing_time_seconds) avg_time_secs
FROM transactions
GROUP BY transaction_date
ORDER BY transaction_date



--      Top 5 merchant categories by transaction volume
--Purpose:  Identify merchant categories with highest transaction volumes
--Used by:  Operations and business teams
--Decision supported:  Monitoring and support for high traffic categories
SELECT COUNT(*) transaction_vol, merchant_category AS merch_cat
FROM transactions
GROUP BY merchant_category
ORDER BY transaction_vol DESC
LIMIT 5


--      Regional transaction distribution
--Purpose:  Analyze transaction distribution across regions
--Used by:  Regional operations teams
--Decision supported:  Resource allocation
SELECT COUNT(*) tran_vol, region
FROM transactions
GROUP BY region
ORDER BY tran_vol;


