<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Orgchart lets site builders create organizational charts and render them on the site. Each chart is defined either through a drag-and-drop/resize builder UI or by editing its YAML source directly, and can be shown through the "Org Chart" block or its own routed page.

---

Charts are managed under `/admin/config/orgchart` (route `orgchart.configuration`), with add/build/edit/delete/YAML forms. Chart definitions (node values, per-display width, etc.) are stored in config and rendered by `OrgchartController::orgchartView()`; a dynamic route callback (`OrgchartRoutes::routes`) registers a viewing route per chart, and an `OrgChartBlock` plugin exposes charts for Block Layout. The builder uses jQuery UI draggable/resizable (hence the `jquery_ui_draggable` and `jquery_ui_resizable` dependencies) plus a CodeMirror form element for the YAML editor. Permissions separate everyday use from configuration: `access orgchart` (view), `administer orgchart` (manage charts), and `administer orgchart yaml` (edit raw YAML, flagged `restrict access: true` because raw YAML is more powerful). Charts support multiple displays (e.g. `desktop`) so the same structure can be laid out differently per breakpoint.

---

- Publish a company org chart on an About/Team page via the Org Chart block.
- Let admins build a hierarchy visually with drag-and-drop and resize handles.
- Power users edit a chart's YAML directly for precise, bulk changes.
- Maintain several charts (departments, regions) from one admin listing.
- Render a chart on its own URL using the per-chart dynamic route.
- Provide separate desktop/mobile layouts using multiple chart displays.
- Restrict who can view charts with the `access orgchart` permission.
- Delegate chart management without giving YAML access (`administer orgchart` vs `administer orgchart yaml`).
- Guard the powerful YAML editor behind a restricted permission.
- Embed the same chart in multiple regions through the block plugin.
- Export chart config to move an org structure between environments.
- Visualise reporting lines for onboarding or intranet documentation.
- Keep chart width/appearance configurable per display.
- Update the chart quickly when the org changes, no code deploy needed.
- Show a functional/team structure diagram to visitors without a third-party SaaS.
- Version-control chart definitions as configuration.
