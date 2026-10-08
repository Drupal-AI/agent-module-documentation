# Configure

Settings form `Drupal\editoria11y\Form\Editoria11ySettings` at
`/admin/config/content/editoria11y` (route `editoria11y.settings`), stored in config object
`editoria11y.settings` (schema `config/schema/editoria11y.schema.yml`). A demo page lives at
`/admin/config/content/editoria11y/demo`.

Key settings (see `config/install/editoria11y.settings.yml` for the full list):

| Key | Meaning |
|---|---|
| `ed11y_theme` | Visual theme of the checker panel (e.g. `sleekTheme`). |
| `panel_pin` | Panel placement: `left` / `right`. |
| `assertiveness` | ARIA live-region assertiveness for announcements. |
| `content_root` | CSS selector limiting which region is scanned. |
| `ignore_elements` / `ignore_all_if_absent` | Selectors to skip. |
| `tests_off` | Comma list of test IDs disabled site-wide (default disables graphic-contrast, "click here", image-alt-as-link). |
| `ignore_tests` | Sequence of additional tests to suppress. |
| `disable_live` | Turn off live checking inside editing areas. |
| `disable_sync` | Disable server-side result/dismissal sync. |
| `live_h2` / `live_h3` / `live_h4` | Selectors for live CKEditor region checking. |
| `detect_shadow` / `shadow_components` | Shadow-DOM / web-component detection. |
| `watch_for_changes` | How dynamic DOM changes are re-checked (e.g. `checkRoots`). |
| `preserve_params` | Query params kept when identifying a page's results. |
| `custom_tests` | Enable custom test integration (used by CSA). |
| `hide_edit_links`, `link_ignore_selector`, `link_strings_new_windows`, `redundant_prefix`, … | Fine-grained link/region tuning. |

Read/write with drush, e.g.:
```
drush config:set editoria11y.settings panel_pin left -y
drush config:set editoria11y.settings content_root '.main-content' -y
```

The `ConfigCacheControlSubscriber` / `ConfigImportSubscriber` keep the front-end config cache in
sync when settings change or config is imported.
