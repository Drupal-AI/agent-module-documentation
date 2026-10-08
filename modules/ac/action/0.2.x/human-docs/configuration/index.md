# Configuration

Actions UI does not have a "settings" form of its own. Instead it gives you a page
for viewing available actions and for creating and configuring advanced
(configurable) ones.

## Open the actions page

1. Log in as a user with the **Administer actions** permission (an administrator
   by default).
2. Go to **Configuration → System → Actions**, or navigate directly to
   `/admin/config/system/actions`.

The page lists all **simple** actions currently available (from core and any
module — publish, unpublish, delete, promote, and so on), plus a **Create an
advanced action** selector at the top.

## Create an advanced action

1. On the actions page, choose an action type from the **Create an advanced
   action** select and continue.
2. Give the action a descriptive **Label** — this is what appears in bulk‑operation
   and workflow UIs, so make it recognizable.
3. Fill in the plugin‑specific settings (below) and **Save**.

The three configurable action plugins this module ships are:

| Action | Applies to | What you configure |
|--------|-----------|--------------------|
| **Change the author of content** (`node_assign_owner_action`) | Nodes | The user to reassign authorship to. (A user select is shown for small sites, an autocomplete for large ones.) |
| **Unpublish content containing keyword(s)** (`node_unpublish_by_keyword_action`) | Nodes | A comma‑separated list of keywords; a node is unpublished if any keyword appears in its rendered output or title. Keyword matching is **case‑sensitive**. |
| **Unpublish comment containing keyword(s)** (`comment_unpublish_by_keyword_action`) | Comments | The comment equivalent of the above. |

You can create several keyword‑unpublish actions with different keyword lists — for
example one policy that catches profanity and another that catches competitor
names.

## Using, editing, and deleting actions

- **Edit** or **delete** an advanced action from the same actions page (the row for
  each configured action has links).
- Advanced actions become available as building blocks for other tools — for
  example Views Bulk Operations can offer them as bulk operations on a view of
  content, and ECA or Rules can invoke them as part of a workflow. Actions do not
  run on their own; something else (a bulk operation, a workflow, a cron sweep)
  executes them.

## Deploying across environments

Each configured advanced action is saved as an `action.action.*` config entity, so
you can export it as configuration and deploy it like any other config.
