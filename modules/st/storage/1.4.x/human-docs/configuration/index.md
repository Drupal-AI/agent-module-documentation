# Configuration

Storage has no global settings form. All configuration happens on **storage
types** — the bundles you create, one per kind of data you want to store. This
works almost exactly like creating and configuring content types.

## Create a storage type

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Structure → Storage types** (`/admin/structure/storage_types`) and
   click **Add storage type** (`/admin/structure/storage_types/add`).
3. Fill in the fields below and **Save**.

## Storage-type settings, field by field

- **Label** — the human-readable name shown on the add page and in menus (e.g.
  "API Log").
- **Description** — shown on the `/storage/add` page to help editors pick the
  right type.
- **Help text** — guidance displayed at the top of the create/edit form for this
  type.
- **Form label for name field** — lets you rename the built-in **name** field's
  label on the form (this is stored on the field, not the storage type).
- **Name pattern** — a token pattern used to auto-generate each item's name on
  every save, for example `[storage:string-representation]`. When you set this,
  you can hide the name widget in *Manage form display* and let the pattern fill
  it in. (The token-browser link appears only if the Token module is installed;
  the pattern works either way.)
- **Published by default** — whether new items of this type are published as soon
  as they're created.
- **Create new revision by default** — whether saving an item creates a new
  revision automatically.
- **Show the "Create new revision" checkbox** — expose that checkbox on the edit
  form so editors can decide per save.
- **Show a revision log message field** — give editors a place to describe what
  changed (only available when the revision checkbox is exposed).
- **Provide a canonical (view) URL** — off by default. When off, visiting
  `/storage/{id}` just redirects to the edit form, keeping storage items out of
  the public front end. Turn it on only if you actually want these items to have
  their own viewable page.

## Add fields

Once the storage type exists, add fields with the normal Field UI at
*Structure → Storage types → {your type} → Manage fields*
(`/admin/structure/storage_types/{id}/fields`). Everything you know from content
types applies: field types, widgets on *Manage form display*, and formatters on
*Manage display*.

## Create and manage items

- Create items at `/storage/add` (pick the storage type).
- Manage them all from **Content → Storage** (`/admin/content/storage`), which is
  a provided view with status/revision filters and a bulk-operations form. The
  shipped actions let you bulk **publish**, **unpublish**, **save**, or
  **delete** storage items.

## Permissions

Access is controlled at **bundle granularity** — the module generates a full set
of per-type permissions (add / edit own / edit any / view published / view
unpublished / delete own / delete any, plus revision operations) for *each*
storage type, alongside global admin permissions like **Administer storage
entities** and **Access storage overview**. Grant each role only the per-type
permissions it needs on *People → Permissions*. Note that revision operations
also require the matching view/edit/delete permission on the item itself, and
that viewing an item at its URL is only possible when the storage type has its
canonical URL turned on.
