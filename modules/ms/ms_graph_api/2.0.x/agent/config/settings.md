<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration: the default key and credentials

## Install / enable

Install via Composer so the Graph SDK is present:
`composer require 'drupal/ms_graph_api'`, then `drush en ms_graph_api`. Contrib **`key`** is a
hard dependency. On install the module ships a config-provider Key entity
`ms_graph_api_default_key` (empty) and sets `ms_graph_api.settings:default_key_id` to point at it.

## Config object + schema

- `ms_graph_api.settings` — single key **`default_key_id`** (string), the ID of the Key entity
  to load for the default client. Schema: `config/schema/ms_graph_api.schema.yml`
  (`type: config_object`). Install value: `default_key_id: 'ms_graph_api_default_key'`.
- `key.key.ms_graph_api_default_key` (`config/install/`) — a Key of `key_type: ms_graph_api`,
  `key_input: ms_graph_api`, `key_provider: config` with `key_value: '{}'`. Edit it (or create a
  new `ms_graph_api` key) to supply real credentials.

## Settings form — `GraphApiSettingsForm` (`src/Form/GraphApiSettingsForm.php`)

Route `ms_graph_api.settings` at **`/admin/config/services/ms-graph-api`** (menu: *Configuration →
Web services → Microsoft Graph API*), permission **`administer site configuration`**. Extends
`ConfigFormBase`, edits `ms_graph_api.settings`. One element: a `key_select`
(`#key_filters => ['type' => 'ms_graph_api']`, required) that stores the chosen key ID into
`default_key_id`. This only selects *which* key is the default; the credentials themselves are
edited on the Key entity.

## The Key: type, input, and fields

Credentials are a **Key entity of type `ms_graph_api`**, managed at
`/admin/config/system/keys`. To source the client secret from an environment variable, set the
key's provider accordingly (the shipped default uses the `config` provider; switch to an env/file
provider to keep the secret out of config exports).

- **`GraphApiKeyType`** (`src/Plugin/KeyType/GraphApiKeyType.php`, id `ms_graph_api`, group
  `connection_string`) — extends `AuthenticationMultivalueKeyType`; the key value is JSON with
  multivalue fields `tenant_id`, `client_id`, `client_secret` (all required). The factory reads
  these via `unserialize()`.
- **`GraphApiKeyInput`** (`src/Plugin/KeyInput/GraphApiKeyInput.php`, id `ms_graph_api`) — the
  edit form. Collects four textfields: **Tenant Domain**, **Tenant ID**, **Client ID**,
  **Client secret** (`#sensitive => TRUE`). On submit it validates: tenant domain against
  `VALID_DOMAIN_REGEX`, tenant ID and client ID via `Uuid::isValid()`; then JSON-encodes the
  values for storage. It also re-implements obscure/restore of the sensitive field itself
  (`obscureAndPopulateDefaults()` / `replaceObscuredFieldValues()`) to work around Key issue
  DDO-3168120 — so an unchanged, obscured secret is not overwritten with its masked form on save.

Note the tenant **domain** is stored/validated by the input but is only consumed by the
`getTenantDomain*` helpers — it is not part of the token request (which needs tenant ID, client
ID, client secret).

## Getting the Azure side ready

Register the Drupal site as an Azure AD / Entra app registration, create a client secret, and
grant the Graph permissions the integration needs (README has the step-by-step). Copy the
Application (client) ID → Client ID, Directory (tenant) ID → Tenant ID, and the generated secret →
Client secret. Prefer the fewest permissions necessary; an application-permission credential held
on the site is a standing capability against the tenant.
