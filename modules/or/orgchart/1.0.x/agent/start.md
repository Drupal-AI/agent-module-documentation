<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# orgchart — agent index

Create and display organizational charts, edited via a drag-and-drop builder or a YAML editor,
rendered through a block or per-chart route. Needs `jquery_ui_draggable` and `jquery_ui_resizable`.

Quick facts:
- Admin: `/admin/config/orgchart` (route `orgchart.configuration`, perm `administer orgchart`); add/build/edit/delete forms; YAML editor at `/admin/config/orgchart/yaml/{id}/{display}` (perm `administer orgchart yaml`, restricted).
- Display: `OrgChartBlock` plugin + dynamic per-chart routes from `OrgchartRoutes::routes`; rendered by `OrgchartController::orgchartView()`.
- Permissions: `access orgchart` (view), `administer orgchart` (manage), `administer orgchart yaml` (raw YAML, restricted).
- Charts support multiple displays (e.g. `desktop`) and store definitions in config.
