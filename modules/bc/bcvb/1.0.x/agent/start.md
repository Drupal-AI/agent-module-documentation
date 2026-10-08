<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bundle Class View Builder (bcvb) — agent index

Developer utility that bypasses core's entity view-display rendering: for opted-in content
entity types, the bundle class renders itself from a `build()` method. Core is left untouched
for any bundle that does not opt in.

- **Core:** `^10.3 || ^11`. **License:** GPL-2.0-or-later. **Deps:** none (runtime).
- **Suggests:** `drupal/bca` (attribute bundle discovery), `drupal/pinto` (OO theming). Both are
  dev-only in composer.json; not required to use BCVB.
- **Config:** `bcvb.settings` (`entity_types`, a sequence of entity type IDs). Default `[]`.
- **Configure route:** `bcvb.settings` at `/admin/config/content/bcvb`.
- **Permission:** `administer bcvb settings` (gates the settings form only).

## How it works
- `bcvb_entity_type_alter()` (`bcvb.module`) reads `bcvb.settings:entity_types` and calls
  `$entity_type->setViewBuilderClass(BcvbViewBuilder::class)` for each configured type.
- `Handler\BcvbViewBuilder` extends core `EntityViewBuilder` and uses `BcvbViewBuilderTrait`.
- `BcvbViewBuilderTrait::getBuildDefaults()` — if the entity implements
  `Entity\BuildableEntityInterface` and `shouldBuild($viewMode)` is TRUE, the render array is
  taken from `$entity->build($viewMode)` (cacheability merged); otherwise falls back to `parent`.
- `EventSubscriber\BcvbConfigSubscriber::onSave()` clears cached entity-type definitions when
  `bcvb.settings:entity_types` changes.

## What it provides
- Interface `Drupal\bcvb\Entity\BuildableEntityInterface` — `build(string $viewMode): array`,
  `shouldBuild(string $viewMode): bool`. Bundle classes implement this to render themselves.
- Trait `Drupal\bcvb\BcvbViewBuilderTrait` — reusable in custom view builders (e.g. subclasses of
  NodeViewBuilder / BlockContentViewBuilder) that can't extend `BcvbViewBuilder` directly.
- View builder class `Drupal\bcvb\Handler\BcvbViewBuilder`.
- Config form `Drupal\bcvb\Form\BcvbConfigForm`, event subscriber `BcvbConfigSubscriber`.
- No routes beyond the settings form, no services beyond the subscriber, no plugin types,
  no drush commands, no hooks besides `hook_entity_type_alter`.

## Solution docs
- Configuration & settings: [agent/config/settings.md](config/settings.md)
- Rendering an entity from its bundle class: [agent/api/buildable-entity.md](api/buildable-entity.md)
