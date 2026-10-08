# jquery_ui_tooltip — agent start

Re-provides the single jQuery UI **Tooltip** widget as an asset library after jQuery UI was
deprecated and removed from Drupal core. No config UI, no permissions, no services, no config
schema — you enable it and attach the library. Hard-depends on the `jquery_ui` base module
(`>=8.x-1.7`). jQuery UI is End-of-Life upstream — prefer a maintained tooltip for new code.

- **Attach the tooltip library** (`#attached`, `dependencies:`, the `jquery_ui` dependency, why it
  exists post core-removal) → [theming/jquery_ui_tooltip.md](theming/jquery_ui_tooltip.md)

Quick reference:

- Library id: `jquery_ui_tooltip/tooltip` (vendored jQuery UI 1.13.2 `tooltip-min.js` + base `tooltip.css`).
- The definition is registered by the `jquery_ui` module's `hook_library_info_alter()` reading
  `jquery_ui.libraries.data.json`, under this module's `jquery_ui_tooltip` namespace — this module
  itself ships only an `.info.yml`.
- Depends transitively on `core/jquery`, `jquery_ui/widget`, `jquery_ui/position` and internal
  `jquery_ui/*` helpers, so the `jquery_ui` module must be enabled.
