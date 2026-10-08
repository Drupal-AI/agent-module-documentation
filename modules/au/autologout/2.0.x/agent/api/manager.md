# autologout API — the manager service

Service id **`autologout.manager`** (`Drupal\autologout\AutologoutManager`, interface
`AutologoutManagerInterface`). Inject it or `\Drupal::service('autologout.manager')`.

## Methods (`AutologoutManagerInterface`)
- `createTimer()` — build the JS timer settings/markup attached to the page.
- `getRemainingTime()` — seconds left before this user is logged out.
- `getUserTimeout($uid = NULL)` — effective timeout for a user (global/role/personal resolved).
- `getUserRedirectUrl($uid = NULL)` — resolved redirect URL for a user.
- `getRoleTimeout()` / `getRoleUrl()` — per-role timeout/redirect lookups.
- `logout()` — perform the autologout (destroy session) for the current user.
- `logoutRole(UserInterface $user)` — role-based logout for a given user.
- `inactivityMessage()` — the post-logout message to show.
- `preventJs()` — TRUE if the timer JS should be suppressed on this request (see
  `hook_autologout_prevent()`).
- `refreshOnly()` — TRUE if the page should keep-alive only, never log out (see
  `hook_autologout_refresh_only()`).

The module also exposes AJAX endpoints used by the JS timer: `/autologout_ajax_logout`,
`/autologout_ajax_set_last`, `/autologout_ajax_get_time_left`, and `/autologout_alt_logout`
(all CSRF-protected, logged-in only). Normally you use the manager, not these routes directly.
