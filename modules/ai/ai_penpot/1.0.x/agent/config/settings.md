<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Penpot — settings, Key/token, and install wiring

## Install & enable

```bash
composer require drupal/ai_penpot
drush en ai_penpot -y
```

Requires `ai`, `ai_agents`, `key`, `easy_encryption` (all pulled by Composer). Optional: enable
`ai_context` to get editable guidance items seeded.

## Settings form

`Drupal\ai_penpot\Form\SettingsForm` (route `ai_penpot.settings`, path
**`/admin/config/ai/penpot`**, permission **`administer ai penpot`**; menu link under
*Configuration → AI*). Form id `ai_penpot_settings`. Fields:

| Field | Config key | Notes |
|---|---|---|
| Penpot instance URL | `penpot_base_url` | `#type => url`. Validated to a full http(s) URL with a host (rejects `file://`, scheme-less, etc.). Saved with the trailing slash stripped. E.g. `https://design.penpot.app`. |
| Penpot access token (Key) | `penpot_token_key` | `#type => select`, options come **only** from `key.repository->getKeysByType('authentication')` — non-authentication keys are not selectable. |
| Default Penpot file id | `default_file_id` | The UUID in a workspace/view URL. Used when a tool is called without a file id/link. |

There is no token textfield: the token always lives in a Key. `submitForm()` always writes
`penpot_token_source = 'key'`. A **Test Penpot connection** submit (`::testConnection`,
`#limit_validation_errors => []`) probes the API with the *saved* config: it calls
`listDesignPages()` + `fetchPage()` + `summarizeTokens()` on the default file and reports page /
colour / typography counts, or an error.

## Config object `ai_penpot.settings`

Schema in `config/schema/ai_penpot.schema.yml`; install defaults in
`config/install/ai_penpot.settings.yml`:

| Key | Type | Default | Meaning |
|---|---|---|---|
| `penpot_token_source` | string | `key` | Always `key` (Key module is the only token source; no env path). |
| `penpot_token_key` | string | `penpot` | Key entity id holding the access token. |
| `penpot_base_url` | string | `''` | Penpot instance base URL. Empty = tools cannot run. |
| `default_file_id` | string | `''` | Default file UUID. |
| `build_rules` | text | (long default) | Seeded as the *Penpot Build Rules* AI Context item. |
| `accessibility_rules` | text | (long default) | Seeded as the *Penpot Accessibility Rules* item (WCAG 2.1 AA). |
| `mapping_governance` | text | `''` | Optional *Penpot Component Mapping Governance* item (seeded only when non-empty). |
| `context_scope` | sequence | `{global: [global]}` | Scope applied to the seeded AI Context items. |

## Token storage (Key + Easy Encryption)

`PenpotContextClient::getToken()` reads the Key named by `penpot_token_key` and returns its value;
it is sent verbatim in the `Authorization: Token <token>` header. On install
`AiPenpotInstaller::installPenpotKey()` creates a Key with id `penpot` (label *"Penpot access
token"*), key type `authentication`, using the `easy_encrypted` provider when available (falls back
to `config`). The admin pastes their Penpot token (from *Your account → Access tokens*) into that
Key at `/admin/config/system/keys`. Self-hosted Penpot must have `enable-access-tokens` on.

## Install / requirements hooks (`ai_penpot.install`)

- `ai_penpot_install()` → `installPenpotKey()` then `seedContextItems()`.
- `ai_penpot_requirements('runtime')` warns (RequirementSeverity::Warning) when the base URL is
  empty, or when the token is empty; otherwise reports *"Penpot connection configured"* (OK).

## AI Context seeding (`AiPenpotInstaller::seedContextItems()`)

No-op unless the `ai_context` module is installed and the `ai_context_item` entity type exists.
Creates (or, with `$update = TRUE`, overwrites) up to three items from config: *Penpot Build Rules*
(`build_rules`), *Penpot Accessibility Rules* (`accessibility_rules`), and *Penpot Component
Mapping Governance* (`mapping_governance`, only when non-empty). Items with empty content are
skipped; existing items are left intact unless `$update` is TRUE. The rule *text* lives in config,
not in PHP, so it is editable at *Admin → AI → Context*.

## Base-URL validation

`getBaseUrl()` and the form's `validateForm()` both `parse_url()` the base and accept it only when
the scheme is `http`/`https` and a host is present; anything else is rejected (and, in the client,
logged) so the tools refuse to run. The base is admin-only config.
