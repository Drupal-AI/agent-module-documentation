<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Edit in place field adds four "Edit in place" field formatters that let an editor change a field's value directly on the rendered page and save it over AJAX, without opening the entity edit form.

---

Install it with `composer require drupal/edit_in_place_field` and enable it; there is **no central settings page**, so all setup happens on an entity's *Manage display* screen. For a supported field you pick one of the module's formatters — **Edit in place** for a `string`/`uri` field (an inline text box), for a `string_long`/`email` field (an inline textarea), or for an `entity_reference` field (an inline select list), plus **Edit in place filtered by parent** for reference fields whose targets are grouped under a parent entity. Then grant the **"Allow to use edit in place field to save entities"** permission (`edit in place field editing permission`) to the roles that should edit inline; anyone without it simply sees the field's normal, read-only display. When a permitted user views the field — in full content, a teaser, or a View — they click the value, edit it in the revealed control, and press **Save**; the change is written to the entity over AJAX and the field re-renders in place. The reference formatters build their option lists from the field's existing handler settings (target bundles, or a View), can substitute a chosen field for the entity label via `label_substitution`, and upgrade the plain `<select>` to a nicer widget when the **Select2** or **Chosen** module is installed. It works with the Claro and Gin admin themes; one known limitation is that it does not currently work inside the Views "Node operations bulk form" field.

---

- Let editors fix a typo in a title without opening the edit form.
- Correct a heading directly on the rendered page.
- Update a phone number inline in a teaser.
- Change a wrong date on full content.
- Edit a short text (`string`) field in place.
- Edit a `uri` field value inline.
- Edit a long text (`string_long`) field in an inline textarea.
- Fix an `email` field value inline.
- Reassign an entity-reference field from an inline select list.
- Change a taxonomy-term reference without the node form.
- Swap a referenced node inline in a View row.
- Edit a multi-value field with one input per value.
- Append a value to an unlimited-cardinality field inline.
- Group child references under their parent with the "filtered by parent" formatter.
- Show a custom field instead of the entity label in the select (`label_substitution`).
- Use a Select2 widget for the inline reference select.
- Use a Chosen widget for the inline reference select.
- Give only chosen roles inline-save rights via the module permission.
- Keep the field read-only for roles without the permission.
- Provide quick inline corrections inside a View listing.
- Edit fields shown in a teaser display without navigating away.
- Cover the small-correction workflow that core's removed Quick Edit used to serve.
- Reduce clicks needed for minor editorial corrections.
- Save an inline change over AJAX and see it re-render in place.
