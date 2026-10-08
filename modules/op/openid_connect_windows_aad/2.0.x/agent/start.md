<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# openid_connect_windows_aad — agent start

A single **OpenID Connect client plugin** (`id: windows_aad`, label "Windows Azure AD")
for the [openid_connect](https://www.drupal.org/project/openid_connect) framework, adding
Microsoft Entra ID / Azure AD (incl. Azure AD B2C) as a login provider. It defines **no
routes** (except a front-channel logout callback `openid_connect_windows_aad.sso` at
`/openid-connect/windows_aad/signout`), **no permissions**, **no Drush**, and **no config
UI of its own** — you configure it by creating an `openid_connect_client` **config entity**
whose `plugin` is `windows_aad`. Depends on `openid_connect` and `key` (the client secret
is always a Key entity). Installed release here is `2.0.0-beta10` (**beta**).

- The `windows_aad` plugin id, its settings keys, group→role mapping, and how it registers
  with openid_connect → [plugins/windows_aad.md](plugins/windows_aad.md)
- Create/read the `openid_connect_client` config entity (shape, drush, Key secret,
  endpoints) → [configure/client.md](configure/client.md)
