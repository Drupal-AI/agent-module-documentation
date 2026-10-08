Color Scheme Switcher (cosesi) gives Drupal 11 visitors a frontend Light/System/Dark color-scheme toggle, backed by a placeable block and an early-injected inline style/script that persist the choice in localStorage.

---

The module renders an inline `<style>` and `<script>` very early in `<head>` (weights -499/-498) that set the CSS `color-scheme` custom property on `:root` and toggle a configurable class on the `<html>` element (e.g. `color-scheme-dark`), so themes can style light and dark modes with plain CSS while flash-of-unstyled-content is minimised. A `Color Scheme Switcher` block (plugin id `cosesi_switcher`) offers two widget types — Buttons (one `<button>` per state) and Dropdown (a `popover`) — each backed by a render element (`cosesi_switcher_buttons` / `cosesi_switcher_dropdown`) and an icon pack (`cosesi_solid`) shipping sun / sun-and-moon / moon SVGs. The three states are Light (`light`), System/Auto (`light dark`), and Dark (`dark`); System resolves to the OS `prefers-color-scheme` preference and reacts to live OS changes. Per active frontend theme, the CSS variable name and the `htmlClass`/`hideClass` for each state are configured at `/admin/appearance/cosesi-theme-settings` (`EditForm`, permission `administer themes`) and stored in the `cosesi.theme_settings` config object. The client logic lives in `libraries/switcher_api/index.js` (`ColorSchemeSwitcher` class), with widget behaviour in the two `switcher_widget_*` libraries. Requires PHP >= 8.4, Drupal core ^11.3, and the core `config` module.

---

- Add a Light/System/Dark theme toggle to a Drupal 11 site without writing custom JS.
- Let visitors override the OS color-scheme preference and pick a scheme manually.
- Persist a visitor's chosen scheme across page loads via localStorage.
- Respect the operating system's `prefers-color-scheme` when in System (Auto) mode.
- React automatically to a live OS light/dark switch while the visitor is in System mode.
- Set the CSS `color-scheme` property on `:root` so browser-native form controls follow the theme.
- Toggle a configurable class (e.g. `color-scheme-dark`) on `<html>` for CSS-driven theming.
- Minimise flash-of-unstyled-content by injecting the switcher CSS/JS early in `<head>`.
- Place the switcher as a Buttons widget (one button per state) in any block region.
- Place the switcher as a Dropdown/popover widget to save space in a header or toolbar.
- Configure the CSS custom-property name per active frontend theme (default `color-scheme`).
- Configure per-state HTML classes independently for each enabled frontend theme.
- Hide scheme-specific elements (e.g. a dark-only banner) using the per-state `hideClass`.
- Show a light-only logo and a dark-only logo, each auto-hidden in the opposite scheme.
- Customise per-state button labels and icon sizes in the block configuration form.
- Reuse the `cosesi_switcher_buttons` / `cosesi_switcher_dropdown` render elements directly in custom render arrays.
- Consume the `cosesi_solid` icon pack (sun / sun-and-moon / moon) via Drupal's icon API.
- Export the resulting `cosesi.theme_settings` config with the rest of the site configuration.
- Keep theme settings clean automatically: config for a theme is removed when that theme is uninstalled.
- Inject the switcher API via the `ThemeSettings\Provider` service from custom code that builds its own UI.
- Offer an accessible toggle using semantic `<button>` elements and `aria-pressed` / popover attributes.
- Support multiple enabled frontend themes, each with its own variable name and class configuration.
- Provide a dark-mode experience that survives hard refreshes without a server round-trip.
