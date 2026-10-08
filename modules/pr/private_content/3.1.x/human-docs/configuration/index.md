# Configuration

Private Content has no single settings page. You set it up in two places: a
**privacy mode per content type**, and the **three permissions** that decide who
can do what. This page walks through both, plus the per-node checkbox and the
bulk actions.

## Choose a privacy mode per content type

1. Go to **Structure → Content types**
   (`/admin/structure/types`) and click **Edit** on a content type.
2. Open the **Privacy settings** group under *Additional settings* at the bottom
   of the form.
3. Pick one of the four modes:

   - **Disabled (always public)** — the Private option is turned off for this
     type; nodes are always public and the checkbox is hidden/locked.
   - **Enabled (public by default)** — editors *may* tick Private, but new nodes
     start public. This is the standard, everyday choice, and it's what a content
     type gets if you never touch the setting.
   - **Enabled (private by default)** — editors may tick Private, and new nodes
     start *private*. Good for a type whose content should usually be hidden but
     can be published publicly when needed.
   - **Hidden (always private)** — every node of this type is private and the
     checkbox is locked on. Use this for something like an "Internal memo" type
     that should never be public.

4. **Save** the content type.

> **Changing a privacy mode requires a node access rebuild** so the new rule
> applies to existing nodes. Drupal flags this for you; run it with
> `drush php:eval 'node_access_rebuild();'` (see
> [Installation](../installation/index.md)).

## Grant the permissions

Go to **People → Permissions** (`/admin/people/permissions`) and assign the three
Private Content permissions to the appropriate roles:

- **Mark content as private** — lets a user *tick the Private checkbox* on a node
  form. On its own it does not grant anyone the ability to view others' private
  content; it just controls who can set the flag.
- **Edit private content** — lets a user *update or delete* a private node they
  don't own. Give this to trusted editors who moderate other people's private
  posts.
- **Access private content** — lets a user *view any* private node. This is the
  security-sensitive one — grant it to a "members only" or staff role that should
  be able to read all private content.

Two things to keep in mind:

- A node's **author always** keeps view and edit access to their own private
  nodes, no matter what these permissions say.
- These permissions only ever *remove* the restrictions Private Content imposes —
  they never override your site's other access rules.

## Mark a node private

With a content type set to one of the "Enabled" modes, edit or create a node and
tick the **Private** checkbox, which appears in the node form's options area next
to *Published* and *Promoted*. Only users with **Mark content as private** can
change it. When the content type is Disabled or Always-private, the checkbox is
locked and reflects the type's fixed policy.

## Bulk actions

From the content administration listing (**Content**,
`/admin/content`), select several nodes and use the bulk-operations dropdown:

- **Make selected content private** — flags the chosen nodes private.
- **Make selected content public** — reverts them to public.

## Showing a Private/Public indicator (optional)

The `private` field is display-configurable. If you want a visible "Private /
Public" indicator on the rendered node, add the private field's formatter to the
content type's **Manage display** settings.
