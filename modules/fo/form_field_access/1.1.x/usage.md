<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Form Field Access restricts access to specific fields in the edit form per role.

---

Form Field Access **dynamically restricts access to specific fields in the entity EDIT form, per role** — so
you can control which roles may see/edit particular fields on the content edit form, without custom form alters.
It provides its own permissions.

Use it to control which roles can edit which fields. It is a content-editing/access feature, and it is important
to understand its scope: it governs the **edit form** (whether a role can see/edit a field when editing an
entity) — it is **not** field *view* access on display and does **not** hide the field's value on the rendered
page, JSON:API, REST or Views. So use it to control **editing**, and use **field-level view access** (e.g. Field
Permissions) if you need to restrict who can *read* a field's value elsewhere. It layers on core field access.
Configure the per-role field access on forms.

---

- Restrict edit-form fields per role.
- Control who can edit which fields.
- Avoid custom form alters.
- Provide its own permissions.
- Serve content editing.
- Gate fields on the edit form.
- GOVERN the EDIT form (edit access), not field view.
- NOT hide field values on display/JSON:API/REST/Views.
- Use field view access (Field Permissions) to restrict reading.
- Layer on core field access.
- Have no broad access role beyond that.
- Configure per-role field access on forms.
- Handle form-field access.
- Restrict fields.
- Configure the access.
- Gate edit fields.
- Handle the form.
- Hide edit fields.
- Control editing.
- Provide edit-form field access.
