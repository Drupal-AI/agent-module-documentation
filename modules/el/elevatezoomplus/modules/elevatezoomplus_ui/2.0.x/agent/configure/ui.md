<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — the optionset admin UI

All routes require permission `administer elevatezoomplus` (`restrict access: true`,
`modules/ui/elevatezoomplus_ui.permissions.yml`). `configure` = `entity.elevatezoomplus.collection`.

| Route | Path | Purpose |
|---|---|---|
| `entity.elevatezoomplus.collection` | `/admin/config/media/elevatezoomplus` | List optionsets (`ElevateZoomPlusListBuilder`). |
| `elevatezoomplus.optionset_page_add` | `/admin/config/media/elevatezoomplus/add` | Add (`ElevateZoomPlusForm`). |
| `entity.elevatezoomplus.edit_form` | `/admin/config/media/elevatezoomplus/{elevatezoomplus}` | Edit. |
| `entity.elevatezoomplus.duplicate_form` | `.../{elevatezoomplus}/duplicate` | Duplicate. |
| `entity.elevatezoomplus.delete_form` | `.../{elevatezoomplus}/delete` | Delete (`ElevateZoomPlusDeleteForm`). |

The forms read/write the parent's `elevatezoomplus.optionset.<id>` config entity — see the parent's
[configure/optionsets.md](../../../../../2.0.x/agent/configure/optionsets.md) for every
`options.settings` key. This submodule adds no config or schema itself.
