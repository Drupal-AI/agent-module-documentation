# bootstrap_layouts — agent start

Registers 11 Bootstrap grid layout plugins (rows + responsive `.col-*` columns) for the core
Layout system, so they appear in Layout Builder, Display Suite, and Panels/Page Manager. All
layouts share `BootstrapLayoutsBase` (extends `LayoutDefault`). Depends only on core
`layout_discovery`. No admin route, no permissions, no default config — `configure` is `null`;
settings are stored per display by the consuming tool. Needs a Bootstrap-based theme for styling.

- Pick a layout + set region widths/classes/wrappers/attributes → [configure/bootstrap_layouts.md](configure/bootstrap_layouts.md)
- Define a custom layout or handler plugin (the two plugin types) → [plugins/bootstrap_layouts.md](plugins/bootstrap_layouts.md)
- Templates, generated classes, preprocess/theming → [theming/bootstrap_layouts.md](theming/bootstrap_layouts.md)
- Alter the available class options via hook → [hooks/bootstrap_layouts.md](hooks/bootstrap_layouts.md)
