<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Partial Datelist lets administrators hide individual dropdowns (year, month, day, hour, minute, second) in Drupal's "Select list" datelist widget, so a date or datetime field collects only the parts that matter.

---

Install with `composer require drupal/partial_datelist` and enable it (`drush en partial_datelist`); it depends on core's **Datetime** module, and range support needs **Datetime Range**. There is no settings page — configuration is per field. On a content type's **Manage form display** (`/admin/structure/types/manage/[type]/form-display`), set a Datetime or Datetime Range field's widget to **Select list** (`datetime_datelist` / `daterange_datelist`), open its settings gear, and use the **Date list visibility settings** checkboxes to hide any of Year/Month/Day (and Hour/Minute/Second for *Date and time* fields). A **Date only** field offers Year/Month/Day; a **Date and time** field offers all six. The hidden dropdowns disappear from the node add/edit form for that field. One caveat: hiding a dropdown does not drop that component from the stored value — it stops asking for it, so the component takes a default (hiding **seconds** stores `0`); confirm each hidden part's default suits your data. The `datetime_timestamp` and calendar/HTML5 widgets are not affected. When upgrading from 1.0.x, run `drush updatedb` (or `update.php`) right after deploying so the attribute-based hooks and the settings-normalizing post-update apply.

---

- Collect a year only on a date field.
- Collect year and month only.
- Hide the seconds dropdown on a datetime field.
- Hide minute and second for coarse times.
- Hide the day for month/year-only entry.
- Simplify a historical-record date field.
- Reduce clutter on a datetime entry form.
- Configure hiding per field widget.
- Apply to a Datetime Range field's start and end.
- Keep the Select list widget but show fewer parts.
- Switch a field's widget to Select list first.
- Read the current hidden parts from the widget summary.
- Set hidden parts in code on an entity_form_display.
- Confirm hidden-part defaults before going live.
- Test the node add form after configuring.
- Test the node edit form for the same field.
- Restrict to admins who manage form display.
- Run database updates when upgrading to 1.1.x.
- Leave time parts visible on a Date-only field (not offered).
- Pair with Datetime Range for date-span fields.
- Verify the widget still validates after hiding parts.
- Roll back by unchecking the hidden parts.
