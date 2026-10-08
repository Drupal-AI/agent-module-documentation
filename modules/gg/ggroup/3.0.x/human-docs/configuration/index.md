# Configuration

Subgroup has no global settings page. You turn it on **per parent group type** by
installing a subgroup relation plugin, then editors create or relate child groups
from the group's own pages.

## Enable subgroups on a group type

1. Go to **Administration → Groups → Group types** (`/admin/group/types`) and pick
   the **parent** group type — the one that should be able to *contain* other
   groups.
2. Open its **Set available content** / **Manage plugins** screen
   (`.../content`).
3. Install the plugin named **Subgroup (&lt;child type&gt;)**. There is one such
   plugin for every group type on your site, so choose the one matching the child
   type you want to allow. To allow several different child types under the same
   parent, install several of these plugins.
4. Two settings are worth knowing:
   - **Cardinality** is fixed to **1** and greyed out — a group can be related to a
     given parent only once. Don't try to change it.
   - **Creator wizard** (off by default) — when on, creating a subgroup shows the
     group form first and then a second form to complete the creator's membership.
     Turn it on only if your membership has required fields to fill in; otherwise
     leave it off for a simpler one-step create.

## Creating and relating subgroups

Once the plugin is installed, each group of that parent type gains subgroup
operations. From a group's page you can:

- **Relate an existing group** as a subgroup — `/group/{group}/subgroup/add`.
- **Create a new subgroup** — `/group/{group}/subgroup/create` (pick a type),
  which runs the creation wizard at
  `/group/{group}/subgroup/create/{group_type}`.

These also show up as **Create &lt;type&gt;** operation links on group pages. If
the creator wizard is on, the half-built group is held safely between the two steps
until you finish.

## Circular-reference protection

You don't need to configure this — it's automatic. Subgroup refuses to relate a
group whose child is already an ancestor of the parent, so you can't accidentally
create a loop (A → B → A). The block is enforced both when validating the
relationship and at the storage layer.

## List content across subgroup levels (Views)

Subgroup adds a Views argument, **"Has parent group ID (with depth)"**
(`group_id_depth`), on group-content data. Its **depth** option (a set of
checkboxes) chooses how many levels to include:

- `-1` — the target group's own content only.
- `0`, `1`, `2` — one, two, or three subgroup levels deep.

Use it to build, say, a view that rolls up all content from a group *and* its
subgroups a chosen number of levels down.

## Tokens

For a group, Subgroup exposes two tokens you can use in emails and text:

- `[group:group]` — the label of the group's (immediate) parent group.
- `[group:groups]` (and chained `[group:groups:*]`) — all of the group's parent
  groups.

## Permissions

- **Access subgroup overview** (`access ggroup overview`) — a module permission
  granted per role in the normal Drupal permissions UI; lets a user browse the
  overview of all subgroups regardless of type.
- **Create … relationship** / **Create … entity** — these are **group**
  permissions, granted per group *role* inside the Group UI. They gate,
  respectively, relating an existing group versus creating a brand-new one under a
  parent. Assign them to the group roles that should be allowed to build the
  hierarchy.
