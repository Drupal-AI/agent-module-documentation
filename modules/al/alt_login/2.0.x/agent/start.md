<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alternative Login ID & Display Name (alt_login) — agent index

Decouples the **login identifier** from the stored Drupal username and templates the **display name**.
Users can log in with username, email, user ID, or (with Address) first+last name; a token template
controls the shown name. Version **2.0.12**, core `^9 || ^10 || ^11`, license GPL-2.0-or-later.

## What it provides
- **Settings form** `Drupal\alt_login\Settings` at route `alt_login.admin` (`/admin/config/people/alt_login`,
  `_permission: access administration pages`), config object `alt_login.settings`.
- **Plugin type** `AltLoginMethod` — manager service `alt_login.method_manager`
  (`AltLoginMethodManager`), interface `AltLoginMethodInterface`, attribute `#[AltLoginMethod]`.
  Core plugins: `username`, `email`, `uid`, `address_name` (last only when Address is installed).
- **Entity-reference selection** plugin `default:altlogin` (`AltLoginUserSelection`) — search users by alias.
- **Basic-auth override**: `AltloginServiceProvider` swaps `basic_auth.authentication.basic_auth` for
  `Drupal\alt_login\Authentication\Provider\BasicAuth` so API clients can use aliases.
- **Hooks** in `alt_login.module`: `hook_user_format_name_alter` (display name), `hook_form_alter` /
  `hook_form_user_form_alter` (login + account forms), `hook_user_presave` (auto username),
  `hook_tokens_alter`, `hook_module_implements_alter`.
- Service `logger.channel.alt_login`. No permissions, no Drush commands, no submodules.

## Dependencies
No hard module deps. Soft: **token** (token-tree UI + more display tokens), **address** (enables the
`address_name` login method and address-based username generation). Requires `basic_auth` only for the
basic-auth alias override to take effect.

## Solution docs
- Configuration & settings: [agent/config/settings.md](config/settings.md)
- Login-method plugin type & how login resolves: [agent/plugins/login-methods.md](plugins/login-methods.md)
- Display name, tokens, username auto-generation & basic auth: [agent/api/display-and-auth.md](api/display-and-auth.md)
