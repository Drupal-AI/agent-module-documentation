<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Both are `restrict access: true` (high-privilege — they govern how everyone authenticates).
Grant only to trusted administrators.

- **`administer simplesamlphp authentication`** — access all three settings tabs at
  `/admin/config/people/simplesamlphp_auth` (Basic, Local authentication, User info and syncing),
  including the `activate` switch, attribute mapping, role rules, and local-login allow-lists.
- **`change saml authentication setting`** — controls visibility of the per-user "Enable this
  user to leverage SAML authentication" checkbox on the user register/edit forms, i.e. who may
  link or unlink an individual account's SAML authmap entry.
