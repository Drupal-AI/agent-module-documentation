# Disable Field — manual setup guide

**Disable Field** (`disable_field`) lets you make an individual field appear
**disabled** (greyed out and non-editable) on an entity's add and/or edit form,
optionally only for certain user roles. It is a lightweight way to show a field's
value to editors while stopping them from changing it — for example locking a
"reference code" after content is first created, or freezing a status field once
an item is published.

You configure it per field, right on that field's own settings form. A **Disable
Field Settings** section lets you choose, *independently* for the add form and
the edit form, whether the field is enabled for everyone, disabled for everyone,
disabled for specific roles, or enabled only for specific roles. The same options
work for base fields such as **Title** through Drupal's base-field-override form.

One important caveat: this is a **soft, UX-level lock**, not a security control.
It disables the input in the browser, which means the field cannot be changed
through that form — and because a disabled input is not submitted, the existing
value is preserved. But it is not a substitute for real field access control (if
you need that, look at the Field Permissions module). The settings UI itself is
gated behind a permission so only trusted administrators can decide which fields
are locked.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the four disable modes, where to
   set them per field, and the permission that controls the UI.

## Where it lives in the admin menu

There is no central settings page. The controls appear **on each field's edit
form**: **Structure → Content types → (type) → Manage fields → (field) → Edit**,
in a **Disable Field Settings** section. For base fields such as *Title*, they
appear on the base-field-override form. Only users with the **Administer disable
field settings** permission see this section.
