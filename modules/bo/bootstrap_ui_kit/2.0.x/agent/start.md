<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap UI Kit (bootstrap_ui_kit) — agent index

Provides an in-site **UI kit / living style guide** at **`/ui-kit`** for a Bootstrap-5 themed site.
The page renders a configurable sidebar of *groups → sections*, where each section shows foundations
(color, typography, iconography) or previews of **Single Directory Components (SDC)** assigned through
the admin UI. Components inherit the active theme's styles; the module ships **no Bootstrap CSS/JS of
its own** (0 Drupal module dependencies — a Bootstrap-5 theme is expected) and its **only** Composer
requirement, `twbs/bootstrap-icons`, is **bundled under `vendor/`** and used as the default icon
source. Component previews are data-driven: site builders assign an SDC `provider:machine` id plus
props, an optional **variant**, or a discovered **story** YAML, all stored in the `glossary` config.

The moving parts: a controller renders `/ui-kit` (actually drawn by `page--ui-kit.html.twig` via the
path-based `page__ui_kit` suggestion and hydrated in `hook_preprocess_page__ui_kit`); three admin
forms edit the glossary tree and component assignments; three services parse component definitions,
discover story files, and turn story YAML (props + slots + wrapper) into render arrays; and a
**tagged-service slot pipeline** (`bootstrap_ui_kit.slot_type`) makes slot rendering extensible.

- Depends on: **no Drupal modules** (`.info.yml` has no `dependencies:`). Composer: `twbs/bootstrap-icons ^1.10` (bundled). Runtime expectation: a Bootstrap-5 theme; SDC previews use core `plugin.manager.sdc`.
- Core: `^8 || ^9 || ^10 || ^11`. Package: `User interface`. Version **2.0.0**.
- Has a settings page: `configure: bootstrap_ui_kit.settings`. **Provides 2 permissions**, **config schema**, Twig extensions, and a local-task deriver. **No drush, no Drupal "plugin type"** (the slot extension point is a service tag, not a plugin manager).
- The component-assignment form uses a `cl_component_selector` render element from the *cl_editorial* ecosystem — an **undeclared soft dependency** for that one UI.

## What you'd do → where

- **Turn on dev mode / point the iconography at an SVG folder or sprite / config keys / permissions** →
  [configure/settings.md](configure/settings.md)
- **Add or reorder sidebar groups & sections, assign SDC components (props / variant / story) to a section** →
  [configure/glossary.md](configure/glossary.md)
- **Understand the routes, controller, the three services, Twig extensions and hooks / call them from code** →
  [api/services.md](api/services.md)
- **Add a custom slot-type handler or author a component story YAML** →
  [plugins/slot-types.md](plugins/slot-types.md)

## Key facts (real machine names)

- Routes: `bootstrap_ui_kit.ui_kit` (`/ui-kit`, perm `access bootstrap ui kit`),
  `bootstrap_ui_kit.settings`, `bootstrap_ui_kit.glossary`, `bootstrap_ui_kit.sections`,
  `bootstrap_ui_kit.component` (`/admin/appearance/bootstrap_ui_kit/…`, perm
  `administer site configuration`).
- Controller: `Controller\BootstrapUiKitController::content`. Forms: `BootstrapUiKitSettingsForm`,
  `BootstrapUiKitGlossaryForm`, `SectionsListForm`, `GlossarySectionComponentForm`.
- Services: `bootstrap_ui_kit.content_injection_manager` (`ContentInjectionManager`),
  `bootstrap_ui_kit.component_definition_repository` (`ComponentDefinitionRepository`),
  `bootstrap_ui_kit.story_discovery` (`StoryDiscovery`).
- Slot handlers (tag `bootstrap_ui_kit.slot_type`, `SlotTypeHandlerInterface`):
  `…slot_type.component` (100), `.image` (95), `.html_tag` (90), `.icon` (80), `.markup` (10).
- Twig extensions: `bootstrap_ui_kit.file_get_contents` (`fileGetContents()`),
  `bootstrap_ui_kit.attribute_tools` (`to_attributes` filter/function),
  `bootstrap_ui_kit.macro_autoload` (`macro_*`, marked broken).
- Permissions: `access bootstrap ui kit`, `access bootstrap ui kit dev mode`.
- Config object `bootstrap_ui_kit.settings` keys: `enable_dev_kit`, `icons_source_folder`,
  `icons_sprite_file`, `selected_icons`, `glossary` (groups → sections → components).
- Theme hook `page__ui_kit` (template `page--ui-kit.html.twig`). Local-task deriver
  `Plugin\Derivative\GlossarySectionComponentsDeriver` (references a non-existent base route — see
  configure/glossary.md).
