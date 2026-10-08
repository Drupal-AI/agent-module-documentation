<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Fluid UI - Infusion (fluidui) — agent index

Integrates the **Fluid Project Infusion** library's **UI Options / Preferences
Framework** into front-end pages. Renders a "display preferences" toolbox that lets
visitors change font size, line height, font family, contrast theme, link style, and
generate a table of contents; choices persist in a `fluid-ui-settings` cookie. The
Infusion JS/CSS (v4.8.0, precompiled) is **bundled inside the module** (`infusion/`) —
loaded locally, no CDN. No module dependencies.

Core requirement: `^10.5 || ^11.2`. Configure at `/admin/config/fluidui/adminsettings`
(route `fluidui.admin_settings_form`). No permissions, drush commands, config schema, or
plugin types defined.

- **Change where/when the toolbox shows (admin pages, block mode, hidden paths)** → [configure/settings.md](configure/settings.md)
- **Understand how assets attach + the cookie→body-class rendering + swapping in a `/libraries/infusion` copy** → [theme/libraries.md](theme/libraries.md)
- **Place the toolbox as a placeable block** → [blocks/fluidui-block.md](blocks/fluidui-block.md)

## Key facts
- Config object: **`fluidui.adminsettings`** — keys `admin_display`, `fluidui_as_block`, `url_blacklist` (no schema/install file; keys created on first save).
- Route: `fluidui.admin_settings_form` → `\Drupal\fluidui\Form\FluidConfigForm` (`_permission: access administration pages`, `_admin_route: TRUE`). Menu link under `system.admin_config_system`.
- Libraries: **`fluidui/fluidui.infusion`** (bundled Infusion CSS + `infusion/infusion-all.js`) and **`fluidui/fluidui.theme`** (`css/fluid.css` + `js/fluidui_load.js`, which calls `fluid.uiOptions('.flc-prefsEditor-separatedPanel', …)`).
- Block plugin id: **`fluidui_block`** (`FluidUIBlock`); theme hook **`fluid_ui_block`** (template `fluid-ui-block.html.twig`).
- Hooks: `hook_page_top` + `hook_help` (attribute `#[Hook]` in `src/Hook/FluidUiHooks.php`); `hook_preprocess_page`, `hook_preprocess_html`, `hook_theme`, `hook_library_info_alter` (procedural in `fluidui.module`); `hook_install` / `hook_update_10301` (`fluidui.install`).
- `drupalSettings.modulePath` + `drupalSettings.translationsDirectory` pass asset/i18n paths to the JS. i18n via JSON files under `messages/{en,fr,es}`, copied to `public://fluidui-translations/` at install.
- Cookie read server-side: `fluid-ui-settings`.
