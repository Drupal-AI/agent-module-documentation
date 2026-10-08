<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Aweber Block (aweber_block) — agent index

Integrates Drupal with the AWeber email-marketing platform. Provides an OAuth2 site-connection flow, a config settings form, two services (auth + API manager), and one placeable Block whose form subscribes visitors to AWeber lists.

- **Requires:** Drupal core `^9 || ^10 || ^11` only. No composer requirements, no module dependencies, no submodules, no libraries.
- **Package:** Aweber. **Config:** single object `aweber_block.aweberblockconfig` (no config schema shipped). **Permissions:** none of its own — admin routes use core `access administration pages`.

## What it provides

- **Block plugin** `aweber_block` (`src/Plugin/Block/AweberBlock.php`) — renders the public signup form (`src/Form/AweberForm.php`, form id `aweber_block_form`); block config picks which AWeber lists it offers.
- **Config form** `Form\AweberBlockConfigForm` (form id `aweber_block_config_form`) — API/OAuth credentials, base/authorize URLs, redirect URI, scopes, post-signup redirect.
- **Controller** `Controller\AweberBlockController` — `getAuthorization()` (builds authorize link), `getCode()` (OAuth callback → exchanges code for token), `index()` (thank-you page).
- **Services:** `aweber_block.authentication` = `Service\AweberAuthentication` (OAuth token get/refresh/store, config accessors); `aweber_block.manager` = `Service\AweberManager` (REST calls: accounts, lists, addSubscribers, checkSubscriberExistsByEmail).
- **Scopes constant** `AweberScopes::SCOPES` (`src/AweberScopes.php`).
- **Theme hook** `aweber_block` (`aweber-block.html.twig`), **hook_help**.

## Routes

| Route | Path | Permission |
|-------|------|-----------|
| `aweber_block.aweber_block_config_form` | `/admin/config/aweber_block/config` | `access administration pages` |
| `aweber_block.get_authorization` | `/admin/config/aweber_block/get_authorization` | `access administration pages` |
| `aweber_block.callback` | `/aweber_block/getCode` | `access administration pages` |
| `aweber_block.main_menu` | `/admin/config/aweber_block` | `access administration pages` |
| `aweber_block_redirect.default` | `/aweber_block/thankyou` | `access content` |

## Solution docs

- [Configuration & OAuth setup](config/settings.md) — settings form, config keys, authorize/callback flow, scopes.
- [Signup block & form](blocks/signup-block.md) — block plugin, list selection, `AweberForm` submission.
- [Services API](services/api.md) — `AweberAuthentication` + `AweberManager` methods for custom code.
