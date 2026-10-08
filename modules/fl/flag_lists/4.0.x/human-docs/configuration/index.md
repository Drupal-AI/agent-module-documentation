# Configuration

Setting up Flag Lists is a matter of choosing which flag acts as a **template**
for user‑created lists, tuning the module's settings, and granting the right
permissions so people can create and view their own lists.

## 1. Designate a list template

The heart of Flag Lists is the idea of a **template**: a flag type that users can
turn into their own named lists.

1. Make sure the flag you want to use as a template exists in the Flag module
   (**Structure → Flags**, `/admin/structure/flags`).
2. Go to **Structure → Flag Lists**
   (`/admin/structure/flag_lists/flag_for_list`) and designate the flag(s) that
   should act as templates for user‑created lists.

Once a flag is a template, each user can create as many lists from it as they
like and flag content into any of them.

## 2. Review the settings

The module's settings live at **Configuration → Flag Lists**
(`/admin/config/flag_lists`). Open this page to review the module‑wide options for
how lists behave, then save any changes.

## 3. Grant the permissions

Flag Lists ships a full permission set because its lists (flagging collections)
are real, revisioned entities. At **People → Permissions**
(`/admin/people/permissions`), grant the permissions that match each role's needs.
They cover, broadly:

- **Creating lists** — who may create their own named lists.
- **Viewing your own lists** versus **viewing all lists** — kept as separate
  permissions so you can let users see their own collections without exposing
  everyone else's.
- **Editing** lists.
- **Revision operations** on the flagging collections — viewing, reverting, and
  deleting revisions.

Grant the broad "view all" and revision permissions only to trusted roles; give
ordinary members just the create/view‑own/edit permissions they need.

## 4. Display the lists

Because the lists are entities with Views integration, you can build a View to
show a user their collections — for example a "My lists" page, or a block listing
the content in a chosen list. This is where you'd wire the lists into a shopping
cart, a wishlist page, or an email digest.

## Save

Save each form as you go (the settings form, the template designation, and the
permissions page). Then test as a non‑admin user: create a named list, flag some
content into it, and confirm it appears where you expect.
