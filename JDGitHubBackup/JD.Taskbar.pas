unit JD.Taskbar;

interface


const
  CLSID_TaskbarList: TGUID = '{56FDF344-FD6D-11d0-958A-006097C9A090}';

type
  ITaskbarList = interface
  ['{56FDF342-FD6D-11d0-958A-006097C9A090}']
  { virtual HRESULT STDMETHODCALLTYPE HrInit( void) = 0;}
     function HrInit: HResult; stdcall;
  { virtual HRESULT STDMETHODCALLTYPE AddTab(
              /* [in] */ HWND hwnd) = 0; }
     function AddTab(hwnd: Cardinal): HResult; stdcall;
  { virtual HRESULT STDMETHODCALLTYPE DeleteTab(
              /* [in] */ HWND hwnd) = 0; }
     function DeleteTab(hwnd: Cardinal): HResult; stdcall;

  { virtual HRESULT STDMETHODCALLTYPE ActivateTab(
              /* [in] */ HWND hwnd) = 0; }
     function ActivateTab(hwnd: Cardinal): HResult; stdcall;

  { virtual HRESULT STDMETHODCALLTYPE SetActiveAlt(
              /* [in] */ HWND hwnd) = 0; }
     function SetActiveAlt(hwnd: Cardinal): HResult; stdcall;
  end;

implementation

end.
