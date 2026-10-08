# Shariff Sharing Buttons — agent index

Privacy-friendly social share buttons (heise online Shariff). One global settings form + two
placements: a **block** and a per-node **display field**. No custom permissions (uses core
*administer site configuration*), no Drush, no plugin types.

- **Global settings: config object, all keys, the settings form, defaults** →
  [configure/settings.md](configure/settings.md)
- **Placement + rendering: the `shariff_block` block, the `shariff_field` node display field,
  theming, the external JS library** → [api/block-and-field.md](api/block-and-field.md)

Key facts:
- Config object `shariff.settings`; settings form `shariff.settings_form` at
  `/admin/config/services/shariff`.
- Shipped defaults: `shariff_services: {twitter, facebook}`, `shariff_theme: colored`,
  `shariff_css: complete`, `shariff_orientation: horizontal`.
- Block plugin id `shariff_block`; extra display field id `shariff_field` (on all node types).
- Needs the external **Shariff JS library** in `/libraries/shariff/` (`hook_requirements`
  errors until present) — the *config* works regardless.
