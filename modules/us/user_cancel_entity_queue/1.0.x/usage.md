<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User Cancel Entity Queue queues deletion/reassignment of a user's entities for cron processing.

---

User Cancel Entity Queue **queues user-entity cleanup on cancel** — when a user is cancelled, it deletes or
reassigns that user's entities via a queue processed later by cron, so cancelling users with lots of content
doesn't time out. It provides its own permissions.

Use it to cancel content-heavy users reliably. It is an administration/user-management feature. Security note: it
performs **bulk deletion/reassignment of a user's content** — a destructive operation, so gate its permission to
trusted admins, verify the delete-vs-reassign choice, and note the cleanup happens asynchronously (content persists
until cron runs). It has no broader access-control role. Configure the cancel handling.

---

- Queue user-entity cleanup on cancel.
- Delete or reassign the user's entities.
- Process via cron later.
- Provide its own permissions.
- Serve administration/user management.
- Avoid cancel timeouts.
- Perform bulk deletion/reassignment (destructive).
- Gate the permission to trusted admins + verify delete-vs-reassign.
- Note cleanup is async (content persists until cron).
- Have no broader access-control role.
- Configure the cancel handling.
- Handle user cancel cleanup.
- Cancel users.
- Configure the queue.
- Clean up entities.
- Handle the cancellation.
- Reassign content.
- Delete content.
- Restrict the permission.
- Provide queued user-cancel cleanup.
