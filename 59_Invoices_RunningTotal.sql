--question: https://ramkedem.com/en/summing-up-values/
--q 59
SELECT 
	I.InvID, 
	InvAmount,
	payid, 
	payDate, 
	PayAmount, 
	SUM(PayAmount) OVER (partition by I.InvId order by PayId ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as RunningPayment, 
	InvAmount- SUM(PayAmount) OVER (partition by I.InvId order by PayId) as RemainingAmount  
FROM Q59_payments as P  join  Q59_Invoices as I on  P.InvId = I.InvId 
