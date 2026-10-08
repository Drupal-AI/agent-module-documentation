<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Better Entity Reference (better_entity_reference) — agent index

Field widgets, form elements and a formatter that render entity-reference / list / media / file /
image field values as colored, reorderable **tags** (or thumbnail **tiles**), with a round "+"
popover to search, sort, filter, browse folders, upload and pick. Version **1.0.0-beta12**,
version-dir `1.0.x`. License GPL-2.0-or-later. Package *User interface*.

- **Dependencies:** Drupal core only, `^10.6 || ^11.3 || ^12`. No contrib deps. Taxonomy, `media`,
  `image`, `file` behaviors engage only when those modules / field types are present. No `php`
  constraint, no libraries.
- **Config:** no admin settings route (`configure` = null); no permissions of its own. One
  optional **settings.php** override, `better_entity_reference_staging_directory`. Provides config
  schema for every widget/formatter's settings.
- **Submodules:** `better_entity_reference_demo` (JS-API demo page + demo field), 
  `better_entity_reference_simplytest` (applies the demo recipe on install for sandboxes). Both
  documented under `modules/`.

## What it provides (from source)

- **Widgets** (`src/Plugin/Field/FieldWidget/`): `better_entity_reference_tags`
  (`EntityReferenceTagsWidget`, entity_reference fields), `better_options_tags`
  (`OptionsTagsWidget`, list_string/integer/float), `better_media` (`BetterMediaWidget`),
  `better_file` (`BetterFileWidget`), `better_image` (`BetterImageWidget`).
- **Formatters** (`src/Plugin/Field/FieldFormatter/`): `better_entity_reference_tags`
  (`TagsFormatter`, entity_reference) and `better_options_tags` (`OptionsTagsFormatter`, list).
  Label *"Better Tags"*.
- **Form elements** (`src/Element/`): `better_entity_reference` (`BetterEntityReference`) and
  `better_options` (`BetterOptions`) for reuse in custom forms.
- **Routes/controllers** (`better_entity_reference.routing.yml`, `src/Controller/`): 9 endpoints
  under `/better-entity-reference/*` (browse, quick-create, search, upload, media upload/browse/
  remote/form, file browse). All guarded by `src/Access/FieldWidgetAccess` + in-controller
  CSRF+HMAC (`src/SignedRequests`). No permission-gated routes.
- **Services** (autowired): `ColorGenerator` (stable per-entity colors), `OptionMetadata` (option
  color/description/type/parents/edit-url), `MediaItemBuilder`, `FileUsageTotals`, `Hook\Hooks`.
- **Hooks:** implements `hook_cron` (sweeps stale upload-staging dirs, `src/Hook/Hooks.php`).
  **Provides** alter hooks `hook_better_entity_reference_option_alter`,
  `hook_better_entity_reference_file_types_alter`, `hook_better_entity_reference_upload_details_alter`
  (see `better_entity_reference.api.php`).
- **JS libraries** (`better_entity_reference.libraries.yml`): `api`, `ui`, `widget`, `display`,
  `upload`, `media` — a framework-agnostic component kit (`window.BerUi`) plus the Drupal adapter
  (`Drupal.berUI` / `Drupal.berTags`).

## Solution docs

- Reference & options widgets, form elements, quick-create, folder browse / live search →
  [widgets/reference-and-options.md](widgets/reference-and-options.md)
- File, Image and Media widgets; chunked upload, file browser, media/oEmbed endpoints →
  [widgets/file-image-media.md](widgets/file-image-media.md)
- Better Tags formatter (entity-reference and list), color inheritance →
  [formatters/tags.md](formatters/tags.md)
- Endpoints, access model, staging directory, cron, settings.php →
  [config/endpoints-and-settings.md](config/endpoints-and-settings.md)
- JavaScript component kit and per-widget API (`Drupal.berUI` / `Drupal.berTags`) →
  [api/javascript.md](api/javascript.md)
