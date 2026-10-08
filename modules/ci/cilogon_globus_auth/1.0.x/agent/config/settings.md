<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, install seeding & the settings form

## Install / enable

`composer require drupal/cilogon_globus_auth` then `drush en cilogon_globus_auth`. Requires
`openid_connect` (composer `drupal/openid_connect:^3.0@alpha`). Optionally enable `key` to store the
OAuth client secret as a Key entity rather than plaintext config.

`hook_install()` (`cilogon_globus_auth.install`) programmatically creates two OpenID Connect client
setting configs, **disabled** and with empty credentials:
- `openid_connect.settings.ospclscigw` — CILogon endpoints + scopes `email,openid,profile,org.cilogon.userinfo`.
- `openid_connect.settings.ospgascigw` — Globus endpoints + scope `urn:globus:auth:scope:transfer.api.globus.org:all`.

`hook_uninstall()` deletes both. `hook_update_10101()` seeds `session_required_policies` on
`openid_connect.client.ospgascigw` with the previously hardcoded policy UUID
`9e45e494-e88b-492e-9ede-36862365b0bb` for sites upgrading from an older release (each site should
then set its own policy id).

Enable and finish credentials for each client at OpenID Connect's own admin
(*Configuration → People → OpenID Connect*): supply Client ID + Client Secret and register the
redirect URI (`/openid-connect/{plugin_id}/callback`) with the provider.

## The module's own settings form

- Route `cilogon_globus_auth.settings` → `/admin/config/people/cilogon-globus-auth`, permission
  **`administer site configuration`**. Menu link under *Configuration → People* (`user.admin_index`),
  weight 10 (`.links.menu.yml`). Form `OSPAuthSettingsForm` (`src/Form/OSPAuthSettingsForm.php`,
  `ConfigFormBase`, form id `cilogon_globus_auth_settings_form`).
- Editable config object: **`cilogon_globus_auth.settings`**.

### Config keys (config object + `config/schema/cilogon_globus_auth.schema.yml`)

- `button_text_default` (text) — default button-label template, `@client_title` placeholder;
  defaults to `Log in with @client_title`.
- `button_texts` (sequence of text) — per-client label overrides, keyed by OIDC client id.
- `login_help` (text_format) — global login help text shown between the SSO buttons and the local
  form.
- `login_help_texts` (mapping of text_format) — per-client help overrides, keyed by client id.
- `hide_user_register` (boolean) — when TRUE, `RouteSubscriber` sets `_access: 'FALSE'` on
  `user.register`, hiding "Create new account" while SSO can still provision accounts.
- `auto_assign_roles` (sequence of string) — role ids assigned once to newly SSO-provisioned
  accounts (see below).

The form loads all `openid_connect_client` entities to build per-client override fieldsets, picks a
sensible default text format (`basic_html` → `filtered_html` → `full_html`), and on submit filters
out empty overrides/help before saving. The role picker excludes `anonymous`, `authenticated`, and
any role where `isAdmin()` is TRUE, so SSO auto-provisioning can never grant administrative access.

## Role auto-assignment & IdP name (`hook_openid_connect_userinfo_save`)

In `cilogon_globus_auth.module`, `hook_openid_connect_userinfo_save(UserInterface $account, array $context)`:
- Stores the IdP display name (`idp_name` for CILogon, `identity_provider_display_name` for Globus)
  in the `externalauth.authmap` data for `openid_connect.{plugin_id}`, keyed by the `sub` claim.
- Only when `$context['is_new']` is set, adds each configured `auto_assign_roles` id to the account
  (skipping `anonymous`/`authenticated`) and logs a notice. Roles are added only on first creation,
  so an administrator later removing a role is not overridden on next login. openid_connect saves the
  account after the hook, so the hook does not call `save()`.
