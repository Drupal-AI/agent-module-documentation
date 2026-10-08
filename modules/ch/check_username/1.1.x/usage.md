<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Check Username

## What it is / when to use

- Live-checks whether a chosen username is already taken, via AJAX, on registration and user-create/edit forms.
- Gives immediate feedback before form submission.
- Configurable debounce delay for the check.

---

## Install & configure

- Configure at `/admin/config/system/check-username` (route `check_username.config_form`, permission `administer check_username configuration`).
- Set the debounce `delay` (default 5000 ms) before the AJAX check fires.
- The module attaches its JS behaviour/library to the relevant user forms.
- The check itself is served from `/check-username`.

---

## Usage & API notes

- The AJAX endpoint route `/check-username` (`check_username.check`) is gated only by `_permission: 'access content'`.
- SECURITY: `CheckUsernameController::checkUsername()` queries the user entity by `name` with `accessCheck(FALSE)` and returns JSON `{allowed:false, msg:"The name X is already taken."}` — allowing anonymous username enumeration (a D2 information-disclosure vector) with no rate limiting.
- The `uid` query param lets the check exclude the current account (edit form use).
- Response reveals existence of specific usernames to any anonymous caller.
- Fix: require an authenticated/stronger permission, add flood/rate limiting, and/or return a non-revealing response for anonymous callers.
- Config object is `check_username.configs` (`delay`).
- The frontend library performs the debounced fetch as the user types.
- No writes are performed by the endpoint — it is read-only.
- Query uses the entity query builder (no raw SQL).
- The delay is validated to be numeric and non-zero on the settings form.
- Assets live under `assets/`.
- Intended to improve UX on the registration flow.
- Works on both registration and admin user-create/edit forms.
- The endpoint returns a translated "already taken" or empty message.
- Consider that core registration already partially reveals name collisions, but this endpoint enables efficient bulk enumeration.
- Uninstall removes the module config.
