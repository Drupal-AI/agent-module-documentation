<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity 404 (entity_404) — agent index

Makes a content entity's **canonical page return 404 (not found)** when the entity fails
configured checks (hide entities as not-found; 404 vs 403 avoids confirming existence). Branch
`1.2.x` (installed release **1.2.1**). Core `^10.1 || ^11 || ^12`. License GPL-2.0-or-later.
Provides one permission (`configure entity 404`). **No module dependencies.**

Access-adjacent: it governs the **rendered page response**, not real entity access control. The
requirement is **additive** to core's `_entity_access` view check, so it only ever withholds a
page, never grants one. The entity may still be reachable via other routes, APIs, or listings —
pair with proper access control.

## Solution docs

- **Mechanism** — route alter, the two access checks, 403→404 conversion, PathValidator, language
  hooks, entity-form redirect → [mechanism/access-and-404.md](mechanism/access-and-404.md)
- **Configuration** — `entity_404.settings`, schema, install defaults, update hook, settings
  form/route/permission → [config/settings.md](config/settings.md)

## At a glance (from source)

- No plugins/entities. Provides two tagged `access_check` services (`applies_to: _entity_404`):
  `HasFullView`, `HasTranslation` (`src/Access/`, base `Entity404Base`).
- Event subscriber `EntityAccessSubscriber` adds `_entity_404: 'TRUE'` to content-entity
  `entity.*.canonical` routes (skipping form-as-canonical) and swaps the prefixed 403 for a 404.
- Decorates core `path.validator` (`src/Path/PathValidator.php`) to disable the translation check
  during path validation. Hook classes `LanguageHooks` (fallback candidates) and `EntityFormHooks`
  (redirect author to edit form when canonical 404s).
- Config `entity_404.settings`: `no_full_view`, `no_translation` (booleans). Form at
  `/admin/config/system/entity-404`, permission `configure entity 404`.

## 1.2.x changes

- **1.2.0**: Drupal 12 support (`core_version_requirement` now `^10.1 || ^11 || ^12`); language
  fallback support in the translation check; hooks migrated to OOP `#[Hook]` / `#[LegacyHook]`
  attribute classes.
- **1.2.1**: entity-form submit callback made static (`EntityFormHooks::submitForm`).

See `../1.1.x/` for the prior minor. `data.json` for metadata, `usage.md` for use cases.
