# Configuration

Nodeaccess is configured in two places: the **global settings form**, where you set
per-content-type defaults and decide which content types get a Grants tab, and the
**per-node Grants tab** itself, where you fine-tune a single node. Its permissions
decide who can do each.

## The global settings form

Go to **Configuration → People → Nodeaccess**
(`/admin/config/people/nodeaccess`). You need the *Administer Nodeaccess*
permission. Everything here is stored in the `nodeaccess.settings` config object.
For each content type you control:

- **Default grants per role** — for every role (plus **author**, a stand-in for the
  node's owner), tick which of **view / edit / delete** that role gets on nodes of
  this type *that have no per-node grants of their own*. This is the baseline: for
  example, give the "editor" role view + edit on every Article, and let authors edit
  their own.
- **Grants tab availability** — whether the per-node **Grants** tab is offered for
  this content type at all. Turn it on only for the types where you actually need
  per-node control, to keep the interface tidy.
- **Selectable roles** — which roles appear as options on the Grants tab, and in
  what order. Hiding roles you never grant keeps the tab manageable.
- **Allowed grant operations** — which of the view / edit / delete columns are even
  offered on the Grants tab and role grid. All three are available by default.

A useful rule to remember: **per-node grants override the content-type defaults.**
If a node has grants set on its Grants tab, those win and the defaults are ignored
for that node. Also, a *view* grant is still subject to publish status — an
unpublished node is not shown even if view is granted.

You can inspect the stored configuration from the command line:

```bash
drush config:get nodeaccess.settings bundles_roles_grants
```

## The per-node Grants tab

Once you have enabled the Grants tab for a content type, editing a node of that type
shows a **Grants** tab at `/node/{id}/grants`. A user with the right permission can:

- Set **view / edit / delete** for each selectable **role**, just for this node, and
- **Search users by name** and grant them view / edit / delete individually (with a
  "Keep?" checkbox to retain a user in the list).

Only the operations you enabled under **Allowed grant operations** appear. Saving
the tab writes the per-node grants and triggers a node-access rebuild so they take
effect.

## Permissions

Nodeaccess defines three kinds of permission (set them at **People → Permissions**):

| Permission | Machine name | What it gates |
|---|---|---|
| **Administer Nodeaccess** | `administer nodeaccess` | The global settings form. Security-sensitive — grant only to trusted admins. |
| **Grant all node permissions** | `grant node permissions` | The Grants tab on **every** node, regardless of content type. |
| **%type: grant node permissions** *(one per content type)* | `nodeaccess grant <type> permissions` | The Grants tab on nodes of **that one** content type. |

The per-type permissions let you delegate grant management narrowly — for instance,
let a page editor manage grants on Pages without touching anything else. A user
reaches a node's Grants tab if they hold *Grant all node permissions* **or** the
matching per-type permission for that node's type.

```bash
drush role:perm:add page_editor 'nodeaccess grant article permissions'
drush role:perm:add trusted 'grant node permissions'
```

## After changing grants

Nodeaccess flags node access for rebuild whenever grants change. If access does not
behave as expected, run a full rebuild via **Reports → Status report** (Rebuild
permissions) or:

```bash
drush php:eval 'node_access_rebuild();'
```
