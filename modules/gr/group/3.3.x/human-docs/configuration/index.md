# Configuration

Setting up Group is a three‑step rhythm: **create a group type**, **choose which
content it can relate**, then **define its roles and permissions**. Everything here
lives under the **Groups** admin section and requires the **Administer group**
permission. The group types, roles and relationship types you create are all
configuration entities, so they export and deploy with `drush config:export`.

## The pieces you configure

| Thing | What it is |
|-------|------------|
| **Group type** | A bundle of group (like a content type is a bundle of node). Holds the label, description, revision default, and group‑creator behavior. |
| **Group role** | A role scoped to a group type — it carries the per‑group permissions it grants. |
| **Group relationship type** | Created when you install a relation plugin onto a group type; it ties a plugin (and its settings) to that group type. |

## 1. Site‑wide settings — `/admin/group/settings`

The base settings form has a single option:

- **Use the administration theme when creating/editing groups** *(on by default)* —
  render the group add/edit forms in the admin theme. Turn it off if you want those
  forms styled by the front‑end theme.

## 2. Create a group type — `/admin/group/types`

Add a group type (e.g. "Team", "Club", "Course"). On the group‑type form you set:

- **Label and description**.
- **Create new revision** — whether editing a group creates a new revision by default.
- **Group creator gets a membership** — automatically add the user who creates a group
  as a member of it.
- **Group creator must complete their membership** *(creator wizard)* — force the
  creator to fill in their membership immediately as part of creating the group.
- **Creator roles** — which individual roles the creator receives on that first
  membership (for example, make them the group's admin).

## 3. Choose what the group type can contain — the "content" page

Each group type has a **content** page
(`/admin/group/types/manage/{group_type}/content`) where you **install** relation
plugins. Installing a plugin is what actually lets a group type relate a kind of
entity:

- **Group membership** — relate users as members (available once Group is enabled).
- **Group node** — relate nodes of a chosen content type (needs the `gnode`
  submodule). You install it once per content type you want groups to contain.

Installing a plugin creates a **group relationship type** you can then edit or
uninstall.

## 4. Set up roles and permissions

Every group role has a **scope** that decides who it applies to:

- **Outsider** — applies to users who are **not** members of a group. It synchronizes
  with a sitewide role, so you can, for example, let all authenticated non‑members
  view a group.
- **Insider** — applies to users who **are** members. It also synchronizes with a
  sitewide role.
- **Individual** — assigned to specific memberships (e.g. one member is the group
  admin, another is an editor).

Manage roles per group type, then set what each role may do on the **group
permissions** pages:

- Group‑type permissions: `/admin/group/types/manage/{group_type}/permissions`
- Per‑role permissions:
  `/admin/group/types/manage/{group_type}/roles/{group_role}/permissions`

Typical per‑group permissions include joining/leaving a group, viewing published or
unpublished groups, editing the group, and managing its related content. A role
marked **admin** grants everything within its group.

## Putting it together

Once you have a group type with the membership plugin (and, say, the Group node
plugin) installed and roles configured, create an actual group under the Groups menu,
add members to it, and relate content to it. Access to that content is then governed
by the group's own roles and permissions rather than the sitewide ones.
