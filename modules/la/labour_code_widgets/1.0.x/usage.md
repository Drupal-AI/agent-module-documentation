<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Labour code widgets integrates the official French government "code du travail" widgets (from code.travail.gouv.fr) into Drupal as a field.

---

The module defines a custom field type (`LabourCodeWidgetsItem`) and a field formatter (`LabourCodeWidgetsFieldFormatter`) so editors can add a "Labour code widgets field" to any fieldable entity, pick a widget, set cardinality, and have the chosen government widget render on the entity's page. The external widget script (`https://code.travail.gouv.fr/widget.js`, declared as an external library and loaded `async`/`defer`) powers the embedded widgets client-side. A settings form at `/admin/structure/labour-code-widgets/status` (permission `administer labour_code_widgets`) lets administrators enable or disable individual widgets; `LabourCodeWidgetsHelper` (`labour_code_widgets.helper`, injected with `config.factory`) exposes the widget definitions and options and reflects that on/off state.

The admin route is permission-gated and the module makes no server-side external calls (the widget script runs in the visitor's browser). The main operational consideration is the third-party script from an external domain that is loaded on pages displaying the field — a privacy/CSP consideration typical of any embedded government widget. All widgets are enabled by default.

---
- Add a "Labour code widgets field" to a content type.
- Embed a French labour-code calculator on a page.
- Choose which government widget a field instance displays.
- Set field cardinality for multiple widgets on one entity.
- Enable or disable specific widgets site-wide.
- Restrict widget administration to a trusted role.
- Render the selected widget via the field formatter.
- List available widgets and their machine ids from config.
- Provide HR/legal pages with official labour-code tools.
- Localise labour-code information for a French-facing site.
- Toggle off widgets you don't want editors to use.
- Reuse `labour_code_widgets.helper` to read widget definitions in code.
- Add the widget field to a paragraph or custom entity.
- Control which pages load the external widget script (via field placement).
- Keep embedded tools in sync with the official gouv.fr source.
- Configure default vs. per-instance widget selection.
- Audit the external script domain for your CSP policy.
