<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, routes, permissions, view mode, Drush (epub_generator)

## Install / enable

`composer require drupal/epub_generator` then `drush en epub_generator`. Composer pulls
`andileco/php-epub` and requires PHP `>=8.3` with `ext-dom`, `ext-libxml`, `ext-zip`.
`hook_install()` (`epub_generator.install`) creates the **`node.epub`** view mode and shows a status
message pointing to *Manage display*. `epub_generator_update_10301()` backfills `strip_selectors`.

## Settings form

`EpubSettingsForm` (`src/Form/EpubSettingsForm.php`, `ConfigFormBase`), route
`epub_generator.settings` = `/admin/config/content/epub-generator` (perm `administer epub generator`;
menu link under *Configuration → Content authoring*, `epub_generator.links.menu.yml`). Editable
config: `epub_generator.settings`. Fields:

- `default_language` (required, validated `^[a-zA-Z]{2,3}(-[a-zA-Z0-9]+)*$`).
- `default_publisher` (blank → site name at generate time).
- `custom_stylesheet` (path or stream URI; validated to exist via `file_system->realpath()`).
- `strip_selectors` (textarea, one selector per line; validated by `CssSelectorToXpath::validateList`;
  stored via `splitList()`).
- `enabled_bundles` (checkboxes of `entity_type:bundle` for content entity types with a view builder;
  empty = all allowed).
- Layout details: `default_layout` (`reflowable` | `pre-paginated`), `default_viewport_width` (1024),
  `default_viewport_height` (768), `default_spread` (`auto`/`both`/`landscape`/`none`),
  `default_orientation` (`auto`/`landscape`/`portrait`).

## Config object & schema

`config/install/epub_generator.settings.yml` defaults; `config/schema/epub_generator.schema.yml`
types it as a `config_object` (strings, integers, and two `sequence`s of strings for
`enabled_bundles` and `strip_selectors`).

## ePub view mode

Content is rendered with the `epub` view mode when a matching `entity_view_display` exists for the
bundle, else `full`. Configure fields per content type at *Structure → Content types → Manage
display → ePub*. For non-node entity types, create the `epub` view mode manually at
*Structure → Display modes*.

## Download routes (`epub_generator.routing.yml`)

- `epub_generator.download` — `/epub/download/{entity_type}/{entity_id}` →
  `EpubDownloadController::download` (perm `generate epub`). Loads the entity, requires a content
  entity with a view builder, checks `$entity->access('view')` and `isBundleEnabled()`, renders the
  epub/full view mode with `renderer->renderInIsolation()`, derives metadata (label, `field_author`
  or owner, `body` summary, layout defaults), and returns one chapter.
- `epub_generator.node_download` — `/node/{node}/epub-download` → `EpubNodeDownloadController`
  (perm `generate epub`; `_custom_access` hides the tab for non-enabled bundles). Checks
  `$node->access('view')` and bundle, then either delegates to `epub_generator_book.book_assembler`
  (when present and the node is in a book) or renders the single node. Local task **Download ePub**
  (`epub_generator.links.task.yml`).

## Permissions (`epub_generator.permissions.yml`)

- `generate epub` — generate and download ePub files from content.
- `administer epub generator` — configure the module (`restrict access: true`).

## Drush (`src/Drush/Commands/EpubGeneratorCommands.php`)

- `epub:generate <id>` (alias `epub-gen`): `--entity-type=node`, `--output`, `--view-mode`. Verifies
  the entity type/entity, warns on unpublished, enforces `isBundleEnabled()`, renders, and writes the
  file (defaults to CWD).
- `epub:generate-book <nid>` (alias `epub-book`): requires the `epub_generator_book` submodule; errors
  if the node is not in a book, else assembles the whole book.
