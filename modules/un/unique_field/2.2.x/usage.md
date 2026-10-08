Unique Field adds form-submission validation that forces designated fields on nodes, taxonomy terms, and users to hold values not already used elsewhere, with a configurable scope and single-vs-combination matching.

---

The module has no dedicated settings page. Instead it injects a collapsible **"Unique Field
restrictions"** fieldset into the *content type* edit form (`node_type_*_form`), the
*taxonomy vocabulary* form, and the global *Account settings* form (`user_admin_settings`),
each visible only to users with the `unique_field_perm_admin` permission. There you pick which
fields must be unique, the **scope** (nodes: content type / language / all nodes / single node;
terms: vocabulary / language / all / single term), and whether **each** chosen field must be
unique individually or the **combination** of them must be unique. Selections are stored in the
`unique_field.settings` config object. On submit of a node/term/user form, an added `#validate`
callback builds a `SELECT` against the field's data table (parameterised, excluding the current
entity) and, if a duplicate is found, sets a form error so the entity cannot be saved. Users
holding `unique_field_perm_bypass` instead get a warning with a one-click link that sets a hidden
`unique_field_override` field and resubmits, skipping the check. AJAX (partial) submissions are
skipped. Both permissions are `restrict access: TRUE`. Note the module targets nodes, taxonomy
terms and users specifically (not arbitrary entity types), and validates only fields present in
the submitted form.

---

- Require every node of a content type to have a unique title.
- Enforce a unique value for a custom field (e.g. SKU, ISBN, slug) across a content type.
- Guarantee a field value is unique across *all* nodes regardless of type.
- Scope uniqueness to a single language so translations may reuse a value.
- Require the *combination* of several fields (street, city, zip) to be unique, not each alone.
- Ensure no two taxonomy terms in a vocabulary share the same name.
- Keep term descriptions unique within a vocabulary.
- Enforce a unique custom field on user accounts (e.g. membership number, phone).
- Prevent duplicate email-like or identifier fields on user registration.
- Allow trusted editors to override a false-positive duplicate with a one-click bypass link.
- Restrict who can configure uniqueness rules via the admin permission.
- Restrict who can bypass uniqueness errors via the bypass permission.
- Block duplicate values only within the same content type (default scope).
- Require multi-value field entries on a single node to be internally unique ("single node" scope).
- Add a data-integrity guard without writing a custom constraint plugin.
- Stop editors creating a second landing page with a duplicate marketing code.
- De-duplicate imported/user-submitted reference numbers at save time.
- Keep catalogue product codes unique across the whole site.
- Enforce unique combinations for event date + venue term pairs.
- Prevent duplicate usernames-style identifiers stored in a custom user field.
- Provide clear per-field "has to be unique" validation messages to editors.
