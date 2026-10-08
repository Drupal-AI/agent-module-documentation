# Display Suite submodules

Shipped under `ds/modules/`. All depend on `ds`.

## ds_extras — "Display Suite Extras"
Optional, less-common display features. Config UI at `ds.admin_settings`
(`/admin/structure/ds/settings`). Provides:
- **Block regions** — regions on a display that are exposed as placeable blocks.
- **Extra fields** — surface "extra fields" defined by other modules.
- **Field view permissions** — per-DS-field view access (dynamic permissions via `ExtrasPermissions`).
- **Hidden region** — a region whose fields are computed but not printed.
- **Switch view mode field** — inline view-mode switching field.

## ds_switch_view_mode — "Display Suite Switch View Mode"
Adds a control on the node form so an editor can choose which entity view mode a specific node
renders with. Dynamic permissions in `src/Permissions.php` gate switching per bundle.

## ds_devel — "Display Suite Devel"
Development helper; depends on `devel`. Adds inspection/debug tooling for DS displays and
fields (routes/tasks under the display admin). Enable only in development.
