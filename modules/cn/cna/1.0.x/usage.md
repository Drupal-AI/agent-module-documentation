<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CNA (Comment Notify Author)

Sends an email notification to a node's author whenever a comment is posted or updated on that node.

- Notifies content owners about new discussion on their nodes without a full subscriptions system.
- Separately toggleable for new comments and for comment updates.
- Uses the site's mail system and the node owner's account email as the recipient.
- Lightweight: reacts to core comment hooks, no extra entities or storage.

---

## Installation & configuration

- Depends on the core `comment` module; enable with `drush en cna`.
- Configure at `/admin/config/system/cna` (permission: `administer cna configuration`).
- Enable "New comment" to notify on comment insert.
- Enable "Update to the comment" to notify on comment update (only when published).
- Recipient is the commented node's owner email; the message uses the site name and comment permalink.

---

## Usage & API

- `hook_comment_insert()` sends mail when `cna_new` config is enabled.
- `hook_comment_update()` sends mail when `cna_update` is enabled and the comment is published.
- `cna_mail()` implements `hook_mail()` for the `new_comment` message key.
- `_cna_send_mail()` dispatches through `plugin.manager.mail` using the recipient's preferred langcode.
- The recipient email is validated with `email.validator`; invalid/empty addresses are logged and skipped.
- The `From` address is the configured site email (`system.site` mail).
- The message body includes the notifying user's name, the node title and a link to the comment.
- Provides the permission `administer cna configuration` for the settings form.
- No public routes are exposed; only the admin settings route exists.
- Notifications fire synchronously during the comment save request.
- Only the single node author is notified (not other commenters or subscribers).
- Works with any comment-enabled entity that returns a `Node` as the commented entity.
- Useful for blogs and small community sites wanting author-only comment alerts.
- Does not provide per-user opt-in/opt-out; behaviour is global via the two toggles.
- If the node owner has no email, the send is skipped and an error is logged.
- Language of the email follows the recipient's preferred language where set.
