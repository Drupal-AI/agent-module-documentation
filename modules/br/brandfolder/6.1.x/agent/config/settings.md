<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Brandfolder — configuration & settings

## Install / enable
`composer require drupal/brandfolder` (pulls `brandfolder/brandfolder-sdk-php` and `drupal/key`), then
`drush en brandfolder`. Requires core `media` + contrib `key`. `brandfolder_install()`/`brandfolder_schema()`
(`brandfolder.install`) create the `brandfolder_file` table. Update hook `brandfolder_update_10601()` exists.

## API keys (Key module)
API keys are **never stored in module config** — only *references* to Key entities are. In Brandfolder go to
My Profile → Integrations → API Keys, then create Drupal Key entities (any provider — env, file, config) and
select them on the settings form. Three role slots: `admin`, `collaborator`, `guest` (`api_key_ids.admin` etc.).
`BrandfolderKeyService::getApiKey($key_type)` (`src/Service/BrandfolderKeyService.php`) resolves a slot to a Key
ID, then `KeyRepository::getKey()->getKeyValue()`; if only a legacy plaintext `api_keys.$type` value exists it is
used and a warning is logged asking the admin to migrate. The global helper `brandfolder_api($key_type='guest')`
(`brandfolder.module:47`) builds a `BrandfolderClient` with the resolved key + `brandfolder_id`.

## Settings form
Route `brandfolder.brandfolder_settings_form` → `/admin/config/media/brandfolder`, permission
`administer brandfolder settings` (restricted). Form `src/Form/BrandfolderSettingsForm.php`, editable config
`brandfolder.settings`. Menu link under Configuration → Media. Sections:
- **credentials** — `key_select` element per role → stores `api_key_ids.{admin,collaborator,guest}`.
- **basic** — `brandfolder_id`; `preview_collection_id` (a Collection used to preview assets / test connectivity;
  the form renders sample images by calling `listAssets()`).
- **metadata** — `metadata_sync_mode` (default `empties_only`); `alt_text_custom_field` (ID of a Brandfolder custom
  field holding image alt text — shown only once connected).
- **bf_browser** — `customize_entity_browser_modal_pages`, `disable_system_messages_on_browser_pages`,
  browser modal height.
- **image_optimization** — `io_format_auto`, `io_format_auto_force`, `io_auto_webp`, `io_quality` (1–100).
- **advanced** — `verbose_log_mode` (logs API calls to the `brandfolder` channel; the SDK redacts the API key
  from its own log entries).

`validateForm()` normalizes the preview-collection value; `getEditableConfigNames()` returns
`['brandfolder.settings']`.

## Config schema
`config/schema/brandfolder.schema.yml` types every `brandfolder.settings` key above. It also defines
`field.field_settings.image.third_party.brandfolder` (`brandfolder_settings` string) — per-Image-field
third-party settings letting a plain core Image field opt into Brandfolder browsing.
