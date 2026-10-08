<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Confirm Unpublish shows a confirmation dialog when an editor unpublishes a node, so taking a page off the site is a deliberate act rather than an unnoticed checkbox.

---

Unpublishing in Drupal is a checkbox on the node form, next to Save, with the same visual weight as changing a title — but the consequence is not: the page disappears from the site, from menus, from search, and anyone holding the URL gets access-denied. This module adds a browser confirmation modal to that action for nodes, on core `^10.2 || ^11`, version **1.0.6**, depending only on core `node`. Install it as usual, then configure it at **`/admin/config/content/confirm-unpublish`** (permission **Administer Confirm Unpublish settings**), where you set three things: the **confirmation message** (a rich-text field, though markup is stripped to plain text when shown), a **logging** toggle that records a line in Recent Log Messages (`/admin/reports/dblog`) each time a user clicks Confirm, and a **content-type exclusion list**. Two behaviors are worth knowing before you rely on it. First, the guard is **advisory**: clicking *Confirm* only closes the dialog and lets the Published box stay unchecked — the editor still has to press Save, and *Cancel* simply re-checks the box; it never hard-blocks the submit. Second, the exclusion list is **opt-in in practice**: despite the "all types included by default" help text, the dialog only appears once you have selected at least one content type in the list, and it then shows for every type **except** the ones you ticked — with the shipped empty list, no type gets a dialog. A stronger alternative for high-stakes sites is core **content moderation**, where unpublishing becomes a workflow transition with its own permission and log entry; this module is the lighter-weight fit when full moderation is more process than the team wants.

---

- Prevent accidental unpublishing of a node.
- Confirm before taking a page offline.
- Warn an editor about the consequence of unpublishing.
- Reduce accidental dead links.
- Add a confirmation modal to the node form.
- Customize the confirmation message text.
- Log who confirmed an unpublish, to dblog.
- Exclude specific content types from the dialog.
- Show the dialog only for chosen content types.
- Protect published landing pages.
- Protect a high-traffic or campaign page.
- Slow down a destructive editorial action.
- Reduce support tickets about missing pages.
- Make unpublishing a deliberate act.
- Support a cautious editorial team.
- Avoid silent removal from menus and search.
- Add a guard without adopting full content moderation.
- Audit unpublish-confirmation clicks via Recent Log Messages.
- Turn logging off to keep the dialog but skip the log line.
- Improve editorial safety on node forms.
