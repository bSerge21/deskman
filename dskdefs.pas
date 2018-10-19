unit dskdefs;

interface

uses menus, messages;

const
  WM_ADD_HIDDEN_APP = WM_USER + 1;
  WM_DESKTOP_SWITCHED = WM_USER + 2;
  WM_SHOW_SYSMENU = WM_USER + 3;

  enableESC: boolean = true;

type
  TDskMenuItem = class(TMenuItem)
  public
    dskCommand, dskParams: String;
  end;

implementation

end.
