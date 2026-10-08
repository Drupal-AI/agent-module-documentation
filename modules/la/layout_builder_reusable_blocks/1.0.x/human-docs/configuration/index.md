# Configuration

Layout Builder Reusable Blocks provides a settings form that controls how the
module's reusable‑block integration behaves. The in‑place create/edit features work
once the module is enabled; this form is where a site administrator tunes the
integration.

## Grant the permission first

The module adds one permission, **Administer layout builder reusable blocks**. It is
marked *restrict access* and governs the module's **settings** — not the everyday
editing of blocks, which continues to follow normal block content access. Because a
misconfiguration here affects how shared blocks are created and edited across the
site, grant this permission only to trusted administrator roles.

To set it, go to **People → Permissions** (`/admin/people/permissions`), find
**Administer layout builder reusable blocks**, tick it for the appropriate roles,
and save.

## Open the settings form

1. Log in as a user who holds the permission above.
2. Go to **Configuration → User interface → Layout Builder Reusable Blocks**, or
   navigate directly to `/admin/config/user-interface/layout-builder-reusable-blocks`.

Use this form to configure how the reusable‑block behaviour is applied on your site,
then click **Save configuration**.

## A note on shared edits

Remember the key behaviour this module enables: editing a reusable block from one
page changes it **everywhere that block is placed**. Before rolling this out to a
wide group of editors, pair it with a clear visual distinction between inline and
reusable blocks, and restrict who may edit shared blocks, so an edit meant for one
page does not silently change many.
