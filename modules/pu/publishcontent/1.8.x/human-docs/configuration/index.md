# Configuration

Setting up Publish Content is two jobs: granting the right publish/unpublish
**permissions** to your roles, and (optionally) adjusting the **settings form** to
control how the toggle appears and behaves.

## Grant the permissions

Go to **People → Permissions**, or straight to
`/admin/people/permissions/module/publishcontent`. A user is allowed to toggle a
node's status if they satisfy **any** applicable permission below.

### Global permissions

| Permission | What it grants |
|------------|----------------|
| **Publish any content** | Publish any node, of any type. |
| **Unpublish any content** | Unpublish any node, of any type. |
| **Publish editable content** | Publish any node the user can already edit. |
| **Unpublish editable content** | Unpublish any node the user can already edit. |
| **Access publish content settings** | Reach the settings form described below. |

### Per‑content‑type permissions

For **every** content type, six more permissions are generated automatically —
publish and unpublish, each scoped to **any**, **own**, or **editable** nodes of
that bundle. For an "Article" type, for example, you'll see permissions like
"Publish own node type article" and "Unpublish any node type article". "Own" means
the current user authored the node; "editable" additionally requires core edit
access. New content types get their six permissions with no extra work.

This is how you build tiered workflows: give authors "unpublish own", give
reviewers "publish any", and nobody needs the sweeping "Administer nodes"
permission.

## The settings form

Open **Configuration → Workflow → Publish content**
(`/admin/config/workflow/publishcontent`). Reaching it requires the **Access
publish content settings** permission. The form is grouped into two sections.

### User interface preferences

- **Show the Publish/Unpublish local task tab** (`ui_localtask`, on by default) —
  shows the one‑click Publish/Unpublish tab beside a node's View and Edit tabs.
  This also gates the toggle action itself, so leave it on if you want the tab to
  work.
- **Show a publish checkbox on node forms** (`ui_checkbox`, off by default) —
  adds a Publish checkbox near the bottom of the node edit form. When this is
  off, the core "Published" status widget is disabled for everyone (so publishing
  goes through this module's permissions instead).

### Accountability preferences

- **Create a new revision on each toggle** (`create_revision`, off by default) —
  every publish/unpublish creates a new node revision with a "Changed to … by …"
  log message, giving you an audit trail.
- **Write a log entry on each toggle** (`create_log_entry`, off by default) —
  records each action to the logger (the `publishcontent` channel), visible under
  Reports → Recent log messages.

### Labels

Four required text fields let you reword the UI:

- **Publish text** (`Publish` by default) — the publish button/link/tab label.
- **Unpublish text** (`Unpublish` by default) — the unpublish label.
- **Published markup** (`Published` by default) — the status shown in the node
  form's meta area when the node is published.
- **Unpublished markup** (`Unpublished` by default) — the status shown when
  unpublished.

Use these to match your site's tone, e.g. "Go live" / "Retract". Click **Save
configuration** to apply; the tab label refreshes immediately.

You can also set any of these from the command line, for example:

```bash
drush config:set publishcontent.settings ui_checkbox 1 -y
drush config:set publishcontent.settings create_revision 1 -y
drush config:set publishcontent.settings publish_text_value 'Go live' -y
```

## Add the toggle link to a View (optional)

If Views is enabled, edit any node‑based view, add the field **Publish /
Unpublish**, and each row gets a one‑click toggle link (respecting the same
permissions and hidden where the user has no access). This is handy for building a
moderation queue where reviewers publish rows in place.
