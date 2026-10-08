<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Form Filter Fields lets you configure dependencies between two fields on node/media add-edit forms so the options shown in a target field are filtered by the selection made in a controlling field.

---

An admin defines dependencies at /admin/config/content/form_filter_fields (perm 'administer site configuration'), choosing a data type (content/media), a bundle, a control field, and a target field; a delete route removes a dependency. The module implements hook_form_alter() (and inline-entity-form alter) to detect matching node_* and media_* forms and rewires the target field's allowed options based on the control field's current value. Configuration is stored in form_filter_fields.settings. It is a form-UX helper for chained/cascading selects (e.g. Country -> State). Because the filtering is applied to the form's option set, treat it as an editorial convenience rather than a security boundary — server-side validation of submitted values should not be assumed from this module alone.

---

- Filter a State select by the chosen Country on a node form.
- Show only Models that belong to the selected Manufacturer.
- Cascade Category -> Subcategory selects on content forms.
- Limit taxonomy options based on another field's value.
- Build dependent dropdowns without custom JavaScript.
- Reduce editor error by hiding irrelevant options.
- Chain Region -> City selection on an event form.
- Filter product-attribute selects on a commerce content type.
- Apply dependencies to media add/edit forms.
- Configure field dependencies through an admin UI, not code.
- Filter options inside inline entity forms.
- Speed up data entry on forms with large option lists.
- Keep controlling and dependent fields consistent for authors.
- Manage multiple dependencies per content type.
- Remove a dependency quickly via the delete route.
- Guide editors through conditional field selection.
