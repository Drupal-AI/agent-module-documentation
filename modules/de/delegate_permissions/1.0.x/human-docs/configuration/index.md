# Configuration

Setting up Delegate Permissions is about defining the role hierarchy, granting
the delegation permission to the right people, and (optionally) blocklisting any
permissions you never want sub‑delegated.

## 1. Define the role hierarchy with role weights

On **People → Roles** (`/admin/people/roles`), set the **weight** of each role to
express the hierarchy. A heavier weight means a "higher", more permissive role. A
delegate can only manage roles weighted **below** their own highest role, so get
these weights right first — they are the backbone of the whole boundary.

## 2. Grant the delegation permission

On **People → Permissions** (`/admin/people/permissions`):

- Grant **allow delegate permissions** to the role(s) that should be able to
  manage lower roles.
- Give those roles the usual admin‑access permissions they will need to reach the
  form — typically **access administration pages**, **view the administration
  theme**, and **access toolbar**.

## 3. (Optional) Mark permissions as Not Delegable

The core permissions page gains an extra **Not Delegable** column (visible to
users who hold `administer permissions`). Tick any permission there that you never
want to appear in the delegated form. By default, `allow delegate permissions`
itself is already marked non‑delegable, so delegates cannot hand out the power to
delegate.

## Using the delegated form

Delegates go to **People → Delegate permissions**
(`/admin/people/delegate-permissions`) and see a permissions matrix limited to:

- roles weighted **below** their own highest role, and
- permissions **they personally hold**, minus anything on the Not Delegable list.

Saving the form applies their changes to those lower roles. Because only the safe
subset is ever shown, a delegate cannot grant a permission they lack or edit a
role at or above their own level.

## Important nuances

- **Bypassed providers.** A user who holds **`bypass node access`** can delegate
  *all* node‑provider permissions, and a user with **`administer taxonomy`** can
  delegate all taxonomy permissions — even individual ones they do not each hold.
  This is a bounded widening within those two providers. If you do not want, for
  example, `administer nodes` to be sub‑delegatable, add it to the **Not
  Delegable** list. (Developers can extend the provider map via
  `hook_bypassed_provider_map_alter()`.)
- **Config sync.** The Config Filter integration merges a delegate's changes with
  the permissions they could not see, so exporting and importing configuration
  does not silently drop permissions that were outside the delegate's view.
- **When you already hold `administer permissions`.** If you are a full
  administrator, use the standard core permissions form; the delegated form is
  meant for the scoped, non‑admin roles.
