SELECT ch."card_name", cc."card_number", tr."amount", tr."date", me."merchant_name", mc."merchant_category_name"
	FROM "transactions" AS tr
	INNER JOIN "credit_card" AS cc ON tr."card_number" = cc."card_number"
	INNER JOIN "card_holder" AS ch ON cc."card_id" = ch."card_id"
	INNER JOIN "merchant" AS me ON tr."merchant_id" = me."merchant_id"
	INNER JOIN "merchant_category" AS mc ON mc."merchant_category_id" = me."merchant_category_id"
	ORDER BY ch."card_name" ;

SELECT CAST(date AS timestamp), amount as "highest_transactions"
FROM transactions
WHERE date >= '2018-01-01 07:00:00' and date <= '2018-12-31 09:00:00'
ORDER BY highest_transactions DESC LIMIT 100;

SELECT ch."card_name", COUNT(tr."transaction_id") AS "Count_Small_Transactions", tr."card_number"
	FROM "transactions" as tr
	INNER JOIN "credit_card" AS cc ON tr."card_number"= cc."card_number"
	INNER JOIN "card_holder" AS ch ON cc."card_id" = ch."card_id"
	WHERE tr."amount"<2
	GROUP BY tr."card_number", ch."card_name"
	ORDER BY "Count_Small_Transactions" DESC;

SELECT me."merchant_name" AS "merchant", mc."merchant_category_name" AS "M_Category", COUNT(tr."transaction_id") AS "Total_Small_Transactions"
	FROM "transactions" AS tr
	INNER JOIN "merchant" AS me ON me."merchant_id" = tr."merchant_id"
	INNER JOIN "merchant_category" mc ON mc."merchant_category_id"=me."merchant_category_id"
	WHERE tr."amount"<2
	GROUP BY me."merchant_name", mc."merchant_category_name"
	ORDER BY "Total_Small_Transactions" DESC
	LIMIT 5

CREATE VIEW TransactionDetails AS 
	SELECT tr."transaction_id",tr."date",tr."amount",me."merchant_name" AS "Merchant_Name", mc."merchant_category_name" AS "Merchant_Category", cc."card_number", ch."card_name" AS "CardHolderName"
	FROM "transactions" AS tr
	INNER JOIN "credit_card" cc ON tr."card_number" = cc."card_number"
	INNER JOIN "card_holder" ch ON ch."card_id" = cc."card_id"
	INNER JOIN "merchant" me ON me."merchant_id" = tr."merchant_id"
	INNER JOIN "merchant_category" mc ON mc."merchant_category_id" = me."merchant_category_id"
	;
SELECT * FROM TransactionDetails ORDER BY "transaction_id";
