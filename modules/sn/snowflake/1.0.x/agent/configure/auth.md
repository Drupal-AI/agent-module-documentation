<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Snowflake auth

## Settings
- `/admin/config/snowflake/settings` (`SettingsForm`) — account identifier, statement/parameter defaults.
- `/admin/config/snowflake/auth` (`AuthSettingsForm`) — pick method: `key_pair` or `oauth`.
- `/admin/config/snowflake/auth/key-pair` (`KeyPairSettingsForm`) — private-key settings.
(The OAuth form route is present but commented out.)
All require the restricted permission `administer snowflake`.

## Credentials via Key module
Auth material (private key / OAuth secret) is referenced through **Key** entities
(`@key.repository`), not stored in plain config. Create the Key first, then select it here.

## Authenticators
`SqlApi` instantiates `KeyPairAuthenticator` or `OAuthAuthenticator` from `snowflake.auth.method`
and calls `getToken()` for a Bearer token used on every request. An unconfigured method throws a
`RuntimeException`.
