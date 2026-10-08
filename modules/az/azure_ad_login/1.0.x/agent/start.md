<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Azure AD Login - agent index

**Azure AD Login** authenticates Drupal users against Microsoft Entra ID (Azure AD) via OAuth2 authorization-code flow. Version **1.0.2** (`1.0.x`). Core `^9.1 || ^10`.

## Key files
- `src/AzureAD.php` - builds authorize/token URLs, exchanges code for token, reads Graph profile/groups.
- `src/Controller/CallbackController.php` - `callback_azure_ad` handler: matches/creates user and calls `user_login_finalize()`.
- `src/Form/AzureADSettingsForm.php` - settings at `/admin/config/services/azure-ad-login`.

## Config / routes
- Settings route requires `administer azure_ad_login configuration`.
- Callback route `callback_azure_ad` requires only `access content` (anonymous-reachable by design).

## Identity
Identity is taken from Graph `/me` via a token minted directly by Azure.