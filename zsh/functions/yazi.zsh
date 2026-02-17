# =============================================================================
# Yazi File Manager Shell Wrapper
# =============================================================================
# This function provides the ability to change the current working directory
# when exiting Yazi file manager.
#
# Usage:
#   y [yazi_options]  - Start Yazi and change directory on exit
#   yazi [options]    - Start Yazi normally (no directory change)
# =============================================================================

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}