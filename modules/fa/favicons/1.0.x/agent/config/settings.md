<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings form & config (favicons.settings)

File: `src/Form/FaviconConfigForm.php` — `Drupal\favicons\Form\FaviconConfigForm extends ConfigFormBase`.
Form id `favicon_config_form`; editable config = `favicons.settings` (`getEditableConfigNames()`).

## Route & access

- Route `favicons.settings.form` → `_form: '\Drupal\favicons\Form\FaviconConfigForm'` at
  `/admin/config/search/favicons`, requirement `_permission: 'administer favicons'`.
- Permission `administer favicons` (`favicons.permissions.yml`): title *Upload and configure favicon*,
  `restrict access: TRUE` (marked as a security-sensitive admin permission).
- Menu link `favicons_settings` (`favicons.links.menu.yml`) under `system.admin_config_search`, weight -20.
- `configure: favicons.settings.form` is declared in `favicons.info.yml` (Configure link on the Extend page).

## Form fields (`buildForm()`)

| Field | `#type` | Required | Notes |
|-------|---------|----------|-------|
| `name` | textfield | yes | Site name used in the manifest. |
| `short_name` | textfield | yes | Short name used in the manifest. |
| `theme_color` | textfield | yes | Hex value only, no `#`; `#size`/`#maxlength` 6 (e.g. `FFFFFF`). |
| `background_color` | textfield | yes | Hex value only, no `#`; `#size`/`#maxlength` 6. |
| `favicon` | managed_file | no | `#upload_location: 'public://'`, `#upload_validators: FileExtension => extensions 'png'` (PNG only). |

## Config object & schema

`config/schema/favicons.settings.schema.yml` types the `favicons.settings` mapping:

- `name` (string), `short_name` (string), `theme_color` (string), `background_color` (string),
  `favicon` (int — the managed file id of the uploaded source image).

No `config/install/favicons.settings.yml` ships, so the object is created on first save (values are otherwise
`NULL` and the controllers/generator treat a `0`/absent `favicon` fid as "not configured").

## Submit behaviour (`submitForm()`)

1. Reads the uploaded managed file id from `favicon`. If present, loads the `file` entity.
2. Ensures `public://favicons/` exists (`mkdir` if missing).
3. If the uploaded file differs from the currently-stored fid, moves it to
   `<default_scheme>://favicons/<filename>` (`FileSystem::move(..., FileExists::Replace)`), updates the file
   entity URI, marks it permanent (`setPermanent()`) and saves it.
4. Writes `name`, `short_name`, `theme_color`, `background_color` and the resolved `favicon` fid into
   `favicons.settings` (`configFactory->getEditable(...)->save()`).
5. Calls `FaviconsGenerator::generateIcons($fid)` to build the derivatives (catches
   `InvalidPluginDefinitionException` and surfaces it via Messenger). See [../api/generator.md](../api/generator.md).

To change the icons later, upload a new PNG and save again; the derivatives regenerate from the new source.
