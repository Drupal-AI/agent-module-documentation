<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# azure_oauth_sso — configuration

Install: `drush en azure_oauth_sso`. Landing config route is `azure_oauth_sso.customerSetup`
(`configure` in `azure_oauth_sso.info.yml`). All three admin forms sit under
`/admin/config/people/azure_oauth_sso` and require `administer site configuration`.

## Config objects

Three config objects, all editable through the forms below.

- **`azure_oauth_sso.settings`** — the Azure application credentials and login behaviour. Schema in
  `config/schema/azure_oauth_sso.schema.yml` (`config_object`). Keys actually written by
  `OauthConfigForm::submitForm()`: `client_id`, `ad_tenant`, `client_secret`, `redirect_uri`,
  `options_login` (`redirect` | `login_form`), `login_link_text`, `enable_sso_logout`,
  `enable_custom_form_ids`, `custom_form_ids`. (Note: the shipped schema names `tenant_id` /
  `logout_redirect_uri`, but the code reads/writes `ad_tenant`; the schema is out of step with the
  form.)
- **`azure_oauth_sso.fields_mapping`** — `custom_attr_table` (Drupal field machine name → Microsoft
  Graph property) plus `user_picture` (0/1). Created by `OauthFieldsMappingForm`.
- **`azure_oauth_sso.roles_mapping`** — `default_role`, `role_options` (`ad_group` |
  `department_field`), and `custom_attr_table` (Drupal role id → group object ID or department
  value). Created by `OauthRolesMappingForm`.

## Settings form — `Form\OauthConfigForm`

`ConfigFormBase`, `getEditableConfigNames()` = `['azure_oauth_sso.settings']`. Fields:

- **Client ID** (`client_id`), **Tenant ID** (`ad_tenant`), **Client Secret Value**
  (`client_secret`) — all required textfields. These are the Azure "app registration" overview
  values.
- **Redirect URI** — read-only markup showing `getRedirectUri()` (host + `/oauth/login`), the value
  to paste into the Azure app registration.
- **Options for login page** (`options_login`): `redirect` (immediate redirect of `/user/login` to
  Microsoft) or `login_form` (render a Microsoft button on the login form).
- **Enable Custom Form IDs** + **Custom Form IDs** (`custom_form_ids`, comma-separated) — show the
  SSO link on additional forms by ID; **Button Text** (`login_link_text`).
- **Enable SSO Logout** (`enable_sso_logout`) — also sign the user out of Microsoft on Drupal
  logout.
- **Test Configuration** — a link to `azure_oauth_sso.testOauthLogin` (`/oauth/test-login`).

### Where the client secret is stored

The client secret is saved into the **`azure_oauth_sso.settings`** simple config object as plain
`client_secret` (see `submitForm()` `$config->set('client_secret', …)`). It is read back via
`BaseOAuth::getClientSecret()`
(`$this->configFactory->get('azure_oauth_sso.settings')->get('client_secret')`) whenever a token is
exchanged. It is **not** a Key entity and **not** an environment variable — it lives in
configuration and is exported with it. The settings form renders it into a plain `textfield`
(`#type => textfield`), so it is visible in the admin form markup.

## Fields Mapping form — `Form\OauthFieldsMappingForm`

Lists the `user` entity's field definitions (minus system/token/picture fields) as checkboxes, each
with a select of Microsoft Graph properties (`mail`, `displayName`, `givenName`, `surname`,
`department`, `jobTitle`, …). Checked rows are written as `custom_attr_table.<drupal_field> =
<graph_property>`. A `user_picture` checkbox toggles photo sync. `#attached` library
`azure_oauth_sso/fields-mapping`.

## Roles Mapping form — `Form\OauthRolesMappingForm`

- **Default Role** (`default_role`) — role given when no mapping matches.
- **Mapping for** (`role_options`): `ad_group` (match an Entra group **object ID**) or
  `department_field` (match the directory `department` value).
- Per-role textfields captured into `custom_attr_table.<role_id> = <group id or department>`.

Roles are applied only when a **new** account is provisioned (see
[`../api/login-flow.md`](../api/login-flow.md)); existing accounts keep their roles.

## Uninstall

`azure_oauth_sso_uninstall()` deletes `azure_oauth_sso.settings`, `.fields_mapping`,
`.roles_mapping` and the `field.storage`/`field.field` config for `field_access_token` and
`field_refresh_token` on `user`.
