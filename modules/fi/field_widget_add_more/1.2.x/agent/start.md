# Field Widget Add More — agent index

Adds an **"Add another item"** button (and per-row **Remove** buttons) to field widgets on fields
whose cardinality is a **fixed number > 1** — the incremental UX core otherwise gives only to
**unlimited** fields. No field type/widget of its own.

Key facts:
- **No configure route, no permissions, no services (beyond a hook class), no Drush.** Enabled
  per field on **Manage form display**.
- The "Show add more button" checkbox appears **only** for fields with cardinality a fixed
  integer > 1 (not `1`, not unlimited). Its value is the third-party setting
  **`field_widget_add_more.add_more`** (boolean) on the form-display component.
- Stored at `core.entity_form_display.<entity>.<bundle>.<mode>` →
  `content.<field>.third_party_settings.field_widget_add_more.add_more: true`
  (schema `field.widget.third_party.field_widget_add_more`).
- When on: shows only the used number of rows (min 1), AJAX-adds a row up to the cardinality cap,
  and hides the Add button at the cap.

Docs:
- **Enable it / where the setting lives / drush** → [configure/enable.md](configure/enable.md)
- **Hook mechanism (settings form + complete-form alter)** → [api/mechanism.md](api/mechanism.md)
