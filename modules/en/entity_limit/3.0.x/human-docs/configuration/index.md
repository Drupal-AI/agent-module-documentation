# Configuration

All configuration happens under **Structure → Entity Limit**
(`/admin/structure/entity_limit`), which requires the **Administer entity limit**
permission.

## Permissions

The module defines two permissions:

- **Administer entity limit** — grants access to the whole Entity Limit admin
  section (adding, editing, deleting, and managing limits). This is the one to grant.
- **Manage entity limits** — defined for completeness but not actually used by any
  route in this version, so granting it has no effect on its own.

## Creating a limit

Click **Add** on the Entity Limit list. The add form asks for:

- **Label** — a human‑readable name for the limit (e.g. "Article cap for editors").
- **Entity type** — the content entity type this limit applies to (Content/node,
  Media, Custom block, Comment, Taxonomy term, and so on).
- **Bundles** — one or more bundles of that entity type. The limit counts and caps
  across the chosen bundles together.
- **Limit rule** — the plugin that decides each person's cap: **Role Limit** or
  **User Limit** (described below).
- **Weight** — used to decide precedence when several limits overlap (see
  "How overlapping limits are resolved").

Save the form, then open **Manage Limits** for the limit to fill in the actual
numbers.

## The two limit rules

### Role Limit

Maps each **role** to a maximum count. On the Manage Limits screen you add rows of
*role → number*. If a user has several roles that each carry a limit, the module
uses the **highest** of them. Any matching role set to `-1` means unlimited for that
user. The administrator role is not selectable.

### User Limit

Maps a specific **user** (chosen by autocomplete) to a maximum count. Use it to give
one person a different allowance from their role. Anonymous and admin‑role users are
excluded.

In both rules, `-1` means unlimited.

## Managing the numbers

Open **Manage Limits** for a saved limit to add the "who → how many" rows. Each row
is a role (or user) plus a number. Use the Add/Remove buttons to build the table,
then save.

## How overlapping limits are resolved

When a user tries to create content, the module gathers every limit that matches the
entity type and bundle, then decides which one applies:

1. Limits are grouped first by **weight** (the value you set on each limit), then by
   the **rule's built‑in priority** (User Limit is considered before Role Limit when
   weights tie).
2. Within the winning group, if any applicable limit is **unlimited** (`-1`), the
   user is allowed.
3. Otherwise the module takes the **highest** cap in that group and compares it to
   how many matching entities the user already owns. If they are at or over the cap,
   the "add" form is blocked; otherwise they may create.

Because the check counts only entities **owned by the current user**, each person is
measured against their own content. And because enforcement uses Drupal's
entity‑create access system, reaching a cap cleanly disables the add form and route
for that user — administrators are always exempt.

## Example

A limit that caps editors at 10 articles and contributors at 3 would be a **Role
Limit** on the Content/node type, restricted to the *Article* bundle, with two rows:
`editor → 10` and `contributor → 3`. Add a separate **User Limit** on the same type
giving one trusted user `-1` (unlimited), and a higher weight, to let that person
exceed their role's cap.
