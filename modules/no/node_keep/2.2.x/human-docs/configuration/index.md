# Configuration

Node Keep is configured in three places: on **individual nodes**, on each **content
type** (for defaults), and on a small **global settings form**. Which of these a
user can see and use is controlled by three permissions.

## Protecting an individual node

1. Edit the node.
2. In the right‑hand sidebar, open the **Node keep** section.
3. Tick **Prevent this node from being deleted**. If Pathauto is installed, you'll
   also see **Prevent this node's alias from being changed**.
4. Save.

From then on, the node cannot be deleted by anyone without the **Administer
node_keep per node** permission, and the delete option is removed from its edit
form. To lift protection, untick the box again (which also requires that
permission).

## Per‑content‑type defaults

If you want every new node of a type to be protected automatically, set a default
on the content type:

1. Go to **Structure → Content types**, and edit the type (for example *Landing
   Page*).
2. Open the **Node keep defaults** section.
3. Tick the checkbox(es) you want on by default.
4. Save.

New nodes of that type will now be created with protection already switched on.
(Existing nodes are unaffected; set those individually.)

## Global settings

There is a single global setting at **Configuration → Content authoring → Node
Keep** (`/admin/config/content/node-keep`), gated by the **Administer node_keep**
permission:

- **Hide warning messages** — by default, protected nodes show a "limited access
  permissions" warning on their edit and delete pages. Turn this on to hide that
  warning from editors.

You can also set it with Drush:

```bash
drush cset node_keep.settings hide_warning_messages true -y
```

## Permissions

Node Keep defines three permissions at **People → Permissions**:

- **Administer node_keep** — access to the global settings form.
- **Administer node_keep per node** — the key permission. It lets a user change the
  protection checkboxes and delete a protected node. This is effectively the "can
  bypass Node Keep" permission, so grant it only to trusted roles (administrators).
- **Access node_keep widget** — controls whether the **Node keep** checkboxes are
  even visible on the node form. Without it, the section is hidden entirely, even
  for users who could otherwise change it.

Note that core's **Bypass content access control** permission also lets a user
delete any node regardless of Node Keep, because protection is enforced through
Drupal's node access system.
