<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drulma Companion (drulma_companion) — agent index

Helper module for the **Drulma** theme (a Bulma-CSS Drupal theme). Provides the front-end pieces
that belong in a module: Bulma block plugins, a Font Awesome 5 template-suggestion hook, an
entity-reference "labels as Bulma tags" field formatter, and a Drush subtheme generator. Package
**Bulma**. Version **2.2.0** (dir `2.2.x`). Core `^11.1`. License GPL-2.0-or-later.

- **Module dependency:** `block_class` (info.yml `block_class:block_class (^2 || ^4)`).
- **Composer also pulls:** `drupal/drulma` (the theme, `^2`), `drupal/hook_event_dispatcher` (`^4`).
- No settings form, **no permissions**, no routes, no custom entities/plugin types.
- Hooks are declared with core `#[Hook]` attributes (`drulma_companion.services.yml` sets
  `drulma_companion.hooks_converted: true`).
- Config schema in `config/schema/drulma_companion.schema.yml` (block settings + formatter settings).
- Ships submodule **`drulma_menu_item_fields`** → documented at
  [modules/drulma_menu_item_fields/2.2.x/agent/start.md](../../modules/drulma_menu_item_fields/2.2.x/agent/start.md).

## What it provides (from source)

Three **block plugins** (`src/Plugin/Block/`, all category *Bulma*):
- `drulma_companion_local_tasks_block` — **Tabs** (extends core `LocalTasksBlock`) → Drupal
  primary/secondary tabs as Bulma tabs.
- `drulma_companion_menu_tabs` — **MenuAsTabs** (extends `SystemMenuBlock`, `SystemMenuBlock`
  deriver) → any Drupal menu as Bulma tabs.
- `drulma_companion_bulma_navbar_with_branding` — **BulmaNavbarWithBrandingBlock** (extends
  `SystemMenuBlock`) → a Bulma navbar with logo/name/slogan + a start menu and optional end menu.
- Details, every config key, and the config-schema mapping → [plugins/blocks.md](plugins/blocks.md).

One **field formatter** (`src/Plugin/Field/FieldFormatter/LabelsAsBulmaTagsFormatter.php`):
- `drulma_entity_reference_label_tags` — *"Label as Bulma tag"*, on `entity_reference` fields,
  extends core `EntityReferenceLabelFormatter`. → [fields/labels-as-bulma-tags.md](fields/labels-as-bulma-tags.md).

Two **hook classes** (`src/Hook/`, `#[Hook]` attributes):
- `AddFontawesomeFiveSuggestions` — `hook_theme_suggestions_alter`, adds `__fa5` suggestions.
- `AddContainerClass` — `hook_themes_installed`, adds a Bulma `container` class to Drulma blocks.
- → [hooks/hooks.md](hooks/hooks.md).

One **Drush generator** (`src/Generators/SubthemeGenerator.php`, `drush.services.yml`
tag `drush.generator.v2`):
- `drush generate drulma` (alias `drulma`, DCG name `theme:drulma`) scaffolds a Drulma subtheme.
- → [drush/subtheme-generator.md](drush/subtheme-generator.md).
