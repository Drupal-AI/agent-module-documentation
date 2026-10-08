<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration: `dlf_aim_3d_viewer.settings`

One config object drives the whole module. Schema in
`config/schema/dlf_aim_3d_viewer.schema.yml` (type `config_object`), install defaults in
`config/install/dlf_aim_3d_viewer.settings.yml`.

## Edit it

- **UI**: `/admin/config/dlf_aim_3d_viewer` — form `DlfAim3dViewerConfigForm`
  (`src/Form/DlfAim3dViewerConfigForm.php`, `FormBase`, id `dlf_aim_3d_viewer_settings_form`),
  route `dlf_aim_3d_viewer.config_menu`, permission **`administer dlf_aim_3d_viewer`**
  (`restrict access: TRUE`). A second route `dlf_aim_3d_viewer.menu` renders the admin menu block
  at the same path. Menu links live under *Configuration* (`.links.menu.yml`).
- **Drush**: `drush dlf_aim_3d_viewer:configure` (alias `dlf_aim_3dv-config`) — see below.

Both paths funnel through the **`dlf_aim_3d_viewer.config_applier`** service
(`DlfAim3dViewerConfigApplier`): `apply()` intersects input with `SETTING_KEYS`, runs
`prepareValues()` (normalizes `base_module_path` to a leading-slash path; when `lightweight` is on,
**blanks** the `LIGHTWEIGHT_OPTIONAL_KEYS`: metadata/json-export URLs, api_3d_file_field,
image_generation, field_df, export_viewer(+url), gallery_*), validates `REQUIRED_KEYS`
(throws `InvalidArgumentException` if any of main_url, container, entitybundle, viewer_file_upload,
viewer_file_name, scale_container_x/y, base_module_path, view_entity_path, attribute_id is empty),
then saves.

## Keys (schema mapping)

| Key | Type | Meaning |
|---|---|---|
| `dlf_aim_3d_viewer_main_url` | string | Repository main URL (default `https://dfg-repository.wisski.cloud`). Used as base for public URLs and the WissKI savePreview host. |
| `dlf_aim_3d_viewer_basenamespace` | string | Optional absolute-URL prefix for viewer paths (if different from main URL). |
| `dlf_aim_3d_viewer_metadata_url` | string | Instance that serves metadata (full mode only). |
| `dlf_aim_3d_viewer_json_export_base_url` | string | Base URL for JSON export (default `https://repository.covher.eu`). |
| `dlf_aim_3d_viewer_container` | string | DOM id of the viewer container element (default `DLF_AIM_3DViewer`). |
| `dlf_aim_3d_viewer_entitybundle` | string | Machine name of the target bundle whose saves trigger conversion (hook check). |
| `dlf_aim_3d_viewer_viewer_file_upload` | string | Field name/ID holding the **uploaded source** model file. |
| `dlf_aim_3d_viewer_viewer_file_name` | string | Field name/ID holding the **converted derivative** the formatter prefers. |
| `dlf_aim_3d_viewer_api_3d_file_field` | string | Extra candidate field for the model URL in XML export enrichment. |
| `dlf_aim_3d_viewer_image_generation` | string | Field the savePreview route sets to the generated preview file. |
| `dlf_aim_3d_viewer_field_df` | string | "Field DF" (default `field_df`). |
| `dlf_aim_3d_viewer_export_viewer` / `_export_viewer_url` | string | Export-viewer field / URL. |
| `dlf_aim_3d_viewer_lightweight` | boolean | Viewer-only mode: no conversion pipeline, optional URL/field keys blanked. |
| `dlf_aim_3d_viewer_scale_container_x` / `_y` | string | Viewer container scale factors (defaults `1` / `1.4`). |
| `dlf_aim_3d_viewer_gallery_container` / `_image_class` / `_image_id` | string | CSS selectors wiring the viewer's gallery to existing page markup. |
| `dlf_aim_3d_viewer_base_module_path` | string | Path to the viewer's built assets (default `/libraries/dlf_aim_3d_viewer/dist/drupal/main/assets`). |
| `dlf_aim_3d_viewer_entity_id_uri` | string | Regex extracting the entity id from a URL (default `/wisski/navigate/(.*)/view`). |
| `dlf_aim_3d_viewer_view_entity_path` | string | Entity view base path (default `/wisski/navigate/`). |
| `dlf_aim_3d_viewer_attribute_id` | string | WissKI attribute id (default `wisski_id`). |

Note the several long hex default values (e.g. `entitybundle`, `viewer_file_upload`) are WissKI
field/bundle machine-name hashes; on a standard Drupal site set these to your own field machine
names. Throughout the code every read is `get('dlf_aim_3d_viewer_<key>') ?? get('<short key>')`,
so legacy short keys are still honored.

## How config becomes runtime

- `dlf_aim_3d_viewer_build_js_settings()` (`.module`) assembles the nested `drupalSettings`
  object (baseNamespace, mainUrl, metadataUrl, jsonExportBaseUrl, baseModulePath, `entity.*`,
  `viewer.*` incl. `lightweight`/`editor` and `gallery.*`). `editor` is the inverse of `lightweight`.
- `dlf_aim_3d_viewer_init_constants()` / `dlf_aim_3d_viewer_config()` define `DLF_AIM_3D_VIEWER_*`
  PHP constants from the same values (used by `DlfAim3dController`).

## Drush `dlf_aim_3d_viewer:configure`

`src/Drush/Commands/DlfAim3dViewerCommands.php`. With no options it applies
`DlfAim3dViewerConfigApplier::getDevPreset()` (a local-dev preset: `main-url` `http://dev.wisski.local/`,
lightweight **on**, container `DLF_AIM_3DViewer`, the standard field/bundle hashes, etc.). Each
setting has a matching `--kebab-case` option (`--main-url`, `--lightweight=0|1`, `--entitybundle`,
`--viewer-file-upload`, …) that overrides the preset before `apply()`. Useful for CI/config
bootstrapping without clicking through the form.
