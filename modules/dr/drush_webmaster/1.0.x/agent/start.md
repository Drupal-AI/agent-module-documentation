<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush Webmaster (drush_webmaster) — agent index

A CLI-only toolkit of ~100 `wm:*` Drush commands for AI-assisted Drupal site building. **No HTTP
routes, no controllers, no settings form, no plugins.** Each command class
(`src/Drush/Commands/*Commands.php`) is a thin wrapper over a Service manager
(`src/Service/*Manager.php`), and mutating commands run their input through validators
(`src/Validator/*`). All commands print **structured YAML**. **Version dir 1.0.x = release
`1.0.0-beta1` (PRE-RELEASE beta).**

- Core deps (`drush_webmaster.info.yml`): **node, field, user**. PHP **8.1**. Core `^10.3 || ^11`.
- Composer: **no `composer.json`** ships in the project (no extra Composer requirements).
- Two optional submodules (documented separately, see bottom): `drush_webmaster_redirect`,
  `drush_webmaster_webform`.

## Architecture, permission model, output, config → [drush/overview.md](drush/overview.md)

Read this first. Covers: `WebmasterCommandsBase` (pre-command hook that **switches to user 1**
before every `wm:*` command; YAML/`success`/`error`/`notFound` helpers); the two permissions in
`drush_webmaster.permissions.yml` (`administer drush webmaster`, `use drush webmaster content
types`) and the fact that **the command code does not enforce them**; the empty `config/install` +
`config/schema` settings object and the `_update_9001` that removed a legacy `capabilities`
setting; `FileVersionManager` (where versioned files are written); `SetupCommands`
(`wm:setup-ai`); the 18-line `.module` (only `hook_help`).

## Command families (solution docs)

- **Content modeling** — content types, fields, vocabularies, media types →
  [drush/content-types-fields.md](drush/content-types-fields.md)
  (`wm:content-type:*`, `wm:field:*`, `wm:vocabulary:*`, `wm:media-type:*`)
- **Entities** — query/list/get, field get/set, clone/deep-clone/diff, the edit/apply/new/history/
  revert file workflow, and bulk create/update/delete →
  [drush/entities.md](drush/entities.md) (`wm:entity:*`)
- **Site structure** — views, menus, blocks →
  [drush/views-menus-blocks.md](drush/views-menus-blocks.md)
  (`wm:view:*`, `wm:menu:*`, `wm:block:*`)
- **Discovery & site** — schema dump, site info/update, core search →
  [drush/schema-search-site.md](drush/schema-search-site.md)
  (`wm:schema:*`, `wm:site:*`, `wm:search`)
- **Editorial** — moderation & translation →
  [drush/moderation-translation.md](drush/moderation-translation.md)
  (`wm:entity:transitions`, `wm:entity:moderate`, `wm:translation:*`, `wm:entity:translation:*`)

## Services (from `drush_webmaster.services.yml`)

Managers: `content_type_manager`, `field_manager`, `vocabulary_manager`, `entity_manager`,
`site_manager`, `views_discovery`, `view_manager`, `menu_manager` (injects `@database`),
`block_manager`, `media_type_manager`, `file_version_manager`, `entity_validation`,
`schema_manager`, `search_manager`, `moderation_manager`, `translation_manager`. Validators:
`content_type_validator`, `field_validator`, `entity_validator`. Command classes are registered in
`drush.services.yml` (tag `drush.command`).

## Submodules (own nested docs)

- **drush_webmaster_redirect** — `wm:redirect:*` (list/get/search/find/add/update/delete/stats/
  import/export). Needs `redirect:redirect`. →
  [../modules/drush_webmaster_redirect/1.0.x/agent/start.md](../modules/drush_webmaster_redirect/1.0.x/agent/start.md)
- **drush_webmaster_webform** — `wm:webform:*` + `wm:webform:submission:*`. Needs `webform:webform`. →
  [../modules/drush_webmaster_webform/1.0.x/agent/start.md](../modules/drush_webmaster_webform/1.0.x/agent/start.md)

## Quick facts

- Every mutating command accepts `--dry-run`; validators return `{field, value, error, suggestion}`.
- The edit/apply and clone commands persist versioned snapshots under `~/.drush-wm` (fallback
  `/tmp/drush-wm`) — see overview.
- Discover commands: `drush list wm`, `wm:schema:dump`, `wm:schema:sections`.
