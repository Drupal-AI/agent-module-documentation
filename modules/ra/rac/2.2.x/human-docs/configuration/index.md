# Configuration

RAC has no settings page of its own — you configure it through **Advanced Access
(ADVA)** and by adding a role reference field to the entities you want to protect.
There are three steps: add the field, enable Role Access in ADVA, and rebuild node
access.

## 1. Add a role reference field

On the entity type you want to control (for example a content type under **Structure
→ Content types → *(type)* → Manage fields**), add an **Entity reference** field that
references the **Role** entity type. The roles selected in this field on a given piece
of content are the roles that will be allowed to access it.

You can name the field whatever suits your site (for example "Access roles"). Add it
to any entity type that supports fields and is covered by an Advanced Access consumer.

## 2. Enable Role Access in Advanced Access

Go to **Configuration → People → Advanced Access Settings**
(`/admin/config/people/adva`) and enable **Role Access** for the entity type you just
added the field to. The entity type must have an **Advanced Access consumer** for this
to work (node support is part of the Advanced Access project; other entity types may
need an additional module — see the ADVA project page).

## 3. Rebuild node access

RAC enforces access as **node access grants**. On an existing site with content
already saved, you must rebuild the grants after enabling or changing the
configuration, or listings and search will show stale results. Rebuild with Drush:

```bash
drush php:eval 'node_access_rebuild();'
```

(New content saved after configuration is applied gets the correct grants
automatically; the rebuild is what fixes previously saved content.)

## How access is decided

Once configured, a piece of content is viewable by users who have one of the roles
selected in its role reference field. Keep two consequences of the grants system in
mind:

- **Grants are OR‑combined across modules.** If another access module grants *view*
  on the same content, that grant wins over RAC's restriction. If content that should
  be hidden is still visible, check whether a second grants provider is also active.
- Because grants apply at the query level, the restriction is honoured in **Views and
  search**, not just on the entity's own page.

## Permissions

RAC generates its permissions at runtime, so the exact set depends on your
configuration. Review **People → Permissions** after setup and grant any RAC‑related
permissions to the appropriate roles.
