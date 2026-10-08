<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Is Public (entity_is_public) — agent index

Service + hook API to determine whether a **content entity** (or entity type) is **publicly
accessible to anonymous users**. Version **1.0.0**. Core `^10.2 || ^11 || ^12`. License
GPL-2.0-or-later. Package: none declared.

- **Depends on** `helper:helper` (composer `drupal/helper >= 1.50`). Test-only deps
  (`require-dev`): field_redirection, metatag, micronode, rabbit_hole, trash, xmlsitemap —
  integrations activate when those modules are present.
- **Reports** accessibility for sitemaps / indexing / feeds; it does **not** grant or enforce
  access (core `hook_entity_access` remains authoritative).
- **Provides no** entities, plugins, permissions of its own, or Drush commands.

## What it actually is

- **Service `entity_is_public`** (class `\Drupal\entity_is_public\EntityIsPublic`, interface
  `EntityIsPublicInterface`, both aliased/autowired in `entity_is_public.services.yml`). Three
  public methods: `isApplicableType()`, `isTypePublic()`, `isPublic()`.
- **Hooks it defines** (`entity_is_public.api.php`): `hook_entity_type_is_public_alter()`,
  `hook_entity_is_public()` (return FALSE to veto, NULL for no opinion), and
  `hook_entity_is_public_alter()`.
- **Hook implementations it ships** on behalf of other modules
  (`src/Hook/EntityIsPublicHooks.php`, dispatched from `entity_is_public.module` `#[LegacyHook]`
  wrappers): media, field_redirection, system, micronode, path, rabbit_hole, xmlsitemap, metatag,
  trash — plus its own `entity_type_alter`, `xmlsitemap_link_alter`, `metatags_alter`.
- **One route/form**: `entity_is_public.settings` at `/admin/config/system/entity-is-public`
  (`administer site configuration`), config object `entity_is_public.settings`.

## Solution docs

- **Service API — the three methods, the anonymous-access simulation, `skipModules`** →
  [api/service.md](api/service.md)
- **Hooks it defines and the integrations it ships** → [api/hooks.md](api/hooks.md)
- **Settings form, config object + schema, menu/route** → [config/settings.md](config/settings.md)
