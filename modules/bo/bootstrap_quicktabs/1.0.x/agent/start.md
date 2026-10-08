# Bootstrap Quicktabs — agent index

Adds two Bootstrap `@TabRenderer` plugins to the **Quicktabs** module (hard dependency).
No config page of its own (`configure` null), no permissions, no schema, no Drush.
Configuration lives entirely in the Quicktabs instance edit form
(*Structure → Quick Tabs*) where you pick the renderer.

- **The two renderers, their options form, Ajax/default-tab behaviour, theme hooks and
  templates you can override** → [configure/renderers.md](configure/renderers.md)

Key facts:
- Renderer plugin IDs: `bootstrap_tabs`, `bootstrap_accordion`
  (`src/Plugin/TabRenderer/`), extending `quicktabs\TabRendererBase`.
- `bootstrap_tabs` options: `tabstyle` (tabs|pills), `tabposition`
  (basic|left|right|below|justified|stacked), `tabeffects` (fade).
- Theme hooks: `bootstrap_tabs`, `bootstrap_tabs_tabs`, `bootstrap_accordion`
  (templates in `templates/`). CSS library `bootstrap_quicktabs/bootstrap_tabs`.
- Targets Bootstrap 3 markup; a Bootstrap theme must supply the tab/collapse JS.
