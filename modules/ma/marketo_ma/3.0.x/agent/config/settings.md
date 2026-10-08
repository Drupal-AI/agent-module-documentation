<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — marketo_ma

Config object: **`marketo_ma.settings`** (schema in `config/schema/marketo_ma.settings.schema.yml`).
Form: `Drupal\marketo_ma\Form\MarketoMASettings` at route `marketo_ma.settings`
(`admin/config/services/marketo-ma`), permission `administer marketo` (`restrict access: true`).
Second tab `marketo_ma.fields` (`.../fields`, `Form\MarketoMaFieldMgmt`) enables which Marketo fields
are available for mapping (stored in `field.enabled_fields`; catalogue fetched from Marketo REST
`describeUsingGET2` and cached in the `marketo_ma_lead_fields` table).

## Config keys
- `tracking_method` — `munchkin` (client-side JS, default) or `api_client` (server-side REST).
  Constants: `MarketoMaServiceInterface::TRACKING_METHOD_MUNCHKIN` / `TRACKING_METHOD_API`.
- `instance_host` — Forms 2.0 host (form field is `#access: FALSE`; currently unused).
- `logging` — verbose watchdog flag (form field `#access: FALSE`; currently a no-op).
- `munchkin.account_id` — Munchkin Account ID (format `000-AAA-000`); also derives the REST base URL
  `https://{account_id}.mktorest.com`. **Public** — emitted to the page as `drupalSettings.marketo_ma.key`.
- `munchkin.javascript_library` — tracker URL, default `//munchkin.marketo.net/munchkin.js`.
- `munchkin.api_private_key` — Munchkin API private key (**secret**, resolved via the secrets layer).
- `munchkin.partition|altIds|cookieLifeDays|clickTime|cookieAnon|domainLevel|disableClickDelay|asyncOnly`
  — advanced Munchkin `init()` params (assembled by `MarketoMaMunchkin::getInitParams()`).
- `rest.client_id`, `rest.client_secret` — REST OAuth credentials (**secret**, via secrets layer).
- `rest.batch_requests` — if truthy, REST lead updates are queued (`marketo_ma_lead`) and sent on cron
  instead of synchronously.
- `field.enabled_fields` — Marketo REST field names enabled for mapping.
- `tracking.request_path.mode` (0 = all pages except listed, 1 = only listed), `.pages` (one path per line,
  `*` wildcard). Default excludes `/admin`, `/admin/*`, `/batch`, `/node/add*`, `/node/*/*`, `/user/*/*`.
- `tracking.user_role.mode` + `.roles` — role visibility (empty roles = track everyone).

## Visibility logic (PageAttachment)
`shouldTrackCurrentRequest()` = `checkPageVisibility()` AND `checkRoleVisibility()`. Path matching compares
both the internal path and its alias (lowercased) with `PathMatcher`. Tracking only attaches when an
Account ID is set. Munchkin `associateLead` is only queued when tracking method is `munchkin`, the Munchkin
API is fully configured, and a `Lead` with an email is waiting in the user's private tempstore.

## Secrets storage (src/Secrets/)
`marketo_ma.secrets` is built by `SecretsFactory::createSecrets()`, which chooses by installed module:
1. **Encrypt** installed → `EncryptionSecrets` (values encrypted in config with the `encryption_key` from
   `settings.php`; implements `SaveableSecretsInterface`, so the settings form can write them).
2. otherwise → **`ImmutableConfigSecrets`** — reads the three secrets **directly from plain
   `marketo_ma.settings` config**. This is the default. Its own docblock warns this is not the right way to
   store secrets and suggests Key/Encrypt.

`KeySecrets` (native Key module) exists in the codebase but the factory never returns it. When the active
store is not `SaveableSecretsInterface`, the settings form replaces the three secret fields with a read-only
"stored in a secret that is not editable" message.
