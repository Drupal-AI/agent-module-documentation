Webform UI provides the drag-and-drop, point-and-click administrative interface for building and maintaining webforms and their elements, without hand-editing YAML.

---

The core Webform module can store and render forms from configuration alone, but Webform UI is what site builders actually use to create them. It adds the element-management screens under `/admin/structure/webform/manage/{webform}` — a sortable table of elements where you add, edit, duplicate, delete, reorder (with nesting for containers/pages), and change the type of each element through modal dialogs. Adding an element opens a type-selection screen listing every available WebformElement plugin, and each element gets a full configuration form (properties, validation, conditional logic, access). It also exposes a **Source (YAML)** editor at `.../source` for power users who want to edit the raw element definitions, plus a source editor for reusable webform options entities. This module is effectively required for normal form-building; without it there is no editorial UI. It relies entirely on core Webform's plugins, entities, and permissions (e.g. "edit webform" / "administer webform") rather than defining its own.

---

- Build a webform by adding elements through a UI instead of YAML.
- Drag to reorder and nest elements within containers, wizards, and pages.
- Add a new element by picking from the full list of element types.
- Change an existing element's type (e.g. textfield → email) in place.
- Edit element properties, defaults, and help/description text.
- Configure per-element validation (required, patterns, min/max).
- Set conditional (states) logic to show/hide elements dynamically.
- Duplicate an element to speed up repetitive form building.
- Delete elements with a confirmation dialog.
- Add wizard pages and layout containers via dedicated add screens.
- Edit the raw form definition in the Source (YAML) editor.
- Edit reusable webform options lists in their source editor.
- Manage element access (which roles can view/edit each field).
- Test an element type from the plugin reports page.
- Configure multi-column flexbox/layout containers visually.
- Reorder wizard pages by dragging.
- Set an element's key, title, and admin title.
- Add computed, markup, and other advanced elements from the picker.
- Give non-developers a safe editorial surface for form maintenance.
- Quickly prototype a form then export its YAML for deployment.
- Change default values and placeholder text without code.
