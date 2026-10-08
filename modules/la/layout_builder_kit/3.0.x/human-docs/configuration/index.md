# Configuration

Layout Builder Kit's components are used inside the Layout Builder interface and
need no per‑component setup to appear. The module does, however, provide a
**settings form** and a **permission** that control who can use its components.

## The access permission

The module defines the permission **`access layout builder kit components`**, which
is marked as *restricted* (it is a permission Drupal flags as security‑sensitive).
It governs access to the components and the settings form. Grant it only to the
roles that should build pages with the kit, at **People → Permissions**
(`/admin/people/permissions`).

## The settings form

The settings form lives at **Configuration → Content authoring → Layout Builder
Kit settings** (`/admin/config/content/layout_builder_kit/settings`). Open it as a
user who holds the permission above to review and adjust the module‑wide options
for the kit's components.

Make any changes you need and click **Save configuration**. Because the components
render into your pages, it is worth previewing a page that uses them after changing
settings, to confirm the result matches your intent.
