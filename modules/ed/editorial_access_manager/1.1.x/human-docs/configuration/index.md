# Configuration

Getting Editorial access manager working is a four-part setup: turn the feature on
for the entity types you want, turn it on for the specific bundles, grant the
permission to *assign* editors, and grant the permission to *edit assigned*
content. After that, the assignment happens per item.

## Step 1 — enable the supported entity types

1. Log in as an administrator.
2. Go to **Configuration → Content authoring → Editorial access manager**
   (`/admin/config/content/editorial-access-manager`).
3. Enable the content entity types you want the feature to support (for example
   nodes, taxonomy terms).
4. Save.

## Step 2 — enable the bundles

For each supported entity type, enable the specific bundles that will use the
feature. You do this on the bundle's own edit form — for example, on a **content
type**'s edit page (*Structure → Content types → (type) → Edit*). Only bundles you
turn on here get the assignment tab.

## Step 3 — assign the "who can assign" permissions

At **People → Permissions**, grant the roles that should be allowed to *assign*
editors one (or both) of:

- **Assign entity edition** — allows assigning editors on any supported entity
  type, and/or
- **Assign entity translation** — allows assigning translators.

You can also grant the narrower, per-type variants such as **Assign node edition**
or **Assign node translation** if you want to limit assigners to a single entity
type.

Users with these permissions get a **Manage editorial access** tab on each
supported content item, where they choose which users may edit it — and, per
language, who may translate it.

## Step 4 — assign the "who can edit assigned content" permissions

Grant the roles whose users will *receive* assignments the corresponding
permission (again, generally or per type — for example **Assign node edition**).

Two things to note here:

- Users who will edit or create assigned content **do not need** any of core's
  normal content create/edit/translate permissions. The assignment is what grants
  their access.
- These users get a **Content → Assigned Content** page listing exactly what has
  been assigned to them, with the ability to edit it and to create or edit its
  translations.

## Reassigning content when someone leaves

There is a dedicated handover tool at **Content → Reassign**
(`/admin/content/reassign`). Select the old assignee and the new assignee, and all
of the old user's assignments transfer to the new one. Only users with the
**Reassign assigned entities** permission can use this form.

## Verify the access actually applies

This is an access-control module, so confirm the result in more than one place.
Check that an assigned user can reach and edit exactly the items assigned to them —
and, just as importantly, check that per-item access holds in **Views listings,
JSON:API, and search**, not only on the entity edit form. Per-item access most
often leaks at the query level, so test those surfaces before you rely on it.
