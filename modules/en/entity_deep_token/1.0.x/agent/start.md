<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Deep Token (entity_deep_token) — agent index

Registers a custom token type **`entity-deep-token`** that reads values from fields of **related
entities** by walking entity-reference chains across multiple hops — beyond core's one-level tokens.
Depends on `token`. Package `Other`. Core `^10 || ^11`. License GPL-2.0-or-later. Version dir `1.0.x`
(installed release 1.0.3). No permissions, no Drush, no plugin types, no config schema shipped.

## What it actually is (from source)

- Two procedural hooks in `entity_deep_token.module`: `entity_deep_token_token_info()` and
  `entity_deep_token_tokens()`. No services, controllers, entities, or plugins.
- One admin form: `Drupal\entity_deep_token\Form\SettingsForm` (`ConfigFormBase`), route
  `entity_deep_token.settings` at `/admin/config/system/settings`, permission
  `administer site configuration`, menu link under Configuration → System.
- One config object `entity_deep_token.settings` with a single key `content_list` (checkboxes of
  content entity type ids that may act as token source entities). No `config/install` or
  `config/schema` directory ships.

## Solution docs

- **Token type, syntax, and the traversal algorithm** → [tokens/deep-token.md](tokens/deep-token.md)
- **Settings form, config object, route/permission** → [config/settings.md](config/settings.md)

## Quick facts

- Token to use: `[entity-deep-token:<field>:entity:<field>:entity:<property>]` (hyphens).
- Terminal keywords handled: `id`, `label`, `bundle`, `value`, `target_id`, `date`, numeric delta.
- Limitations: only the first delta of a reference field is followed; raw values are unformatted.
