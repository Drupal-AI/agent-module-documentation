<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & storage

Two config surfaces: the TMGMT **translator config entity** (per-provider connection settings) and a
small standalone **config object** for webhook bookkeeping. Schema: `config/schema/tmgmt_crowdin.schema.yml`.

## Translator config entity — `tmgmt.translator.crowdin`

Settings live under the `settings` mapping of the TMGMT translator entity for the `crowdin` plugin.
Schema type `tmgmt.translator.settings.crowdin` (extends `tmgmt.translator_base`):

| Key | Type | Meaning |
|---|---|---|
| `personal_token` | string | Crowdin Personal Access Token; sent as `Authorization: Bearer` on every API call. Required. |
| `project_id` | string | Crowdin project id the site pushes files to / pulls translations from. Required. |
| `domain` | string | Crowdin Enterprise organization domain (builds `<domain>.api.crowdin.com`). Optional; empty = crowdin.com. |
| `xliff_cdata` | boolean | When TRUE (default, set by `defaultSettings()`), `WebXML::export()` writes source text as CDATA. |

Edited through the TMGMT provider form (`CrowdinTranslatorUi::buildConfigurationForm()`), validated by
`getUser()` (an invalid token blocks save). `configure` route declared in the info file:
`tmgmt_crowdin.settings`.

## Config object — `tmgmt_crowdin.settings`

Schema type `config_object`, one key:

| Key | Type | Meaning |
|---|---|---|
| `webhook_id_by_project_id` | string | PHP-serialized map `project_id => Crowdin webhook id`. Written by `setCrowdinData()`, read by `getCrowdinData()`. Lets `requestFileWebhook()` avoid creating duplicate webhooks and lets the webhook controller confirm a payload's project is one this site registered. |

## Legacy migration

`tmgmt_crowdin.post_update.php` → `tmgmt_crowdin_post_update_delete_crowdin_settings()` removes the old
`crowdin.settings` config once its `personal_token` / `project_id` / `domain` values match the new
`tmgmt.translator.crowdin` settings; if they differ it leaves the legacy config in place and prints a
message linking to the translator edit form (avoids data loss).

## Operating notes

- No `*.permissions.yml` — access to the connection settings is governed by TMGMT's own translator/
  provider admin permissions.
- No services.yml, no Drush commands. Config schema is provided (`provides_config_schema: true`).
