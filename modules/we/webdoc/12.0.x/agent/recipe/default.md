<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Web Doc — the `recipes/default` recipe

`webdoc.install` (`webdoc_install($is_syncing)`) returns early when config is syncing; otherwise it runs `RecipeRunner::processRecipe(Recipe::createFromDirectory(__DIR__ . '/recipes/default'))`. So installing the module — or applying the recipe directly with `drush recipe web/modules/contrib/webdoc/recipes/default` — is the only way it acts. Re-running the recipe is idempotent for config it owns.

Source: `recipes/default/recipe.yml` + `recipes/default/config/*.yml`.

## `recipe.yml`
- `type: install`.
- `install:` `book`, `node`, `menu_ui`, `manage_display`, `pathauto`, `text`, `display_builder`, `display_builder_entity_view`, `display_builder_ui`, then `webdoc` last.
- `config.strict: false`.
- `config.import.display_builder: [display_builder.profile.default]` — brings in the Display Builder "default" profile the view displays reference.
- `config.actions`:
  - `book.settings` → `simpleConfigUpdate.allowed_types` set to one entry `{content_type: webdoc, child_type: webdoc}` — Web Doc pages may be book pages and may have Web Doc children.
  - `user.role.content_editor` → `grantPermissions`: `create webdoc content`, `edit own webdoc content`, `delete own webdoc content`, `view webdoc revisions`, `access book list`, `add content to books`, `create new books`. (Grants target the existing editorial `content_editor` role only; no grants to anonymous or authenticated.)

## Config entities created (`recipes/default/config/`)
- `node.type.webdoc.yml` — the `webdoc` node type. `new_revision: true`, `preview_mode: 1`, `display_submitted: true`; `third_party_settings.menu_ui` present (no menus enabled by default).
- `field.storage.node.body.yml` — reuses core's shared `node.body` storage (`text_with_summary`, cardinality 1). Present so a site without a prior body storage still gets it.
- `field.field.node.webdoc.body.yml` — `body` instance on `node.webdoc`, label "Body", not required, `display_summary: true`.
- `core.entity_view_mode.node.teaser.yml` (status true) and `core.entity_view_mode.node.full.yml` (status false by default).
- `core.entity_form_display.node.webdoc.default.yml` — form display: title, body (textarea with summary, 9 rows), created, uid autocomplete, path, url_redirects, status, and a `moderation_state` widget (content_moderation). `promote`/`sticky` hidden.
- `core.entity_view_display.node.webdoc.default.yml`, `...full.yml`, `...teaser.yml` — see [content-type/webdoc.md](../content-type/webdoc.md).
- `pathauto.pattern.webdoc.yml` — alias pattern `web-doc/[node:book:parents:join-path]/[node:title]`, selection criteria `entity_bundle:node` = `webdoc`, weight -5.

## Notes on dependencies pulled in
The three Display Builder view displays declare module deps `book`, `display_builder`, `manage_display`, `text`; the default form display declares `content_moderation`, `path`, `text`. `content_moderation` and `menu_ui` are therefore expected on the site (the recipe installs `menu_ui`; `content_moderation` ships with core and is referenced by the form display's `moderation_state` widget). `provides_config_schema` is **false** — the module has no `config/schema/` directory; all schema comes from the modules the recipe installs.
