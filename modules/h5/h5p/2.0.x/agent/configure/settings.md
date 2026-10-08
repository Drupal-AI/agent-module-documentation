# H5P settings

Config object **`h5p.settings`**; form route `h5p.admin.config.system.h5p` →
`/admin/config/system/h5p` (permission `administer site configuration`). Keys (with shipped
defaults):

| Key | Default | Meaning |
|---|---|---|
| `h5p_frame` | 1 | Show the H5P action bar/frame (download, embed, copyright buttons) |
| `h5p_export` | 3 | Download (export) button display option |
| `h5p_embed` | 3 | Embed button display option |
| `h5p_copyright` | 1 | Copyright button display option |
| `h5p_icon` | 1 | "About H5P" button display option |
| `h5p_default_path` | `h5p` | Directory (under files) where H5P stores content/libraries |
| `h5p_revisioning` | 1 | Keep content files per node revision (0 saves disk space) |
| `h5p_whitelist` | (long list) | Allowed file extensions inside H5P content |
| `h5p_library_whitelist_extras` | `js css` | Extra extensions allowed in libraries |
| `h5p_save_content_state` | 0 | Autosave learner content state (resume) |
| `h5p_save_content_frequency` | 30 | Autosave frequency (seconds) |
| `h5p_enable_lrs_content_types` | 0 | Enable LRS-dependent (xAPI) content types |
| `h5p_hub_is_enabled` | 1 | Use the H5P Hub to fetch content types |
| `h5p_send_usage_statistics` | 1 | Contribute anonymous usage statistics |
| `h5p_development_mode` | 0 | Development mode (disables some caching) |
| `h5p_site_uuid`, `h5p_site_type`, `h5p_content_type_cache_updated_at`, `h5p_first_runnable_saved` | — | Managed by the module (Hub/site identity, caches) |

The display-option values (`h5p_frame`/`h5p_export`/`h5p_embed`/`h5p_copyright`/`h5p_icon`) come from
H5P core's display-options constants; `0` effectively hides a button. All are stored as integers.

```bash
drush cget h5p.settings h5p_export
drush cset h5p.settings h5p_export 0 -y          # hide the Download button
drush cset h5p.settings h5p_default_path interactive -y
```

```php
\Drupal::configFactory()->getEditable('h5p.settings')
  ->set('h5p_send_usage_statistics', 0)
  ->save();
```

## Library administration

Not config — libraries live in the DB/filesystem and are managed at `/admin/content/h5p`
(`H5PLibraryAdmin`, permission `administer h5p libraries`): upload `.h5p` packages, install from the
Hub (needs the **h5peditor** submodule), restrict/delete libraries, upgrade content, rebuild cache
(`/admin/content/h5p/rebuild-cache`).
