<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Chosen Order — agent start

UI enhancement for the contrib Chosen widget. Depends on `chosen`, `chosen_field`, `jquery_ui_sortable`.

- No routes/permissions/config. Activates via `hook_field_widget_form_alter` on multiple `#chosen` widgets.
- Adds a hidden `<field>_order` element; JS (`js/chosen_order.js`) makes `.chosen-choices` sortable and stores comma-separated value order.
- Validate handler `chosen_order_form_chosen_field_validate_order` reorders submitted values to match the drag order.
- Key files: `chosen_order.module`, `js/chosen_order.js`.
- See ../usage.md for details.
