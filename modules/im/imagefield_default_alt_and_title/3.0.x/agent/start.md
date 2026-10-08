<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Imagefield Default Alt And Title (imagefield_default_alt_and_title) — agent index

Fills empty image **alt** and **title** attributes with the host entity's label (node title,
term name, product title). Two independent mechanisms: a client-side autofill on the entity
edit form, and a server-side **batch** backfill for existing content. The default text is
always the entity label — there is no configurable text and no token replacement.

- No hard module dependencies. Core `^10.3 || ^11`, PHP `>= 8.1`.
- `configure` route: `imagefield_default_alt_and_title.settings` → `/admin/config/search/imagefield-default-alt-and-title` (`administer site configuration`).
- No permissions defined (both routes use core `administer site configuration`); no drush; no plugins; no config schema.

Solutions:
- **Turn on the edit-form autofill for chosen bundles** → [configure/settings.md](configure/settings.md)
- **Backfill alt/title on existing content in bulk** → [configure/batch.md](configure/batch.md)

Key facts:
- Config object `imagefield_default_alt_and_title.settings`, single key `imagefield_default_alt_and_title_entity_types` (array of bundle machine names that get the edit-form JS).
- Settings route/form: `imagefield_default_alt_and_title.settings`, class `ImagefieldDefaultAltAndTitleForm`, form id `imagefield_default_alt_and_title`.
- Batch route/form: `imagefield_default_alt_and_title.batch` → `.../batch-page`, class `ImagefieldDefaultAltAndTitleBatchForm`, form id `imagefield-alt-title-batch`.
- Batch processor: `Drupal\imagefield_default_alt_and_title\ImagefieldDefaultAltAndTitleBatch::processBatch()` / `::finished()`.
- JS library `imagefield_default_alt_and_title/image-data` (`js/imagefield_default_alt_and_title.js`, behavior `initImgAltTitle`), attached by `hook_form_alter`.
- Supported entity types (bundles offered): `node_type`, `taxonomy_vocabulary`, `commerce_product_type`.
- `hook_uninstall` deletes the settings config; `hook_help` renders `README.txt`.
