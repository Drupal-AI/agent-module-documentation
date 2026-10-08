<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Filter Select lets fields that Views would normally expose as a text input be exposed as a select list instead, giving site visitors a dropdown of valid values rather than a free-text box.

---

Views' exposed filters default to a text field for many field types, which is the wrong control when the set of sensible values is small and known: a status, a category, an orientation, a type code. A text box invites typos and empty results; a select list shows exactly what is available. Getting a select there normally means a custom filter plugin or an allowed-values callback.

This module provides that as configuration. It adds the ability to expose a field as a select filter, so the exposed form renders a dropdown populated with the field's values. It is the dependency behind Media Orientation's orientation filter, and it is generally useful anywhere an exposed filter should be a choice rather than a string.

Being a Views extension, it depends on core Views and works within the exposed-filter configuration you already use — no separate UI to learn, just a different filter option. Confirm that the value set it offers is the one you expect, since a select is only better than a text box if it lists the right options.

---

- Expose a Views filter as a dropdown.
- Replace a text filter with a select.
- Offer visitors valid filter values only.
- Prevent typos in an exposed filter.
- Filter by a small set of known values.
- Turn a status field into a select filter.
- Turn a category into a dropdown filter.
- Back Media Orientation's filter.
- Avoid a custom filter plugin.
- Show available values in the exposed form.
- Improve a faceted listing UX.
- Filter a view by a code from a list.
- Configure the select within Views.
- Populate the dropdown from field values.
- Reduce empty-result searches.
- Expose an enum field cleanly.
- Combine with other exposed filters.
- Keep filtering inside Views config.
- Give an exposed filter a fixed choice set.
- Confirm the offered values are correct.