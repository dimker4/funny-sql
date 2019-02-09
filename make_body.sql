CREATE FUNCTION dbo.make_body_cock
(
  @text NVARCHAR(MAX)
)
RETURNS @result TABLE (new_text NVARCHAR(max), tail_text NVARCHAR(MAX))
AS
BEGIN

  DECLARE @new_text NVARCHAR(MAX) = CHAR(10)+CHAR(10)+CHAR(10);
  DECLARE @i INT = 0;
  DECLARE @char NVARCHAR(50);
  DECLARE @length_line INT = 67;
  DECLARE @length_wall INT = 0;
  
  
  WHILE (@i < 30)
  BEGIN
    SELECT @i = @i + 1;
    IF (@i = 1)
    BEGIN
      SELECT @length_wall = 10;
      SELECT @text = text, @char = c FROM get_chars(@text, @length_wall);
      SELECT @new_text = @new_text + REPLICATE(' ', (@length_line-@length_wall)/2) + @char + REPLICATE(' ', (@length_line-@length_wall)/2) + CHAR(10);
    END;
    IF (@i = 2)
    BEGIN
      SELECT @length_wall = 12;
      SELECT @text = text, @char = c FROM get_chars(@text, @length_wall);
      SELECT @new_text = @new_text + REPLICATE(' ', (@length_line-@length_wall)/2) + @char + REPLICATE(' ', (@length_line-@length_wall)/2) + CHAR(10);
    END
    IF (@i > 2)
    BEGIN
      SELECT @length_wall = 16;
      SELECT @text = text, @char = c FROM get_chars(@text, @length_wall);
      SELECT @new_text = @new_text + REPLICATE(' ', (@length_line-@length_wall)/2) + @char + REPLICATE(' ', (@length_line-@length_wall)/2) + CHAR(10);
    END;
  END;

  INSERT INTO @result 
    SELECT @new_text, @text;

  RETURN;

END;
GO