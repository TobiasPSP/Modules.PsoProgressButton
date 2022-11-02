$code = @'

using System;
using System.Diagnostics;
using System.Runtime.InteropServices;


namespace PsoShell
{
	
	public class TaskbarManager
	{
		private static object _syncLock = new object();

		private static TaskbarManager _instance;

		private IntPtr _ownerHandle;

		public static TaskbarManager Instance
		{
			get
			{
				if (_instance == null)
				{
					lock (_syncLock)
					{
						if (_instance == null)
						{
							_instance = new TaskbarManager();
						}
					}
				}
				return _instance;
			}
		}


		internal IntPtr OwnerHandle
		{
			get
			{
				if (_ownerHandle == IntPtr.Zero)
				{
					Process currentProcess = Process.GetCurrentProcess();
					if (currentProcess == null || currentProcess.MainWindowHandle == IntPtr.Zero)
					{
						throw new InvalidOperationException("TaskbarManager: Valid Window Required");
					}
					_ownerHandle = currentProcess.MainWindowHandle;
				}
				return _ownerHandle;
			}
		}

		public static bool IsPlatformSupported
		{
			get
			{
				return Environment.OSVersion.Platform == PlatformID.Win32NT && Environment.OSVersion.Version.CompareTo(new Version(6, 1)) >= 0;
			}
		}

		private TaskbarManager()
		{
			if (!IsPlatformSupported)
			{
				throw new PlatformNotSupportedException("Not supported by OS");
			}
		}

		
		public void SetProgressValue(int currentValue, int maximumValue)
		{
			TaskbarList.Instance.SetProgressValue(OwnerHandle, Convert.ToUInt32(currentValue), Convert.ToUInt32(maximumValue));
		}

		public void SetProgressState(TaskbarProgressBarState state)
		{
			TaskbarList.Instance.SetProgressState(OwnerHandle, state);
		}

	}

	internal static class TaskbarList
	{
		private static object _syncLock = new object();

		private static ITaskbarList4 _taskbarList;

		internal static ITaskbarList4 Instance
		{
			get
			{
				if (_taskbarList == null)
				{
					lock (_syncLock)
					{
						if (_taskbarList == null)
						{
							_taskbarList = (ITaskbarList4)new CTaskbarList();
							_taskbarList.HrInit();
						}
					}
				}
				return _taskbarList;
			}
		}
	}

	[Guid("c43dc798-95d1-4bea-9030-bb99e2983a1a"), InterfaceType(ComInterfaceType.InterfaceIsIUnknown)]
	[ComImport]
	internal interface ITaskbarList4
	{
		[PreserveSig]
		void HrInit();

		[PreserveSig]
		void AddTab(IntPtr hwnd);

		[PreserveSig]
		void DeleteTab(IntPtr hwnd);

		[PreserveSig]
		void ActivateTab(IntPtr hwnd);

		[PreserveSig]
		void SetActiveAlt(IntPtr hwnd);

		[PreserveSig]
		void MarkFullscreenWindow(IntPtr hwnd, [MarshalAs(UnmanagedType.Bool)] bool fFullscreen);

		[PreserveSig]
		void SetProgressValue(IntPtr hwnd, ulong ullCompleted, ulong ullTotal);

		[PreserveSig]
		void SetProgressState(IntPtr hwnd, TaskbarProgressBarState tbpFlags);

		[PreserveSig]
		void RegisterTab(IntPtr hwndTab, IntPtr hwndMDI);

		[PreserveSig]
		void UnregisterTab(IntPtr hwndTab);

		[PreserveSig]
		void SetTabOrder(IntPtr hwndTab, IntPtr hwndInsertBefore);

		[PreserveSig]
		void SetTabActive(IntPtr hwndTab, IntPtr hwndInsertBefore, uint dwReserved);

		[PreserveSig]
		HResult ThumbBarAddButtons(IntPtr hwnd, uint cButtons, [MarshalAs(UnmanagedType.LPArray)] ThumbButton[] pButtons);

		[PreserveSig]
		HResult ThumbBarUpdateButtons(IntPtr hwnd, uint cButtons, [MarshalAs(UnmanagedType.LPArray)] ThumbButton[] pButtons);

		[PreserveSig]
		void ThumbBarSetImageList(IntPtr hwnd, IntPtr himl);

		[PreserveSig]
		void SetOverlayIcon(IntPtr hwnd, IntPtr hIcon, [MarshalAs(UnmanagedType.LPWStr)] string pszDescription);

		[PreserveSig]
		void SetThumbnailTooltip(IntPtr hwnd, [MarshalAs(UnmanagedType.LPWStr)] string pszTip);

		[PreserveSig]
		void SetThumbnailClip(IntPtr hwnd, IntPtr prcClip);

		void SetTabProperties(IntPtr hwndTab, SetTabPropertiesOption stpFlags);
	}

	public enum TaskbarProgressBarState
	{
		NoProgress,
		Indeterminate,
		Normal,
		Error = 4,
		Paused = 8
	}

	[ClassInterface(ClassInterfaceType.None), Guid("56FDF344-FD6D-11d0-958A-006097C9A090")]
	[ComImport]
	internal class CTaskbarList
	{
		
	}

	public enum HResult
	{
		Ok,
		False,
		InvalidArguments = -2147024809,
		OutOfMemory = -2147024882,
		NoInterface = -2147467262,
		Fail = -2147467259,
		ElementNotFound = -2147023728,
		TypeElementNotFound = -2147319765,
		NoObject = -2147221019,
		Win32ErrorCanceled = 1223,
		Canceled = -2147023673,
		ResourceInUse = -2147024726,
		AccessDenied = -2147287035
	}

	[StructLayout(LayoutKind.Sequential, CharSet = CharSet.Auto)]
	internal struct ThumbButton
	{
		internal const int Clicked = 6144;

		[MarshalAs(UnmanagedType.U4)]
		internal ThumbButtonMask Mask;

		internal uint Id;

		internal uint Bitmap;

		internal IntPtr Icon;

		[MarshalAs(UnmanagedType.ByValTStr, SizeConst = 260)]
		internal string Tip;

		[MarshalAs(UnmanagedType.U4)]
		internal ThumbButtonOptions Flags;
	}

	internal enum ThumbButtonMask
	{
		Bitmap = 1,
		Icon,
		Tooltip = 4,
		THB_FLAGS = 8
	}

	[Flags]
	internal enum ThumbButtonOptions
	{
		Enabled = 0,
		Disabled = 1,
		DismissOnClick = 2,
		NoBackground = 4,
		Hidden = 8,
		NonInteractive = 16
	}

	internal enum SetTabPropertiesOption
	{
		None,
		UseAppThumbnailAlways,
		UseAppThumbnailWhenActive,
		UseAppPeekAlways = 4,
		UseAppPeekWhenActive = 8
	}
}
'@

Add-Type -TypeDefinition $code 