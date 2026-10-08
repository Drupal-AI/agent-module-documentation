# bootstrap_layout_builder — agent start

Adds Bootstrap grid rows/columns as **section layouts** to core Layout Builder. Registers one
core Layout plugin (`bootstrap_layout_builder`) whose derivatives come from `blb_layout` config
entities (1–12 columns). Per-section UI has Layout/Style/Settings tabs: per-breakpoint column
structure, container type, gutters, plus `bootstrap_styles` styling on the container wrapper.
Depends on core `layout_builder` and `drupal/bootstrap_styles`. Admin config lives under
**Admin → Config → Content → Bootstrap Layout Builder** (`/admin/config/bootstrap-layout-builder`);
global settings route `bootstrap_layout_builder.settings`. Permission: `configure bootstrap layout builder`.

- Enable BLB on a view mode, use the section UI (breakpoints/container/gutters/styles), global settings, permission → [configure/bootstrap_layout_builder.md](configure/bootstrap_layout_builder.md)
- Add custom breakpoints, layouts, and layout options; deriver/theme internals → [extend/bootstrap_layout_builder.md](extend/bootstrap_layout_builder.md)
