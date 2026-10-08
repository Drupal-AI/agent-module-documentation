<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Content Lock is a thin glue module that switches on the Content Lock module for every node type and wires its locked-content list into the admin UI, so LocalGov Drupal sites get pessimistic edit-locking out of the box.

---

Two people editing the same page and one silently overwriting the other is the oldest collaborative-editing failure there is, and Content Lock's answer is pessimistic locking: whoever opens the edit form holds it until they save or release it. This module does not reimplement any of that. It depends on Content Lock, and its entire job is configuration and glue.

On install it writes `types.node = ['*' => '*']` into `content_lock.settings`, which means every current and future node bundle is locked while being edited — you do not have to remember to tick a box per content type. It also adds a "Locked content" tab to `/admin/content` and a "Locked content" item to the admin menu, both pointing at Content Lock's own `view.locked_content.page_1` listing so editors and administrators can see what is currently held. There is no settings form of its own; everything tunable lives on Content Lock's page at `/admin/config/content/content_lock`.

For LocalGov Drupal the context is specific and makes locking more valuable than usual: councils have large editorial teams, a lot of content that several people have a legitimate reason to touch, and service pages where a silent overwrite has real consequences for someone trying to find out when their bins are collected. The lock timeout is left at Content Lock's 30-minute default, which is the first thing to review for your team.

**The setting to check first is lock breaking.** Someone must be able to release a stale lock, and if that is an administrator-only permission on a team of forty editors, the practical effect is that people wait for an administrator or edit around the lock. Whoever can be reached quickly should be able to break one, and Content Lock records who did. Because this module only sets defaults on install, later changes are made directly in Content Lock's config and are not re-applied by re-installing.

---

- Turn on edit-locking for all node types on a LocalGov Drupal site in one enable.
- Prevent two editors overwriting each other's changes to the same page.
- Lock a node while its edit form is open and release it on save.
- Give editors a "Locked content" tab on the content admin page.
- Give administrators a "Locked content" item in the admin menu.
- See at a glance which pages are currently held via `view.locked_content.page_1`.
- Adopt LocalGov's editorial locking defaults without hand-configuring Content Lock.
- Automatically lock new content types as they are added (the `['*' => '*']` wildcard).
- Review and adjust the 30-minute lock timeout at `/admin/config/content/content_lock`.
- Decide who may break a stale lock via Content Lock's permissions.
- Support a large council editorial team touching shared content.
- Protect service pages from silent concurrent overwrites.
- Audit stale locks held by editors who abandoned a session.
- Release a lock held by someone who went to lunch three hours ago.
- Record who broke a lock for accountability.
- Train editors on what the locking messages mean.
- Standardise locking behaviour across many council sub-sites.
- Verify locking still behaves after a core or Content Lock upgrade.
- Document the module's install-time behaviour for a site's runbook.
- Roll locking out consistently as part of a LocalGov distribution profile.
