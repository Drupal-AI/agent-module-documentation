<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Group Notify emails a group's members when a group node is added, updated, or commented on — using the Group module's membership to decide who to tell.

---

Group Notify extends the `gnode` (Group Node) relation plugin so that, per group type and per content type, you can turn on member notifications. It hooks `hook_group_relation_type_alter()` to swap the `group_node` plugin class for `NotifyGroupNode`, which adds a **"Notify group members"** checkbox and options to the plugin's configuration form (Administration → Groups → Group types → *Set available content* → Install/Configure). When enabled, an email goes out on three events: a node being added to the group (the group-relationship insert), a node update, and — if enabled — a new comment on a group node. Notifications are either **enforced** (always sent when a group node is created) or **toggled** (an optional *Send notification* checkbox appears on the content form, and on the node edit form a per-group checkbox lets an editor choose which groups to re-notify on update). Recipients are **all members** or only members holding the **`allow email notifications`** group permission. The email subject supports **`[node]` and `[group]` tokens** and has separate templates for new versus updated content; the body is the node (or comment) rendered in a dedicated `group_notify_email` view mode, sent as `text/html`. Crucially, recipients are filtered per person: `group_notify_process_members()` skips **blocked** users and runs a **`view` access check on the target node for each member**, and the content owner (and, for comments, the comment author) is excluded. Each recipient receives an **individual** `MailManager::mail()` call — there is no shared To/CC list — so member addresses are never disclosed to each other. For large groups, `queue_mail` is recommended so the mail send does not slow the node save.

---

A group without notification is a group people forget to visit. The value of a departmental workspace, a project team's area, or a course cohort's space is that members learn when something happens in it — the difference between a working intranet and a document dump — and because Group already models membership and roles, it knows exactly who should be told, which is the hard part when this is built from scratch. Three things shape how you deploy it. **Volume determines whether it works**: a group with daily activity that emails every member per item earns a filter rule within a week, at which point the notification stops being read; the useful shape for a busy group is the `role`-scoped audience (opt-in via the `allow email notifications` permission) or the toggle mode so editors send deliberately, and `queue_mail` to keep saves fast. **Access is enforced, but the content still travels**: the module does access-check each recipient's `view` permission on the node at send time — a member who cannot open the content is not emailed — but the email body carries the rendered node, so the material itself lands in whatever mailbox the member uses, including a shared or forwarded one. If that matters, keep the body minimal and lean on the subject-line tokens plus the site link so the read stays on the site. **Enforce versus toggle is an editorial decision**: enforced mode fires automatically the moment content joins the group (no human in the loop), which is right for announcements but wrong for drafts staged inside a group; toggle mode puts a checkbox on the form. Note that unpublished nodes (and unpublished comments, or comments on unpublished nodes) are never notified.

---

- Email a department's members when a new page is added to their group.
- Notify a project team when a document node is posted to the team's group.
- Tell a course cohort when new material is added to the class group.
- Send an announcement to every member of a working group.
- Notify only opted-in members by granting the `allow email notifications` group permission and choosing "Email group members with permission".
- Let editors decide per-post whether to notify, using toggle mode's checkbox.
- Re-notify chosen groups when an existing group node is edited, via the per-group checkboxes on the node edit form.
- Enforce automatic notification the instant content is added to a group (announcements channel).
- Notify members of a group when a new comment is posted on a group node.
- Exclude the author from their own content and comment notifications automatically.
- Customise the subject line per group with `[node:title]` and `[group:label]` tokens.
- Use different subject wording for new content versus updates.
- Send HTML-formatted emails that render the node in a dedicated email view mode.
- Suppress notifications for content a given member cannot view (per-recipient access check).
- Skip blocked user accounts when building the recipient list.
- Keep member email addresses private by sending one message per recipient (no shared To/CC).
- Queue notifications with `queue_mail` so saving a node in a large group stays fast.
- Drive notifications for a single group only, or all of a node's groups, from custom code via the `group_notify_group_ids` / `group_notify_all` node properties.
- Keep a private members' area engaged without maintaining a separate mailing list.
- Notify a committee when new papers are attached to its group.
- Localise each email to the recipient's preferred language (langcode per member).
