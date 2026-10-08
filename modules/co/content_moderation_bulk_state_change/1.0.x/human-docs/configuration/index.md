# Configuration

Content Moderation Bulk State Change works as soon as it's enabled — a bulk action
appears on your content views automatically. This page covers the settings form
that governs the action and the permissions that control who may use it.

## Open the settings form

1. Log in as an administrator (you need the *Access content moderation bulk state
   change configuration* permission).
2. Go to **Configuration → Workflow → Content Moderation Bulk State Change Settings**
   (`/admin/config/workflow/content-moderation-bulk-state-change`), or use the module's
   *Configure* link on the **Extend** page. The settings are stored under the
   configuration key `content_moderation_bulk_state_change.settings`.

### Create new revision?

The form has a single option, **"Create new revision?"**:

- **On** — each bulk state change creates a **new revision** of the node, preserving the
  previous revision in the node's history.
- **Off** (default) — the change updates the **existing** latest revision in place rather
  than creating a new one.

## Permissions

The module provides two permissions, set at **People → Permissions**
(`/admin/people/permissions`):

- **Update entity moderation states in bulk** — allows a role to run the bulk
  "Change workflow stage" operation. Grant it to the editorial roles that should be able
  to move content in batches.
- **Access content moderation bulk state change configuration** — allows a role to open
  the settings form above.

The bulk action is also offered per node according to that node's edit (update) access,
and on the confirm form all selected nodes must share the same workflow and current
moderation state; the target-state dropdown lists the transitions defined from that
current state. Configure your core **Content Moderation** workflow and its per-role
transition permissions to match how you want editors to move content, then grant the
bulk permission above to the roles that should be able to do it for many nodes at once.
