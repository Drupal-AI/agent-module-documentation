# Configuration

Disable Field is configured **per field**, not from a central settings page.
Each field's settings are stored on that field, so you can lock different fields
in different ways and ship the choices through exported configuration.

## Open the settings for a field

1. Make sure your account has the **Administer disable field settings**
   permission (see below) — the settings section is hidden otherwise.
2. For a normal field: go to **Structure → Content types → (type) → Manage
   fields**, then **Edit** the field. (Note this is the field's **Edit** form,
   not *Manage form display*.)
3. For a base field such as **Title**: enable the base-field-override UI and edit
   the override at
   `/admin/structure/types/manage/<type>/fields/base-field-override`.
4. Open the **Disable Field Settings** section.

## The four modes

You set a mode **separately for the add form and the edit form**, using the two
questions *"Disable this field on add content form?"* and *"…on edit content
form?"*. "Add" means the entity is being created (it has no ID yet); "edit"
means it already exists. For each, choose one of:

- **Enable for all users** *(default)* — the field behaves normally.
- **Disable for all users** — the field is greyed out for everyone on that form.
- **Disable for certain roles** — pick one or more roles; the field is disabled
  for anyone who has one of them, and editable for everyone else.
- **Enable for certain roles** — pick one or more roles; the field is editable
  *only* for those roles and disabled for everyone else.

For the two role-based modes, a **role multiselect** appears so you can choose
which roles the rule applies to.

Because add and edit are independent, common patterns are easy — for instance
leave a field **enabled on add** but **disabled on edit** so authors can set a
value once at creation and it is then frozen.

## Save and verify

Click **Save**. Open an add or edit form for that content type: the field should
appear greyed out according to the mode you chose. Remember the value is
preserved when the input is disabled, so nothing is lost on save.

## The permission

The module defines one permission:

- **Administer disable field settings** (`administer disable field settings`) —
  controls **who can see and change** the Disable Field Settings section on field
  forms. It is marked security-sensitive; grant it only to trusted administrator
  roles at **People → Permissions**.

Note this permission only governs *configuring* the feature. It does **not**
decide whether a given field ends up disabled for an editor — that is driven
purely by the mode you saved and the editing user's roles.

## Important: this is a soft lock

Disable Field sets the widget to disabled in the browser. It is a usability
control, not a security-grade access check: it stops casual edits through the
form and preserves the stored value, but it should not be relied on to protect
sensitive data. For enforced field-level access, use a module such as Field
Permissions.
