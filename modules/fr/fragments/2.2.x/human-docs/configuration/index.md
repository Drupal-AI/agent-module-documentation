# Configuration

Configuring Fragments means defining your **fragment types** (bundles), giving them
fields, and setting up who can do what with them. It mirrors how you'd set up a
content type, but for routeless, reusable content.

## Create a fragment type

1. Log in as a user with the **Administer fragment types** permission.
2. Go to **Structure → Fragment types** (`/admin/structure/fragment_type`).
3. Click **Add fragment type**, give it a clear administrative **name** (for example
   *Tip*, *Call to action*, or *Location*), and save.

Each fragment type is a bundle, so you can have several — one per kind of reusable
content you want to model.

## Add fields

With a fragment type created, add the fields it needs — a body, an image, a link, a
display title, and so on — from the fragment type's **Manage fields** tab, exactly as
you would for a content type. Because fragments are **fieldable and revisionable**,
each edit can be tracked as a revision.

> **Tip:** Editors need *some* label to identify a fragment in the admin interface,
> but you often don't want that internal label shown to visitors. A common pattern is
> to add a separate **Display Title** field for the front end and let the
> **Automatic Entity Label** module fill the administrative label automatically — so
> editors usually type only the display title.

## Manage display

On the fragment type's **Manage display** tab, arrange how its fields render. This is
what determines the markup produced wherever a fragment is referenced and shown.

## Permissions

Fragments provides its own permissions, and the sensitive ones are flagged as
**restricted access** — grant them only to trusted roles at **People → Permissions**
(`/admin/people/permissions`):

- **Administer fragment types** (`administer fragment types`) — create and configure
  fragment types and their fields. This is a site‑builder / administrator permission
  and is marked restricted.
- **Access fragments overview** (`access fragments overview`) — reach the
  administrative listing of fragments. Also marked restricted.

Alongside these, grant the appropriate create/edit/delete permissions to the
editorial roles that will author fragment content.

## Settle the access question

Because a fragment has **no route of its own**, it never has its own page — but it
still renders inside whatever references it. Before going live, decide deliberately
what should happen when an **unpublished** fragment is referenced from a
**published** entity (should it show or not?), and confirm that any **JSON:API** or
**search** consumers you run treat fragment visibility the way you expect. This isn't
a single checkbox; it's a decision to make consciously as part of your content model.

## A word on reuse

Editing a fragment updates it **everywhere** it appears — that's exactly why the
module exists, and also its main foot‑gun. Before you change a widely‑used fragment,
make sure editors can see what references it (Views Bulk Operations' listing helps
here) so a well‑meaning tweak doesn't quietly rewrite a dozen pages.
