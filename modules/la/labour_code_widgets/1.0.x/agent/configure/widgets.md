<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Labour code widgets

## Enable/disable widgets
Route `labour_code_widgets.status` → `/admin/structure/labour-code-widgets/status` (permission `administer labour_code_widgets`). The form (`LabourCodeWidgetsSettingsForm`) toggles each widget on/off; state is stored in `labour_code_widgets.settings`. All widgets are enabled by default.

## Add the field
1. On a content type (or any fieldable entity), add a field of type **Labour code widgets field** (`LabourCodeWidgetsItem`).
2. Set cardinality if you want multiple widgets per entity.
3. In *Manage display*, the `LabourCodeWidgetsFieldFormatter` renders the selected widget.

## Helper service
`labour_code_widgets.helper` (`LabourCodeWidgetsHelper`, ctor `@config.factory`) exposes:
- `getOptions()` — enabled widget options for form/select use.
- `getWidgetDefinition($widgetId)` / `getWidgetsDefinition()` — widget metadata.

## External script
The `widget` library loads `https://code.travail.gouv.fr/widget.js` (`external: true`, `async`, `defer`) in the visitor's browser. Add that domain to your Content-Security-Policy `script-src` if you enforce CSP.
