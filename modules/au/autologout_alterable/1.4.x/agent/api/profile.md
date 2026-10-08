# Autologout Alterable — JSON profile API & manager service

## HTTP endpoints (`autologout_alterable.routing.yml`)
Both require `_user_is_logged_in: 'TRUE'`, `_format: 'json'`. Controller `AutologoutController`.

### `GET /api/autologout_alterable/autologout-profile`
Returns the current user's autologout profile as JSON (no-store cache headers):

| Field | Meaning |
|---|---|
| `id` | Profile id. |
| `lastActivityAgo` | Seconds since last recorded activity. |
| `sessionExpiresIn` | Seconds until the session expires (capped at `Number.MAX_SAFE_INTEGER`). |
| `extendible` | Whether the session can still be extended (false past `max_session_length`). |
| `redirectUrl` | Where to send the user after logout. |

If the session is already expired when this is called, the controller performs the logout and returns
the `redirectUrl` (see `makeProfileResponse`).

### `PATCH /api/autologout_alterable/autologout-profile`
Also requires `_content_type_format: 'json'`. Body (JSON object):
- `lastActiveAgo` (number, seconds since last activity) — applied **only when numeric and `>= 0`**; the
  server converts it to a `DateTime` and calls `setLastActivity()`. Negative / future values are
  ignored, so the client can *report* recent activity but cannot push activity into the future or bypass
  the hard `max_session_length` cap.
- `forceLogout` (bool) — when strictly `true`, forces `sessionExpiresIn = 0` and logs the user out.

Returns the updated profile (same shape as GET). This is what `js/autologout-profile-handler.js` calls
to keep-alive / trigger logout; a decoupled front-end can call it directly on the shared session.

Security posture: both routes only ever act on the **current authenticated user's own** session
(`current_user`), so one user cannot read or affect another's profile.

## Manager service `autologout_alterable.manager`
Class `AutologoutManager` implements `AutologoutManagerInterface` (also aliased to the interface FQN).
Public API:

- `isEnabled(): bool`
- `isAutologoutRoute(): bool`
- `getDefaultTimeout(AccountInterface $account): int`
- `setLastActivity(?\DateTime $last_activity = NULL): ?\DateTime`
- `calculateDefaultSessionExpiration(?\DateTime $session_start, ?\DateTime $last_activity, int $default_timeout, bool &$extendable): ?\DateTime`
- `getDefaultRedirectUrl(): Url`
- `getAutoLogoutProfile(array $redirect_extra_query = []): AutologoutProfileInterface`
- `clearAutoLogoutProfiles(?int $uid = NULL): void`
- `getDrupalSettings(): array`
- `makeInducedLogoutMessage(): bool` / `makeInactivityMessage(): bool`
- `logout(bool $check_message = TRUE, array $extra_query = []): TrustedRedirectResponse`

Use `getAutoLogoutProfile()` to read state and `logout()` to end a session programmatically. The profile
object (`AutologoutProfileInterface` / `AutologoutProfile`) is what the alter events receive — see
[../hooks/events.md](../hooks/events.md).
