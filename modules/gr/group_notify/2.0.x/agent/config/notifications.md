<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group Notify — notification configuration

Group Notify has **no dedicated settings page**. All options live on the **Group Node (gnode) relation
plugin's configuration form**, per group type and per content type. The `NotifyGroupNode` plugin
(`src/Plugin/Group/Relation/NotifyGroupNode.php::buildConfigurationForm()`) injects them.

## Where
Administration → Groups → Group types → *(pick a group type)* → **Set available content** → find a
"Group node" plugin → **Install** or **Configure**.

## Options (config keys in `group_relation.config.*`, schema in `config/schema/group_notify.schema.yml`)

| Form field | Config key | Values | Effect |
|---|---|---|---|
| Notify group members | `notify` | boolean | Master switch. Nothing is sent unless this is on. |
| Notification mode | `notify_mode` | `enforce` \| `toggle` | `enforce`: always send when a group node is created (fires on group-relationship insert). `toggle`: an optional *Send notification* checkbox (default checked) appears on the group-content add form; the editor decides. |
| Who to notify? | `notify_who` | `all` \| `role` | `all`: every non-blocked member who can view the node. `role`: only members who additionally hold the **`allow email notifications`** group permission. |
| Email subject for new posts | `notify_subject_insert` | string (tokens) | Subject on insert. Supports `[node]` and `[group]` tokens. Default: `New group content: [node:title]`. |
| Email subject for updated posts | `notify_subject_update` | string (tokens) | Subject on update. Same token support. Default: `Group content update: [node:title]`. |
| Enable comment notifications | `comments` | boolean | Only shown when the `comment` module is enabled. Emails members when a new comment is posted on a group node. |

## Behavioural notes
- **Update notifications**: on the **node edit form**, one checkbox per group the node belongs to
  (where notify is enabled) lets the editor pick which groups to re-notify; submitting calls
  `group_notify_notify($content, TRUE)` so the *updated* subject is used.
- **Recipient filtering** (`group_notify_process_members()`): blocked users skipped; each member is
  `view`-access-checked against the node; content owner / comment author excluded; each recipient
  emailed individually in their preferred language.
- **Suppression**: unpublished nodes are never notified; unpublished comments, or comments on an
  unpublished node, are never notified.
- **Body**: the node/comment rendered in the `group_notify_email` view mode. Adjust what appears in
  emails by editing that view mode's field display and the module's Twig templates.
- **Performance**: emails send synchronously during the save. Install
  [`queue_mail`](https://www.drupal.org/project/queue_mail) for large groups.
- **Permission grant**: for `role` mode, grant *"Receive email notifications"*
  (`allow email notifications`) to the relevant group roles under the group type's permissions.
- **Uninstall** removes the `group_notify_email` view modes and strips the `notify*`/`comments` keys
  from each gnode plugin's configuration.
