CREATE DATABASE BANGHE
GO

USE BANGHE
GO

CREATE TABLE ITEM_GROUP
(	
	ITEM_GROUP_ID INT IDENTITY(1,1) PRIMARY KEY,
	PARENT_ITEM_GROUP_ID INT,
	ITEM_GROUP_NAME NVARCHAR(250)
)

CREATE TABLE ITEMS
(
	ITEM_ID INT IDENTITY(1,1) PRIMARY KEY,
	ITEM_GROUP_ID INT FOREIGN KEY (ITEM_GROUP_ID) REFERENCES ITEM_GROUP (ITEM_GROUP_ID),
	SUPPLIER_ID INT FOREIGN KEY (SUPPLIER_ID) REFERENCES SUPPLIER (SUPPLIER_ID),
	ITEM_NAME NVARCHAR(250),
	ITEM_IMAGE NVARCHAR(MAX),
	ITEM_DESCRIPTION NVARCHAR(MAX),
	ITEM_PRICE FLOAT
)

CREATE TABLE SUPPLIER
(	
	SUPPLIER_ID INT IDENTITY(1,1) PRIMARY KEY,
	SUPPLIER_NAME NVARCHAR(250),
	SUPPLIER_ADDRESS NVARCHAR(250),
	SUPPLIER_PHONE VARCHAR(10)
)

CREATE TABLE ORDERS
(
	ORDER_ID INT IDENTITY(1,1) PRIMARY KEY,
	ORDER_NAME NVARCHAR(250),
	CREATED_DATE DATETIME,
	PHONE VARCHAR(10),
	ADDRESS NVARCHAR(250)
)

CREATE TABLE ORDER_DETAIL
(
	ORDER_DETAIL_ID INT IDENTITY(1,1) PRIMARY KEY,
	ORDER_ID INT FOREIGN KEY (ORDER_ID) REFERENCES ORDERS (ORDER_ID),
	ITEM_ID INT FOREIGN KEY (ITEM_ID) REFERENCES ITEMS (ITEM_ID),
	QUANTITY INT,
	PRICE FLOAT,
	IMAGE NVARCHAR(MAX), 
	TOTAL FLOAT
)

CREATE TABLE ADMIN
(
	ADMIN_ID INT IDENTITY(1,1) PRIMARY KEY,
	PASSWORD NVARCHAR(100),
	NAME NVARCHAR(100),
	PHONE NVARCHAR(250),
	EMAIL NVARCHAR(100),
	IMAGE NVARCHAR(MAX)
)
GO

CREATE PROCEDURE [dbo].[sp_item_all]
AS
    BEGIN
        SELECT *
        FROM ITEMS 
    END;
GO

CREATE PROCEDURE [dbo].[sp_item_create]
(@ITEM_ID             INT, 
 @ITEM_GROUP_ID       INT, 
 @SUPPLIER_ID         INT,
 @ITEM_IMAGE         VARCHAR(MAX), 
 @ITEM_NAME           NVARCHAR(250), 
 @ITEM_PRICE          float,
 @ITEM_DESCRIPTION	  NVARCHAR(MAX)
)
AS
    BEGIN
      INSERT INTO ITEMS
                (ITEM_ID, 
				 ITEM_GROUP_ID, 
				 SUPPLIER_ID,
				 ITEM_NAME, 
				 ITEM_IMAGE,   
				 ITEM_PRICE,         
				 ITEM_DESCRIPTION
                )
                VALUES
                (@ITEM_ID,
				 @ITEM_GROUP_ID,
				 @SUPPLIER_ID,
				 @ITEM_NAME,
				 @ITEM_IMAGE,
				 @ITEM_PRICE,
				 @ITEM_DESCRIPTION
                );
        SELECT '';
    END;
GO

CREATE PROCEDURE [dbo].[sp_item_del]
(@ITEM_ID INT)
AS
BEGIN
	DELETE ITEMS WHERE ITEM_ID = @ITEM_ID
END
GO

CREATE PROCEDURE [dbo].[sp_item_get_by_id]
(@ITEM_ID INT)
AS
    BEGIN
        SELECT *
		FROM ITEMS
        WHERE  ITEM_ID = @ITEM_ID;
    END;
GO

CREATE PROCEDURE [dbo].[sp_item_update]
(@ITEM_ID             INT, 
 @ITEM_GROUP_ID       INT, 
 @SUPPLIER_ID         INT,
 @ITEM_IMAGE         VARCHAR(MAX), 
 @ITEM_NAME           NVARCHAR(250), 
 @ITEM_PRICE          float,
 @ITEM_DESCRIPTION	  NVARCHAR(MAX)
)
AS
BEGIN
	UPDATE ITEMS SET ITEM_NAME = @ITEM_NAME, ITEM_PRICE = @ITEM_PRICE, ITEM_IMAGE = @ITEM_IMAGE, ITEM_GROUP_ID = @ITEM_GROUP_ID, SUPPLIER_ID = @SUPPLIER_ID, ITEM_DESCRIPTION = @ITEM_DESCRIPTION
	WHERE ITEM_ID = @ITEM_ID
END
GO

CREATE PROCEDURE [dbo].[sp_item_search]
(@page_index  INT, 
 @page_size   INT,
 @item_group_id INT)
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF @page_size <> 0 AND @item_group_id <> NULL
            BEGIN
                SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY ITEM_NAME ASC)) AS RowNumber, 
                              i.item_id, 
                              i.item_group_id, 
							  i.SUPPLIER_ID,
                              i.item_name , 
                              i.item_image, 
                              i.item_price,
							  i.item_description
                        INTO #Results1
                        FROM ITEMS AS i
					    WHERE i.item_group_id = @item_group_id;                   
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
		IF(@item_group_id IS NULL)
			BEGIN
                SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY item_name ASC)) AS RowNumber, 
                              i.item_id, 
                              i.item_group_id, 
							  i.SUPPLIER_ID, 
                              i.item_name , 
                              i.item_image, 
                              i.item_price,
							  i.item_description
                        INTO #Results3
                        FROM ITEMS AS i					              
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results3;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results3
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results3; 
            END;
			
        ELSE
            BEGIN
                SET NOCOUNT ON;
                         SELECT(ROW_NUMBER() OVER(
                               ORDER BY item_name ASC)) AS RowNumber, 
                              i.item_id, 
                              i.item_group_id,  
							  i.SUPPLIER_ID,
                              i.item_name , 
                              i.item_image, 
                              i.item_price,
							  i.item_description
                        INTO #Results2
                        FROM ITEMS AS i
						WHERE i.item_group_id = @item_group_id;  
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;
                        DROP TABLE #Results2;
        END;

    END;
GO

CREATE PROCEDURE [dbo].[sp_item_group_all]
AS
    BEGIN
        SELECT *
        FROM ITEM_GROUP
    END;
GO

CREATE PROCEDURE [dbo].[sp_item_group_create]
(@ITEM_GROUP_ID INT, 
 @PARENT_ITEM_GROUP_ID INT,
 @ITEM_GROUP_NAME NVARCHAR(250)
)
AS
    BEGIN
      INSERT INTO [ITEM_GROUP]
                (
				 	ITEM_GROUP_ID, 
					PARENT_ITEM_GROUP_ID,
					ITEM_GROUP_NAME
				)
                VALUES
                (
					@ITEM_GROUP_ID, 
					@PARENT_ITEM_GROUP_ID,
					@ITEM_GROUP_NAME         
				);
        SELECT '';
    END;
GO

CREATE PROCEDURE [dbo].[sp_item_group_del]
(@ITEM_GROUP_ID  INT)
AS
    BEGIN
		DELETE FROM ITEM_GROUP WHERE ITEM_GROUP_ID = @ITEM_GROUP_ID;
        SELECT '';
    END;
GO

CREATE PROCEDURE [dbo].[sp_item_group_update]
(@ITEM_GROUP_ID INT, 
 @PARENT_ITEM_GROUP_ID INT,
 @ITEM_GROUP_NAME NVARCHAR(250)
)
AS
BEGIN
	UPDATE ITEM_GROUP SET PARENT_ITEM_GROUP_ID = @PARENT_ITEM_GROUP_ID, ITEM_GROUP_NAME = @ITEM_GROUP_NAME
	WHERE ITEM_GROUP_ID = @ITEM_GROUP_ID
END
GO

CREATE PROCEDURE [dbo].[sp_item_group_get_by_id]
(@ITEM_GROUP_ID  INT)
AS
    BEGIN
		SELECT * FROM ITEM_GROUP WHERE ITEM_GROUP_ID = @ITEM_GROUP_ID;
    END;
GO

CREATE PROCEDURE [dbo].[sp_item_group_search] 
(@page_index  INT, 
 @page_size   INT)
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF @page_size <> 0
            BEGIN
                SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY item_group_name ASC)) AS RowNumber, 
                              i.item_group_id, 
							  i.item_group_name
                        INTO #Results1
                        FROM ITEM_GROUP AS i
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
        END;
GO

CREATE PROCEDURE [dbo].[sp_order_create]
(@ORDER_ID INT, 
 @ORDER_NAME NVARCHAR(250), 
 @CREATED_DATE DATETIME,  
 @PHONE VARCHAR(10),
 @ADDRESS NVARCHAR(250),
 @listjson_chitiet NVARCHAR(MAX)
)
AS
    BEGIN
        INSERT INTO ORDERS
                (ORDER_ID, 
				 ORDER_NAME, 
				 CREATED_DATE,  
				 PHONE,
				 ADDRESS
                )
                VALUES
                (@ORDER_ID, 
				 @ORDER_NAME, 
				 GETDATE(),  
				 @PHONE,
				 @ADDRESS
                );
                IF(@listjson_chitiet IS NOT NULL)
                    BEGIN
                        INSERT INTO ORDER_DETAIL
                        (ORDER_DETAIL_ID, 
                         ORDER_ID, 
                         ITEM_ID, 
                         QUANTITY,
						 PRICE,
						 IMAGE,
						 TOTAL
                        )
                               SELECT JSON_VALUE(p.value, '$.ORDER_DETAIL_ID'), 
                                      @ORDER_ID, 
                                      JSON_VALUE(p.value, '$.ITEM_ID'), 
									  JSON_VALUE(p.value, '$.QUANTITY'),
                                      JSON_VALUE(p.value, '$.PRICE'),
									  JSON_VALUE(p.value, '$.IMAGE'),
									  JSON_VALUE(p.value, '$.TOTAL') 
                               FROM OPENJSON(@listjson_chitiet) AS p;
                END;
        SELECT '';
    END;
GO

CREATE PROCEDURE [dbo].[sp_order_delete]
(@ORDER_ID INT)
AS
    BEGIN
		DELETE FROM ORDER_DETAIL WHERE ORDER_ID = @ORDER_ID;
		DELETE FROM ORDERS WHERE ORDER_ID = @ORDER_ID;
        SELECT '';
    END;
GO

CREATE PROCEDURE [dbo].[sp_order_get_by_id]
(@ORDER_ID INT)
AS
    BEGIN
        SELECT u.ORDER_ID, 
			   u.ORDER_NAME, 
			   u.CREATED_DATE,  
			   u.PHONE,
			   u.ADDRESS,
        (
            SELECT p.ORDER_DETAIL_ID, 
                   p.ORDER_ID,
				   i.ITEM_IMAGE,
				   i.ITEM_NAME,
				   i.ITEM_PRICE,
                   p.ITEM_ID,
				   0 as status,
				   p.QUANTITY*i.ITEM_PRICE as total,
                   p.QUANTITY
				   FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
        ) AS chi_tiet
        FROM ORDERS AS u,
             ORDER_DETAIL AS p,
			 ITEMS as i WHERE u.ORDER_ID = p.ORDER_ID and i.ITEM_ID = p.ITEM_ID
        AND u.ORDER_ID = @ORDER_ID
    END;
GO

CREATE PROCEDURE [dbo].[sp_order_search] 
(@page_index  INT, 
 @page_size   INT,
 @ORDER_NAME Nvarchar(250),
 @ADDRESS Nvarchar(250)
)
AS
    BEGIN
        DECLARE @RecordCount BIGINT;
        IF(@page_size <> 0)
            BEGIN
                SET NOCOUNT ON;
                        SELECT(ROW_NUMBER() OVER(
                              ORDER BY ORDER_NAME ASC)) AS RowNumber, 
                              h.ORDER_ID, 
                              h.ORDER_NAME,
							  h.CREATED_DATE,
							  h.ADDRESS,
							  h.PHONE
                        INTO #Results1
                        FROM ORDERS AS h
					    WHERE  (@ORDER_NAME = '' Or h.ORDER_NAME like N'%'+@ORDER_NAME+'%') and	
						(@ADDRESS = '' Or h.ADDRESS like N'%'+@ADDRESS+'%');                  
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results1;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results1
                        WHERE ROWNUMBER BETWEEN(@page_index - 1) * @page_size + 1 AND(((@page_index - 1) * @page_size + 1) + @page_size) - 1
                              OR @page_index = -1;
                        DROP TABLE #Results1; 
            END;
            ELSE
            BEGIN
                SET NOCOUNT ON;
                         SELECT(ROW_NUMBER() OVER(
                              ORDER BY ORDER_NAME ASC)) AS RowNumber, 
                              h.ORDER_ID, 
                              h.ORDER_NAME,
							  h.CREATED_DATE, 
							  h.ADDRESS,
							  h.PHONE
                        INTO #Results2
                        FROM ORDERS AS h
					    WHERE  (@ORDER_NAME = '' Or h.ORDER_NAME like N'%'+@ORDER_NAME+'%') and	
						(@ADDRESS = '' Or h.ADDRESS like N'%'+@ADDRESS+'%');                       
                        SELECT @RecordCount = COUNT(*)
                        FROM #Results2;
                        SELECT *, 
                               @RecordCount AS RecordCount
                        FROM #Results2;
                        DROP TABLE #Results2;
        END;
    END;
GO

CREATE PROCEDURE [dbo].[sp_order_update]
(@ORDER_ID INT, 
 @ORDER_NAME NVARCHAR(250), 
 @ADDRESS NVARCHAR(250),
 @PHONE	VARCHAR(10),
 @CREATED_DATE DATETIME,
 @listjson_chitiet NVARCHAR(MAX)
)
AS
    BEGIN
        UPDATE ORDERS
                SET ORDER_NAME = @ORDER_NAME, ADDRESS = @ADDRESS, PHONE = @PHONE, CREATED_DATE = @CREATED_DATE
				WHERE ORDER_ID = @ORDER_ID;
                IF(@listjson_chitiet IS NOT NULL)
					BEGIN
                        DELETE ORDER_DETAIL WHERE ORDER_ID IN
						(SELECT JSON_VALUE(p.value, '$.ORDER_ID')    
                               FROM OPENJSON(@listjson_chitiet) AS p)
						AND ORDER_DETAIL_ID NOT IN 
						(SELECT JSON_VALUE(p.value, '$.ORDER_DETAIL_ID')    
                               FROM OPENJSON(@listjson_chitiet) AS p)
					END;
                    BEGIN
                        UPDATE ORDER_DETAIL
                        SET
                            ORDER_ID = JSON_VALUE(p.value, '$.ORDER_ID'), 
							ITEM_ID = JSON_VALUE(p.value, '$.ITEM_ID'), 
							QUANTITY = JSON_VALUE(p.value, '$.QUANTITY'),
							PRICE = JSON_VALUE(p.value, '$.PRICE'),
							IMAGE = JSON_VALUE(p.value, '$.IMAGE'),
							TOTAL = JSON_VALUE(p.value, '$.TOTAL') 
						FROM OPENJSON(@listjson_chitiet) AS p
						WHERE ORDER_DETAIL_ID = JSON_VALUE(p.value, '$.ORDER_DETAIL_ID')
						AND JSON_VALUE(p.value, '$.status') = 0
					END;
					BEGIN
                        INSERT INTO ORDER_DETAIL
                        (ORDER_DETAIL_ID, 
                         ORDER_ID, 
                         ITEM_ID, 
                         QUANTITY,
						 PRICE,
						 IMAGE,
						 TOTAL
                        )
                               SELECT JSON_VALUE(p.value, '$.ORDER_DETAIL_ID'), 
                                      @ORDER_ID, 
                                      JSON_VALUE(p.value, '$.ITEM_ID'), 
                                      JSON_VALUE(p.value, '$.QUANTITY'),
									  JSON_VALUE(p.value, '$.PRICE'), 
                                      JSON_VALUE(p.value, '$.IMAGE'),
									  JSON_VALUE(p.value, '$.TOTAL')     
                               FROM OPENJSON(@listjson_chitiet) AS p
							   WHERE JSON_VALUE(p.value, '$.status') = 1
					END;
    END;
GO