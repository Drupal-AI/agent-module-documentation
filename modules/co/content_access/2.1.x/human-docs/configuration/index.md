# Configuration

Content Access has no central settings form. Instead you configure it on two
kinds of **Access control** tab: one per content type (the defaults), and one per
node (optional overrides).

## Per‑content‑type access (the defaults)

Go to **Structure → Content types → (your type) → Access control**
(`/admin/structure/types/manage/{type}/access`). Reaching this tab requires the
core **Bypass node access** and **Administer content types** permissions.

On this screen you tick which roles may perform each operation:

- **View any content** — a new operation this module adds. Controls who may view
  published nodes of this type.
- **View own content** — a new operation for viewing one's own nodes of this type.
- **Edit any / Edit own content** — these mirror Drupal core's per‑type edit
  permissions. Changing them here is the same as changing them at **People →
  Permissions**.
- **Delete any / Delete own content** — likewise mirror core's per‑type delete
  permissions.

Two further options appear on the form:

- **Per content node access control** *(off by default)* — when turned on, every
  node of this type gains its own Access control tab so editors can override these
  defaults per node (see below).
- **Priority** *(advanced, default 0)* — raise this only if you run several node
  access modules and need Content Access's grants to win. Drupal applies only the
  highest‑priority module's grants.

Because these are defaults, they are kept in sync with core permissions and only
the differences are stored.

## Per‑node overrides

When **Per content node access control** is enabled for a type, each node of that
type shows an **Access control** tab at **/node/{id}/access**. Editors use it to
override the content type's defaults for that single node. A **Reset to defaults**
button clears the override so the type defaults apply again.

Access to a node's tab is granted by the module's own permissions (below), not by
the content‑type permissions.

## Per‑user access with ACL (optional)

If the contributed **ACL** module is enabled, the per‑node Access control tab
grows a **User access control lists** section. There you can pick specific named
users and grant them view, edit, or delete access to that individual node — useful
for one‑off sharing that does not fit a role.

## Applying changes

Content Access works through Drupal's node grants system, so after changing
access rules you generally need to **rebuild node access permissions**. Drupal
will prompt you, or you can visit the status report and use the rebuild link (or
run `drush php-eval "node_access_rebuild();"`). Remember that only **published**
content is governed by this module — unpublished nodes stay under core's control
(their author and anyone with **Bypass node access**), and every viewer still
needs the core **View published content** (`access content`) permission.

## Permissions

The module defines two permissions under **People → Permissions** that gate the
per‑node tab:

- **Grant content access** — view and change per‑node access on **any** node.
- **Grant own content access** — view and change per‑node access on the user's
  **own** nodes only.

The per‑content‑type tab is instead gated by the core **Bypass node access** plus
**Administer content types** permissions.
