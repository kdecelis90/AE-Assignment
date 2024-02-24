
/*****************************************************/
/*Import receipts.json to a table*/
--drop table Exercise.dbo.Receipts
DECLARE @JSON varchar(max)
SELECT @JSON=BulkColumn
FROM OPENROWSET(BULK 'C:\Users\WangAr01\Downloads\receipts.json', SINGLE_CLOB) AS import
SELECT DISTINCT
	id.[$oid] as id
	,receipts.bonusPointsEarned
	,receipts.bonusPointsEarnedReason
	,DATEADD(ms, CAST(createDate.[$date] AS BIGINT) %(3600*24*1000), 
		DATEADD(DAY, CAST(createDate.[$date] AS BIGINT)/(3600*24*1000), '1970-01-01 00:00:00.0')) createDate
	,DATEADD(ms, CAST(dateScanned.[$date] AS BIGINT) %(3600*24*1000), 
		DATEADD(DAY, CAST(dateScanned.[$date] AS BIGINT)/(3600*24*1000), '1970-01-01 00:00:00.0')) dateScanned
	,DATEADD(ms, CAST(finishedDate.[$date] AS BIGINT) %(3600*24*1000), 
		DATEADD(DAY, CAST(finishedDate.[$date] AS BIGINT)/(3600*24*1000), '1970-01-01 00:00:00.0')) finishedDate
	,DATEADD(ms, CAST(modifyDate.[$date] AS BIGINT) %(3600*24*1000), 
		DATEADD(DAY, CAST(modifyDate.[$date] AS BIGINT)/(3600*24*1000), '1970-01-01 00:00:00.0')) modifyDate
	,DATEADD(ms, CAST(pointsAwardedDate.[$date] AS BIGINT) %(3600*24*1000), 
		DATEADD(DAY, CAST(pointsAwardedDate.[$date] AS BIGINT)/(3600*24*1000), '1970-01-01 00:00:00.0')) pointsAwardedDate
	,receipts.pointsEarned
	,DATEADD(ms, CAST(purchaseDate.[$date] AS BIGINT) %(3600*24*1000), 
		DATEADD(DAY, CAST(purchaseDate.[$date] AS BIGINT)/(3600*24*1000), '1970-01-01 00:00:00.0')) purchaseDate
	,receipts.purchasedItemCount
	,rewardsReceiptItemList.barcode 
	,rewardsReceiptItemList.[description]
	,rewardsReceiptItemList.finalPrice 
	,rewardsReceiptItemList.itemPrice 
	,rewardsReceiptItemList.needsFetchReview 
	,rewardsReceiptItemList.partnerItemid 
	,rewardsReceiptItemList.preventTargetGapPoints 
	,rewardsReceiptItemList.quantityPurchased 
	,rewardsReceiptItemList.userFlaggedBarcode 
	,rewardsReceiptItemList.userFlaggedNewItem 
	,rewardsReceiptItemList.userFlaggedPrice 
	,rewardsReceiptItemList.userFlaggedQuantity 
	,receipts.rewardsReceiptStatus
	,receipts.totalSpent
	,receipts.userId 
INTO Exercise.dbo.Receipts
FROM OPENJSON(CONCAT('[', REPLACE(@JSON, CONCAT('}', CHAR(10), '{'), '},{'), ']')) 
WITH
(
    _id NVARCHAR(max) as JSON,
    bonusPointsEarned FLOAT,
    bonusPointsEarnedReason NVARCHAR(100),
    createDate NVARCHAR(max) as JSON,
    dateScanned NVARCHAR(max) as JSON,
	finishedDate NVARCHAR(max) as JSON,
	modifyDate NVARCHAR(max) as JSON,
	pointsAwardedDate NVARCHAR(max) as JSON,
	pointsEarned FLOAT,
	purchaseDate NVARCHAR(max) as JSON,
	purchasedItemCount FLOAT,
	rewardsReceiptItemList NVARCHAR(max) as JSON,
	rewardsReceiptStatus NVARCHAR(200),
	totalSpent FLOAT,
	userId NVARCHAR(100)
) as receipts
CROSS APPLY OPENJSON(_id)
with
(
[$oid] NVARCHAR(100)
) as id
CROSS APPLY OPENJSON(createDate)
with
(
[$date] NVARCHAR(100)
) as createDate
CROSS APPLY OPENJSON(dateScanned)
with
(
[$date] NVARCHAR(100)
) as dateScanned
CROSS APPLY OPENJSON(finishedDate)
with
(
[$date] NVARCHAR(100)
) as finishedDate
CROSS APPLY OPENJSON(modifyDate)
with
(
[$date] NVARCHAR(100)
) as modifyDate
CROSS APPLY OPENJSON(pointsAwardedDate)
with
(
[$date] NVARCHAR(100)
) as pointsAwardedDate
CROSS APPLY OPENJSON(purchaseDate)
with
(
[$date] NVARCHAR(100)
) as purchaseDate
CROSS APPLY OPENJSON(rewardsReceiptItemList)
with
(
barcode nvarchar(100)
,description nvarchar(max)
,finalPrice float
,itemPrice float
,needsFetchReview bit
,partnerItemid float
,preventTargetGapPoints bit
,quantityPurchased float
,userFlaggedBarcode float
,userFlaggedNewItem bit
,userFlaggedPrice float
,userFlaggedQuantity float
) as rewardsReceiptItemList


/*****************************************************/
/*Import users.json to a table*/
DECLARE @JSON2 varchar(max)
SELECT @JSON2=BulkColumn
FROM OPENROWSET(BULK 'C:\Users\WangAr01\Downloads\users.json', SINGLE_CLOB) AS import
SELECT DISTINCT
	id.[$oid] as id
	,users.active
	,DATEADD(ms, CAST(createdDate.[$date] AS BIGINT) %(3600*24*1000), 
		DATEADD(DAY, CAST(createdDate.[$date] AS BIGINT)/(3600*24*1000), '1970-01-01 00:00:00.0')) as createdDate
	,DATEADD(ms, CAST(lastLogin.[$date] AS BIGINT) %(3600*24*1000), 
		DATEADD(DAY, CAST(lastLogin.[$date] AS BIGINT)/(3600*24*1000), '1970-01-01 00:00:00.0')) as lastLogin
	,users.[role]
	,users.signUpSource
	,users.[state]
INTO Exercise.dbo.Users
FROM OPENJSON(CONCAT('[', REPLACE(@JSON2, CONCAT('}', CHAR(10), '{'), '},{'), ']')) 
WITH
(
    _id NVARCHAR(max) as JSON,
	active bit,
    createdDate NVARCHAR(max) as JSON,
	lastLogin NVARCHAR(max) as JSON,
	[role] NVARCHAR(100),
	signUpSource NVARCHAR(100),
    [state] NVARCHAR(10)
) as users
CROSS APPLY OPENJSON(_id)
with
(
[$oid] NVARCHAR(100)
) as id
CROSS APPLY OPENJSON(createdDate)
with
(
[$date] NVARCHAR(100)
) as createdDate
OUTER APPLY OPENJSON(lastLogin)
with
(
[$date] NVARCHAR(100)
) as lastLogin


/*****************************************************/
/*Import brands.json to a table*/
DECLARE @JSON3 varchar(max)
SELECT @JSON3=BulkColumn
FROM OPENROWSET(BULK 'C:\Users\WangAr01\Downloads\brands.json', SINGLE_CLOB) AS import
SELECT DISTINCT
	id.[$oid] as id
	,brands.barcode
	,brands.category
	,brands.categoryCode
	,cpg.[$ref] as cpg_ref
	,[$id].[$oid] as cpg_id
	,brands.[name]
	,topBrand
INTO Exercise.dbo.Brands
FROM OPENJSON(CONCAT('[', REPLACE(@JSON3, CONCAT('}', CHAR(10), '{'), '},{'), ']')) 
WITH
(
    _id NVARCHAR(max) as JSON,
    barcode NVARCHAR(100),
	[name] NVARCHAR(100),
	category NVARCHAR(100),
	categoryCode NVARCHAR(100),
	cpg NVARCHAR(max) as JSON,
	brandCode NVARCHAR(max) as JSON,
	topBrand NVARCHAR(100)
) as brands
CROSS APPLY OPENJSON(_id)
with
(
[$oid] NVARCHAR(100)
) as id
OUTER APPLY OPENJSON(cpg)
with
(
[$ref] NVARCHAR(100)
,[$id] NVARCHAR(max) as JSON
) as cpg
OUTER APPLY OPENJSON([$id])
with
(
[$oid] NVARCHAR(100)
) as [$id]



/**************************************************************/
/*Data issues found*/
--Duplicated records found after building Users table: As a resolution, the table has to be recreated by implementing SELECT DISTINCT.

--Some barcodes are associated with multiple different items. Barcodes below. 
select barcode, count(distinct category) from Exercise.dbo.Brands group by barcode having count(*)>1
select * from Exercise.dbo.Brands where barcode in 
	(select barcode from Exercise.dbo.Brands group by barcode having count(distinct category)>1)
	order by barcode

--Barcodes in Receipts table are mostly NULLs, or are not found in the Brands table. 
	--Question on top brands based on receipts cannot be answered with the data that we have right now.
with recentmo as
(select DATEADD(month, -1, max(datescanned)) startdt, max(datescanned) enddt
from
Exercise.dbo.Receipts)

select top 5
b.[name] as Brand
,count(distinct r.id) ReceiptsScanned
from
Exercise.dbo.Receipts r join
recentmo on r.dateScanned between recentmo.startdt and recentmo.enddt left join
Exercise.dbo.Brands b on r.barcode=b.barcode 
group by b.[name] order by ReceiptsScanned desc

--Only the value 'FINISHED' is available in the Receipts table. Questions regarding rewardsReceiptStatus cannot be answered right now.
select 
[rewardsReceiptStatus]
,AVG([totalSpent]) avgspend
from Exercise.dbo.Receipts
group by [rewardsReceiptStatus] order by 2 desc




/************************************************************************************************/
--Scratch
select barcode, count(*) from Exercise.dbo.Receipts group by barcode order by 2 desc
select barcode, count(*) from Exercise.dbo.Brands group by barcode order by 2 desc
select id,userid from Exercise.dbo.Receipts where id<> userid
select * from Exercise.dbo.Users where id = '5ff36c750a7214ada100058f'
select userFlaggedBarcode, count(*) from Exercise.dbo.Receipts group by userFlaggedBarcode having count(*)>1
select * from Exercise.dbo.Receipts r join Exercise.dbo.Brands b on coalesce(r.barcode,r.userFlaggedBarcode)=b.barcode
select * from Exercise.dbo.Brands 
select * from Exercise.dbo.Receipts 
use Exercise
SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='Brands'


