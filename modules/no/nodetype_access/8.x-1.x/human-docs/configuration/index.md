# Configuration

Nodetype Access has no settings form. You configure it entirely through Drupal's
standard permissions page by deciding which roles may view which content types.

## Open the permissions page

1. Log in as a user with the **Administer permissions** permission (an
   administrator by default).
2. Go to **People → Permissions** (`/admin/people/permissions`).

## Grant the per‑type view permissions

For every content type on your site, the module adds a permission named
**view *[type]* nodes** (for example, *view Article nodes*, *view Internal memo
nodes*). Each is a column of checkboxes, one per role.

- **Tick** the box for a role that *should* be able to view nodes of that type.
- **Leave it unticked** for a role that should *not* — those users will be denied
  the full node view for that type.

Work type by type and role by role until the grid matches your intent, then click
**Save permissions** at the bottom of the page.

## How the restriction behaves

When a user tries to view a node whose content type they are not permitted to see,
the module returns an authoritative *forbid* result, so access is denied. This
happens at Drupal's **entity‑access** level: it governs the full node view and is
honoured by access‑aware listings and Views — provided access checking is left
switched on there.

It is **not** the node‑grants (query‑level) system. That distinction matters: any
context that deliberately bypasses entity access — a custom database query, a View
with *access checking* turned off, or certain search configurations — could still
surface a restricted‑type node. Keep access checking on in your Views, and be
mindful of custom queries.

## Test both directions

After saving, always verify the outcome with two accounts (or by switching roles):

- **Can‑see:** a user *with* the permission should open a node of that type
  normally.
- **Can't‑see:** a user *without* it should be denied — and the node should not
  appear in their listings or search results.

Testing both cases is the only reliable way to confirm the access rules match what
you intended.
