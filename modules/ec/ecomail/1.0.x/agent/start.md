<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Ecomail (ecomail) — agent index

Low-level API integration between Drupal and the **Ecomail** (ecomail.cz) email-marketing platform.
Ships **one service** that wraps the bundled `ecomailcz/ecomail` PHP SDK; **no** user-facing forms,
blocks, fields, hooks, cron, queue or Drush of its own. Package `Custom`. Core `^9 || ^10 || ^11`.
License GPL-2.0-or-later. Version-dir 1.0.x (installed release 1.0.0-beta1).

- **Dependencies:** core `key` module (`key:key`); Composer libs `ecomailcz/ecomail` (dev-master, the
  bundled PHP SDK) and `drupal/key` (^1.19). No PHP version constraint declared.
- **Configuration + routes + permission** (settings form, `ecomail.settings` config object, the
  permission-name mismatch caveat) → [config/settings.md](config/settings.md)
- **The `ecomail.client` service** (`EcomailClientWrapper`) and its full API surface (lists,
  subscribers, campaigns, automations, templates, domains, transactional, transactions, feeds,
  events, search, coupons) → [api/client.md](api/client.md)

## What it actually is

- **Service** `ecomail.client` = `Drupal\ecomail\EcomailClientWrapper` (implements
  `EcomailClientWrapperInterface`), defined in `ecomail.services.yml`; args `@config.factory`,
  `@key.repository`, `@logger.factory`. It instantiates `new \Ecomail($apiKey)` and delegates ~45
  methods to that SDK, decoding each response.
- **Settings form** `Drupal\ecomail\Form\SettingsForm` at route `ecomail.settings`
  (`/admin/config/services/ecomail`); one field: a `key_select` for the Ecomail API key. Writes the
  `ecomail.settings` config object, key `api_key` (holds the **Key entity name**, not the secret).
- **Permission** `administer ecomail` (`ecomail.permissions.yml`, `restrict access: TRUE`). Note: the
  route actually requires `administer ecomail configuration` — see the config doc.
- **Config schema** `config/schema/ecomail.schema.yml` exists but is a stub (declares only `example`,
  not `api_key`).
- No entities, no plugin types, no `.module`/`.install` file, no update hooks.
