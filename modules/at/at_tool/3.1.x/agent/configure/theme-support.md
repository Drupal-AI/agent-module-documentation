<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theme-layer behavior & the theme settings it reads

AT Tool has **no settings page**. It reacts to the **active theme's** settings config
(`<active_theme>.settings` → the `settings` array), which an Adaptivetheme sub-theme populates.
On a non-Adaptivetheme theme (e.g. Olivero) those keys are simply absent and the features stay off.

## Settings keys read (in `<theme>.settings:settings`)

| Key | Used by | Effect |
|---|---|---|
| `enable_devel` | `at_tool_library_info_alter` | gate for developer features |
| `enable_live_reload` | `at_tool_library_info_alter` | inject the LiveReload script |
| `live_reload_port` | `at_tool_library_info_alter` | LiveReload port (default `35729`) → `//localhost:<port>/livereload.js` |
| `layouts_enable` | `at_tool_library_info_alter` | on admin routes, swap in the theme's layout-settings form CSS |

Read/set them (active theme here is the site default):

```bash
drush cget olivero.settings settings          # whatever the active theme is
```
```php
$theme = \Drupal::config('system.theme')->get('default');
\Drupal::configFactory()->getEditable($theme . '.settings')
  ->set('settings', ['enable_devel' => 1, 'enable_live_reload' => 1, 'live_reload_port' => '9000'])
  ->save();
```

## What the hooks do

- `at_tool_preprocess_system_themes_page(&$variables)` — attaches library
  `at_tool/appearance_settings` (the `appearance_settings` CSS) to the Appearance page and adds a
  cleaned CSS class (the theme's lowercased name) to each theme-selector wrapper.
- `at_tool_library_info_alter(&$libraries, $extension)` — when the active theme's settings enable
  devel + live reload, sets `at.livereload` JS to `//localhost:<live_reload_port>/livereload.js`;
  on admin routes, when `layouts_enable` is on, replaces the `layout_settings` CSS with the layout
  provider's form stylesheet (via `Drupal\at_core\Layout\LayoutCompatible`, from Adaptivetheme).

## Library

`at_tool.libraries.yml` defines `appearance_settings` (`css/appearance_settings.css`). That is the
only library AT Tool ships directly (others, like `at.livereload`, come from Adaptivetheme).
