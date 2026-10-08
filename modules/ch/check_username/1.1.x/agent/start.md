<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# check_username — agent orientation

- AJAX username-availability check for registration/user forms. Endpoint `/check-username` (`check_username.check`), admin form `/admin/config/system/check-username`.
- SECURITY (report — D2 info disclosure): `src/Controller/CheckUsernameController.php::checkUsername` route requires only `access content`; queries user by name with `accessCheck(FALSE)` and returns "The name X is already taken." → anonymous username enumeration, no rate limiting. Fix: stronger permission + flood control + non-revealing anon response.
- Read-only (no writes), entity query (no raw SQL). Config `check_username.configs` (delay).
