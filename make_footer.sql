CREATE FUNCTION dbo.make_footer_cock
(
  @text NVARCHAR(MAX)
)
RETURNS @result TABLE (new_text NVARCHAR(MAX), tail_text NVARCHAR(MAX))
AS
BEGIN

  DECLARE @new_text NVARCHAR(MAX) = '';
  DECLARE @i INT = 0;
  DECLARE @j INT = 0;
  DECLARE @char1 NVARCHAR(50);
  DECLARE @char2 NVARCHAR(50);
  DECLARE @length_line INT = 150;
  DECLARE @length_wall INT = 0;
  DECLARE @before INT = 0;
  DECLARE @after INT = 0;
  DECLARE @btween INT = 0;
  
  DECLARE @space_tbl TABLE (rownum INT, before INT, btween INT, after INT, length_wall INT);
  INSERT INTO @space_tbl 
    VALUES (1, 10, 18, 10, 13), (2, 8, 15, 8, 17), (3, 6, 11, 6, 21), (4, 4, 6, 4, 26), (5, 3, 4, 3, 28), (6, 2, 2, 2, 31);
  
  WHILE (@j < 12)
  BEGIN
    SELECT @j = @j + 1;
    IF @j < 7
      SELECT @i = @i + 1;
    ELSE 
      SELECT @i = @i - 1;
  
  
    SELECT @before = before, 
           @after = after, 
           @btween = btween, 
           @length_wall = length_wall
    FROM @space_tbl
    WHERE rownum = @i;
    
    SELECT @text = text, @char1 = c FROM get_chars(@text, @length_wall);
    SELECT @text = text, @char2 = c FROM get_chars(@text, @length_wall);
    SELECT @new_text = @new_text + REPLICATE(' ', @before) + @char1 + REPLICATE(' ',@btween) + @char2 +  REPLICATE(' ',@after) + CHAR(10);
  
  END;
  
  INSERT INTO @result (new_text, tail_text)
  VALUES (@new_text, @text);

  RETURN;

END;
GO