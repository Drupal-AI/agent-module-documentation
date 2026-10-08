# Configuration

Collection does not have a single settings form; you configure it the way you
configure Drupal's own content model — by defining **collection types**, then
setting **permissions**. This page walks through both.

## 1. Create a collection type

Collection types are to collections what content types are to nodes.

1. Log in as a user with the **Administer collections** permission.
2. Go to **Structure → Collection types** and add a new type (for example
   *Blog*, *Sub-site*, or *Periodical*).
3. Because collection entities are fieldable, you can add fields to the type
   (via its **Manage fields** screen) just like a content type — a description, an
   image, and so on.

You will also have **Collection item types**, which define the join objects that
link content or configuration entities into a collection. Set these up to match the
kinds of things you want to place in your collections.

## 2. Create collections

Once a type exists, create collections under **Content**. For each collection you
can:

- assign an **owner**;
- add **items** (content entities such as nodes, or configuration entities such as
  menus) as members;
- place a single item in **multiple collections**, choosing one as the canonical
  (primary) collection; and
- **order** the items within the collection.

## 3. Set permissions

Collection's permissions are granular. On **People → Permissions**
(`/admin/people/permissions`) you will find:

- **Administer collections** — full control over collections and their types.
- **Administer users in collections** — manage which users belong where.
- **Access collection overview** — see the collections listing.
- **View own / edit own / delete own collections** — owner-scoped access for
  regular users.

The two `administer` permissions are **powerful** — they let a user reshape
collections and their membership site-wide — so grant them only to trusted roles.
For ordinary contributors, prefer the owner-scoped `view/edit/delete own`
permissions.

## 4. Optional: listings and path aliases

- If you enabled **Collection Listing** (with Paragraphs), you can add a listing of
  a collection's items as a Paragraph on another entity — configure it on that
  entity's fields/display.
- If you enabled **Collection Pathauto** (with Pathauto), a collection's URL alias
  is automatically prepended to the aliases of the content it contains, giving
  sub-site-style URLs. Configure the alias patterns under Pathauto as usual.
