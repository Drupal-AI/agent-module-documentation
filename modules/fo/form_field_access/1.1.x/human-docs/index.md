# Form Field Access — manual setup guide

**Form Field Access** (`form_field_access`) lets you **deny access to specific
fields on an entity's edit form, per role**, from a simple admin matrix. Pick an
entity type and bundle, then use a field‑by‑role grid to decide which roles are
*not* allowed to see or edit each field on the form. A user in a disallowed role
simply won't have that field available when they add or edit the entity.

It was built to complement the well‑known
[Field Permissions](https://www.drupal.org/project/field_permissions) module,
which does not cover fields created dynamically. Form Field Access can restrict
those dynamic fields, and the two modules can be used together.

There is one important scope limit to understand before you rely on it. Form
Field Access governs the **edit form only** — whether a role can see and edit a
field while editing an entity. It is **not** field *view* access: it does not
hide a field's value on the rendered page, in JSON:API, in REST, or in Views. If
you need to control who can *read* a field's value elsewhere, use field‑level view
access such as Field Permissions. Form Field Access layers on top of core's field
access and provides its own permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the field/role access matrix, and
   exactly what it does and does not restrict.

## Where it lives in the admin menu

The configuration page is under **People**, at
**`/admin/people/form-field-access`**. That is where you pick the entity type and
bundle and set the per‑role field access.
