<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# acquia_cms_document — agent index

Config/glue feature module of the **Acquia CMS** distribution (now "Acquia Drupal Starter Kit").
Installs a file-based **Document media type** (`media.type.document`) with its file/categories/tags
fields, two form displays, two view displays, and content translation — all shipped as config in
`config/optional/`. A little PHP defines the per-bundle media permissions and grants them to the
distribution's roles. No settings page (`configure` is null); no config schema, drush, or plugins of
its own. Depends on `acquia_cms_common` (which owns the shared field storages, vocabularies, view
modes, and editor helpers).

- **The Document media type and everything it installs (fields, displays, translation) + how to override** → [configure/media-type.md](configure/media-type.md)
- **The five per-bundle media permissions it declares** → [permissions/permissions.md](permissions/permissions.md)
- **How it grants those permissions to `content_author`/`content_editor` and its install-time behavior** → [hooks/roles.md](hooks/roles.md)

Key facts:
- Media type id `document`, source plugin `file`, source field `field_media_file`
  (`field.storage.media.field_media_file`), `new_revision: true`, `queue_thumbnail_downloads: false`.
- Source field `field_media_file` (`field.field.media.document.field_media_file`): type `file`,
  **required**, translatable, `uri_scheme: public`, cardinality 1,
  `file_directory: '[date:custom:Y]-[date:custom:m]'`, allowed
  `file_extensions: 'csv txt rtf pdf doc docx xls xlsx ppt pptx pps odt ods odp'`.
- Field **instances** `field_categories` (options_select → `categories` vocabulary) and `field_tags`
  (autocomplete tags → `tags` vocabulary) are installed here; their field **storages**
  (`field.storage.media.field_categories` / `field.storage.media.field_tags`) and the vocabularies
  come from `acquia_cms_common`.
- Form displays `default` and `media_library` group `field_categories`/`field_tags` in a `field_group`
  fieldset labelled **Taxonomy** (requires `field_group`); the `media_library` mode hides
  `field_media_file`.
- View displays: `default` (renders `thumbnail` via `image.style.card`, plus `created`/`uid`;
  file/taxonomy hidden) and `embedded` (renders `field_media_file` with the `file_default` formatter,
  `use_description_as_link_text: true`).
- Permissions declared in `acquia_cms_document.permissions.yml` (all `provider: media`):
  `create document media`, `edit own document media`, `delete own document media`,
  `edit any document media`, `delete any document media`.
- `acquia_cms_document_content_model_role_presave_alter()` (in `.module`) grants the create/edit-own/
  delete-own set to `content_author` and the edit-any/delete-any set to `content_editor`.
- `acquia_cms_document_install($is_syncing)` (in `.install`) runs
  `_acquia_cms_common_editor_config_rewrite()` on non-sync install.
- `language.content_settings.media.document` enables content translation for the `document` bundle.
- Dependencies (`.info.yml`): `media`, `media_library`, `acquia_cms_common`, `field_group`.
  Composer also requires `drupal/acquia_cms_common: ^1.9 || ^2.1 || ^3.1`.
