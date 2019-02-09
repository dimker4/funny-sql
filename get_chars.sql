CREATE FUNCTION dbo.get_chars
(
  @text NVARCHAR(MAX),
  @width_wall int
)  
RETURNS @result_tbl TABLE
(
	text NVARCHAR(MAX),
  c NVARCHAR(50)
)
AS   
BEGIN  
    DECLARE @char NVARCHAR(50);
    SELECT @text = REPLACE(REPLACE(@text, CHAR(13), ''), CHAR(10), '')
    SELECT @char = SUBSTRING(@text, 1, @width_wall);
    SELECT @text = Stuff(@text, 1, @width_wall, '');
    
    INSERT INTO @result_tbl (text, c)
      VALUES (@text, @char);

    RETURN
END; 
GO