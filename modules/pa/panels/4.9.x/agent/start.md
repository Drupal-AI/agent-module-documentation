# panels — agent start

Region-based page layout engine. Provides the `panels_variant` ctools **DisplayVariant**:
a display = one Layout (core Layout Discovery) + regions + blocks (panes). Ships **no
external UI** — pair with Page Manager, or enable the `panels_ipe` submodule for an
in-place editor. Depends on `ctools` and core `layout_discovery`. `configure: panels.admin`
(the Panels Dashboard route; Panels itself provides no settings form).

- Build a display: pick a layout, place blocks in regions (with Page Manager) → [configure/panels.md](configure/panels.md)
- Plugin types it defines — PanelsStorage, PanelsPattern, DisplayBuilder → [plugins/panels.md](plugins/panels.md)
- Services & the display-variant API (encode/decode, storage) → [api/panels.md](api/panels.md)
- Alter rendered output & layout icons; theming hooks → [theming/panels.md](theming/panels.md)
- Submodule `panels_ipe` (JavaScript In-Place Editor) → [../../modules/panels_ipe/4.9.x/agent/start.md](../../modules/panels_ipe/4.9.x/agent/start.md)
