# Configure — Seeds Toolbar settings

Form `SeedsToolbarSettingsForm` at **/admin/config/user-interface/seeds-toolbar**
(route `seeds_toolbar.configuration`, permission `administer seeds toolbar`). Writes the
`seeds_toolbar.settings` config object (no schema shipped).

## Keys

| Key | Form field | Install default | Effect |
|---|---|---|---|
| `style` | Style (select light/dark) | `dark` | Toolbar color scheme; adds `seeds-toolbar--<style>` body class. |
| `compact` | Compact (checkbox) | `true` | If true, toolbar starts collapsed (icon-only, ~55px); if false it starts open (~245px) and adds `seeds-toolbar-open`. |
| `search` | Show search input (checkbox) | `true` | Show the admin-menu search box (also needs `use admin search` perm). |
| `support` | Support URL (textfield) | `https://sprintive.com` | URL for the Support toolbar tab; empty hides the tab. Opens in a new tab. |
| `custom_style` | Custom Style (textfield) | — | Path/URL to an extra CSS file, injected into the `toolbar` library when set. |
| `dark_logo` | Custom Dark Logo Link | — | Logo image path used when `style` = dark (menu header). |
| `light_logo` | Custom Light Logo Link | — | Logo image path used when `style` = light. |
| `dark_icon` | Custom Dark Icon Link | — | Small icon path for dark mode. |
| `light_icon` | Custom Light Icon Link | — | Small icon path for light mode. |
| `fixed_elements` | Try to fix fixed elements (EXPERIMENTAL) | — | Loads `seeds_toolbar/fixed_elements` JS to stop fixed page elements overlapping the toolbar. |

Logos/icons are resolved as `"$base_url/<value>"` via `file_url_generator` in the preprocessors
(`seeds_toolbar_preprocess_seeds_toolbar` / `_seeds_toolbar_menu`); when empty the module's bundled
SVGs are used. The `<style>_logo` / `<style>_icon` key is chosen by the active `style`.

## Drush / config example

```
ddev drush config:set seeds_toolbar.settings style light -y
ddev drush config:set seeds_toolbar.settings compact false -y
ddev drush config:set seeds_toolbar.settings support 'https://help.example.com' -y
```

## Runtime notes

- Assets + `drupalSettings.seeds_toolbar` (`compact`, `support`, `style`) attach in
  `hook_page_attachments` only for users with core's `access toolbar` permission.
- `hook_library_info_alter` empties the core `toolbar` and `admin_toolbar` CSS/JS and (for
  admin_toolbar ≥ 3) tweaks classes; it also clears `devel-toolbar` CSS and wires
  `responsive_preview` when present.
- After changing settings, clear cache if styles don't update (`ddev drush cr`).
