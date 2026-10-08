<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SafeDelete prevents editors from deleting (or archiving) a node that is referenced by Linkit-created links inside other entities' body fields, so publishing broken links is avoided.

---


When a node delete (or a change to an archived moderation state) is attempted, the module validates whether the node is linked from other nodes' body fields via Linkit and, if so, blocks the delete and lists the referencing content on the delete form. It can be enabled/disabled per bundle, cap how many referencing records are shown, and optionally hide the delete button entirely for dependent content (users with `safedelete show delete button` can still see it). It also provides an orphaned-nodes report (`admin/content/safedelete-orphanedpages`) behind its own permissions. Settings live at `admin/config/development/safedelete`. It relies on HTML Purifier (`ezyang/htmlpurifier`) to parse links.

Setup: install Linkit + `ezyang/htmlpurifier`, enable SafeDelete, choose which bundles it guards and the record limit on the settings form.
---
- Prevent deleting nodes linked from other content.
- Avoid broken Linkit links in body fields.
- Enable/disable protection per content type.
- Block the delete button for dependent nodes.
- Allow privileged users to force-show the delete button.
- List the referencing content on the delete form.
- Limit how many referencing records are shown.
- Validate archiving to an archived moderation state.
- Generate an orphaned-nodes report.
- View the orphaned-nodes report.
- Restrict administration with `safedelete administration`.
- Gate report generation with a dedicated permission.
- Gate report viewing with a dedicated permission.
- Warn editors before they break inbound links.
- Protect key landing pages from accidental deletion.
- Keep referential integrity across body-field links.
- Configure protection at `admin/config/development/safedelete`.
- Integrate with Linkit's link markup.
