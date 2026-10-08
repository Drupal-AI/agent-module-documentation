<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CiviCRM User Synchronisation consumes CiviCRM "change messages" through CiviMRF and creates, updates, blocks, or deletes Drupal user accounts to keep them in sync with CiviCRM contacts.
---
The module reads a configured CiviCRM ChangeMessage definition over a `cmrf_core` connection, enqueues each message, and processes them on cron via the `cmrf_user_sync_queue` QueueWorker. A pluggable `UserMessageProcessor` decides what to do with each contact message. `BasicUserProvider` creates a user when a contact id has no matching account (matched via the `field_user_contact_id` user field), updates name/email on an existing match, and blocks a synced user (unless it has the `administrator` role) when the email goes empty. `PortalUserProvider` additionally assigns configured **roles**, notifies the user on activation, and can **delete** synced users according to a delete policy (admin-role users are protected). Cron seeds a "get" item when the queue is empty; each "process" item maps message fields (name, email, contact id, roles) per the configuration.

Operationally the sync is driven entirely from CiviCRM data (a trusted upstream reached via `cmrf_core`) and runs unattended on cron. **Security note:** the configuration form at `/admin/config/cmrf_user_sync/usersyncconfig` — which selects the connection/message definition, the processor, and (in the Portal processor) the **roles granted to synced accounts** and the **delete-vs-block policy** — is gated only by `_permission: 'access administration pages'` (routing.yml). That permission is far weaker than the impact: a non-superadmin holder can configure mass account creation, role assignment, and deletion. Consider restricting the route to `administer users`/`administer site configuration`. Field access to `field_user_contact_id` is correctly limited to users with `administer users` (`cmrf_user_sync.module:54-62`). Created accounts are saved without an explicit password (users must reset), and account queries in the processors use `accessCheck(FALSE)` (expected for a system sync).
---
- Enable the module (requires `cmrf_core` and a CiviCRM connection).
- Configure a connection and ChangeMessage definition at `/admin/config/cmrf_user_sync/usersyncconfig`.
- Choose the Basic or Portal user processor.
- Map message fields to user name, email, and contact id.
- Enable the sync so cron processes change messages.
- Create Drupal users automatically from new CiviCRM contacts.
- Update a synced user's name/email when the contact changes.
- Block a synced user when its email becomes empty (Basic processor).
- Delete or block synced users per policy (Portal processor).
- Grant configured roles to synced users (Portal processor).
- Notify users on account activation (Portal processor).
- Track the CiviCRM contact id via the `field_user_contact_id` user field.
- Enable per-message logging for troubleshooting.
- Disable the sync to clear the processing queue.
- Restrict the config route to a high-privilege role (recommended).
- Protect administrator-role accounts from deletion/blocking (built in).
- Run the sync on cron (a "get" item seeds when the queue is empty).