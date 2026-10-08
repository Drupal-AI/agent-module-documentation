<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config, route & presave hook

Machine name `entity_links_autosave`. Enable: `drush en entity_links_autosave` (pulls in the parent
`entity_links_bulk_processor`).

## Permission

`entity_links_autosave.permissions.yml`:

- **`administer entity links autosave`** — `restrict access: true`. Required by the settings route.

## Route & menu

- `entity_links_autosave.settings` → `/admin/config/content/entity-links-autosave/settings`
  (`Form/AutoSaveSettingsForm`), `_permission: 'administer entity links autosave'`.
- Menu link `entity_links_autosave.settings` under `system.admin_config_content` (weight 11);
  `.info.yml` sets `configure: entity_links_autosave.settings`.

## Config object `entity_links_autosave.settings`

Install defaults in `config/install/`; schema (`config_object`) in `config/schema/`.

- `enabled` (bool, default **false**) — master switch for presave conversion.
- `enable_debug_logging` (bool, false) — verbose watchdog logging in the hook.
- `enable_user_feedback` (bool, true) — show conversion warnings to the editor via messenger.
- `entity_types` (sequence keyed by entity-type id) — each item is a mapping:
  - `enabled` (bool) — process this entity type;
  - `bundles` (string sequence) — bundles to process (empty = all);
  - `fields` (string sequence) — field names to process (empty = all text fields).
  Defaults ship entries for `node`, `paragraph`, `media`, `taxonomy_term`, `block_content`, all
  disabled. `AutoSaveSettingsForm` builds these options from the injected
  `entity_links_bulk_processor.entity_type_discovery` service.

## Presave hook (`entity_links_autosave.module`)

`entity_links_autosave_entity_presave()` — see the index for the ordered logic. Key points: it
defers to bulk runs via the state flag `entity_links_bulk_processor.processing`; it delegates all
transformation to the parent's `entity_links_bulk_processor_process_attributes()`; and all
conversion *rules* (domains, aliases, CSS mappings, media conversion, phone formats, multilingual
options) come from the parent's `entity_links_bulk_processor.settings`, not from this submodule.
