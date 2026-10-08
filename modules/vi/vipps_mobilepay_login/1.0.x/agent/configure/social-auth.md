<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Vipps MobilePay Login

## Prerequisites
- Enable `social_auth` (and the Social API stack) and `vipps_mobilepay`.
- In `vipps_mobilepay`, create a **Vipps MobilePay Connection** profile
  (`/admin/…/vipps_mobilepay_connection`) holding your `client_id`,
  `client_secret`, `merchant_serial_number` and `subscription_key`.

## Settings form
Path: `/admin/config/social-api/social-auth/vipps`
Permission: `administer social api authentication`.

Fields:
- **Vipps MobilePay Connection Profile** (required) — select the profile that
  supplies the OAuth client credentials and merchant keys. The raw client id /
  secret fields from Social Auth are hidden; credentials come from the profile.
- **Partner mode** — enable if making API requests on behalf of a merchant
  (requires merchant serial number + subscription key, validated on save).
- **Show in login form** — renders the "Login with Vipps" button on the
  standard user login form.
- **Authorized redirect URL** / **Advanced → scopes, endpoints** — from Social
  Auth; register the shown redirect URL in the Vipps developer portal.
- **Clear cache** — flushes caches on save so the network reconfigures.

## Flow
1. User clicks the Vipps button → `social_auth.network.redirect` → provider
   authorization URL (scopes `openid address email name phoneNumber`).
2. Provider returns to `social_auth.network.callback`; Social Auth verifies the
   `state`, then `VippsAuthManager::authenticate()` exchanges the `code` for a
   token and `getUserInfo()` maps the resource owner to a Drupal user.

## Security notes
- State/CSRF verification and the HTTPS token exchange are handled by Social Auth
  core + the League OAuth2 Vipps provider; this module adds no custom callback.
- Keep credentials in the connection profile (config entity) — do not hardcode.
