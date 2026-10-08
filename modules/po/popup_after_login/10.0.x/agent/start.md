<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Popup After Login — agent orientation

Shows a SweetAlert2 popup with an admin message after login, per role.

- Version 10.0.x, core `^9.2||^10`, dep sweetalert2. Settings `admin/config/popup_after_login` (`administer site configuration`).
- JS hits `/popup_after_login_get_results.json` (`access content`); controller returns admin-set title/message only for targeted roles, keyed to current user + session flags set in `hook_user_login`.
- Popup content is admin-only full_html (self-XSS at most). No redirect (no open-redirect). No user input reflected. Nothing exploitable found.