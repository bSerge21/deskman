uses windows;
var r: trect;
begin
  r.Left := 0;
  r.Right := 0;
  r.Right := 1280;
  r.Bottom := 994;
  SystemParametersInfo(SPI_SETWORKAREA, 0, @r, 0); // 1280x994
end.  