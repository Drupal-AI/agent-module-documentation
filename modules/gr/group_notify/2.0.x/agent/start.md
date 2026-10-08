<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Group Notify (group_notify) — agent index

Emails a **group's members** when a group node is **added, updated, or commented on**. Requires the
Group module's **`gnode`** submodule (`group:gnode`). Version **2.0.0-rc1**; core `^9.5 || ^10 || ^11`,
Group `~2.2 || ~3.2`.

## How it works
- **Extends the Group Node plugin.** `hook_group_relation_type_alter()` swaps the `group_node`
  relation plugin class for `NotifyGroupNode` (`src/Plugin/Group/Relation/NotifyGroupNode.php`),
  which adds a **"Notify group members"** checkbox plus options to the plugin's configuration form.
- **Configured per group type + content type**, not globally: Administration → Groups → Group types
  → *Set available content* → Install/Configure the gnode plugin. Config keys: `notify`,
  `notify_mode` (`enforce`/`toggle`), `notify_who` (`all`/`role`), `notify_subject_insert`,
  `notify_subject_update`, `comments`. See [agent/config/notifications.md](config/notifications.md).
- **Triggers** (all in `group_notify.module`):
  - `group_notify_group_relationship_insert()` / `group_notify_group_content_insert()` — a node is
    added to a group. Sends when notify is enabled **and** mode is `enforce`.
  - `group_notify_node_update()` → `_group_notify_node_change()` — sends on update when the node
    carries the `group_notify_all` or `group_notify_group_ids` property (an API for custom code); the
    node **edit form** also adds per-group checkboxes that call `group_notify_notify(..., $edit=TRUE)`.
  - Toggle mode adds a *Send notification* checkbox to the group-content add form.
  - `group_notify_comment_insert()` — a new comment on a group node, if `comments` is enabled.
- **Recipients** are built by `group_notify_process_members()`: iterates `getGroup()->getMembers()`,
  **skips blocked users**, runs a **per-member `view` access check on the target node**, and (in
  `role` mode) requires the `allow email notifications` group permission. The content **owner** (and,
  for comments, the **comment author**) is excluded. Each recipient gets an **individual**
  `MailManager::mail()` — no shared To/CC.
- **Message.** Subject via `getEmailSubject()` with `[node]`/`[group]` token replacement (separate
  insert/update strings). Body is the node/comment rendered in the **`group_notify_email`** view mode
  (`templates/node--group-notify-email.html.twig`, `comment--group-notify-email.html.twig`), sent as
  `text/html`; From is the site email. Unpublished nodes/comments are never notified.

## Key facts for planning
1. **Volume.** Enforced mode emails every eligible member per item — for busy groups prefer `role`
   opt-in and/or `toggle` mode, and install `queue_mail` (recommended) so the synchronous send does
   not slow the node save.
2. **Access is enforced, content still travels.** Recipients are access-checked at send time, so a
   member who cannot view the node is not emailed — but the email **body contains the rendered
   node**, so the content lands in the member's (possibly shared) mailbox. Keep the body minimal and
   rely on subject + site link if that matters.
3. **Enforce vs toggle** is the automatic-vs-deliberate choice; enforced fires the instant content
   joins the group.

## Files
- `data.json` — metadata.
- `usage.md` — orientation, mechanism, use cases.
- `agent/config/notifications.md` — the plugin configuration options and their effects.

## Not provided
No routes, no services (`.services.yml`), no Drush commands, no blocks, no submodules. Provides one
group permission (`allow email notifications`) and config schema for the plugin keys. Recommends but
does not depend on `queue_mail` and `comment`.
