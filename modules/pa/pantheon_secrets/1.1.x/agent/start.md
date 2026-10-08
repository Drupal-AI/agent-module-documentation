<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pantheon Secrets — agent index

Adds **one Key-module key provider** (`id: pantheon`) that reads a value from Pantheon's
Customer Secrets service, plus a bulk importer that turns every visible secret into a Key
entity. No settings form of its own (`configure: null`), no plugin types, no hooks.

- **Create / inspect a Key backed by a Pantheon secret; config shape & sync UI** →
  [configure/keys.md](configure/keys.md)
- **`pantheon-secrets:sync` Drush command** → [drush/sync.md](drush/sync.md)
- **Provider plugin internals + `pantheon_secrets.secrets_syncer` service** →
  [api/secrets-syncer.md](api/secrets-syncer.md)

Key facts:
- Config lives inside the **Key** entity, not in a module settings object:
  `key.key.<id>` → `key_provider: pantheon`, `key_provider_settings.secret_name: <name>`.
- Only permission: `sync pantheon_secrets keys` (gates `/admin/config/system/keys/pantheon`).
- Requires `drupal/key ^1.16`, PHP >= 8.2 and `pantheon-systems/customer-secrets-php-sdk`.
- Secrets are created **outside Drupal**:
  `terminus secret:set <site> --scope=web --type=runtime <name> <value>` (scope must be `web`).
