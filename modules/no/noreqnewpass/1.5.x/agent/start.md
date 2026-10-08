<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# noreqnewpass — agent start

No Request New Password removes Drupal's forgotten-password / "Request new password" flow.
A single boolean setting, when TRUE, (1) denies access to the core `user.pass` and
`user.pass.http` routes (`/user/password`), (2) swaps the core `::validateFinal` login
validator on `user_login_form` / `user_login_block` for the module's own equivalent, and
(3) removes the `request_password` link from the user login block. When FALSE the module is
inert. No plugins, no Drush commands, no non-core dependencies.

- Config object, the `noreqnewpass_disable` key, the settings form + route → [configure/settings.md](configure/settings.md)
- The one permission (`administer noreqnewpass`) and what it gates → [permissions/permissions.md](permissions/permissions.md)
- Services, the route subscriber, and the form/theme hook behavior → [api/api.md](api/api.md)
