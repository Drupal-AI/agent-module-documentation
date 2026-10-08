<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Show Password — agent index

Adds a **Show Password checkbox** to the user login form (`hook_form_user_login_form_alter`); JS toggles `#edit-pass` between `password` and `text`. Version **2.0.0**, core `^9 || ^10`.

Client-side only: it toggles visibility of the value the user is typing. It never pre-fills the field and cannot read stored or other users' passwords. No routes/permissions/server logic.