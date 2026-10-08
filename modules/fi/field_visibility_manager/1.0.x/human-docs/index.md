# Field Visibility Manager — manual setup guide

**Field Visibility Manager** (`field_visibility_manager`) is a lightweight tool for
controlling which node fields appear on the content **add/edit form** for which
roles. From a single settings table you tick the roles that should have a given
field hidden, and the module removes that field's widget from the form for users in
those roles.

Under the hood it works by setting the form element's `#access` to `FALSE`. That is
a genuine, server-side restriction — Drupal's Form API drops the element from
processing entirely, so a blocked role cannot see the field *and* cannot inject a
value for it by tampering with the submission. It is not merely CSS hiding.

There is one important limit to understand before you rely on it: this module
controls the **edit form only**. It does **not** restrict *viewing* or *display* of
the field value. The rendered node, Views, and REST/JSON:API will still expose the
value to anyone who can read the entity. Use it to keep editors out of fields they
should not be filling in — not as read-access control. For hiding a value from
being seen, pair it with a proper field display or access module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings table where you choose
   which roles have which fields hidden.

## Where it lives in the admin menu

Once enabled, the settings form lives at
`/admin/config/field_visibility_manager/adminsettings`. It is gated by the
**Administer site configuration** permission, so administrators reach it by default.

## How to use it

The table lists every node-bundle field whose machine name starts with `field_` as
rows, and your site's roles as columns. Tick a role's box against a field to hide
that field's widget on the add/edit form for that role, then save. A user who has
multiple roles is blocked from a field if **any** of their roles is ticked for it.
The table keeps itself current: newly added fields appear automatically, and fields
you delete drop out of the saved configuration. See
[Configuration](configuration/index.md) for the step-by-step.
