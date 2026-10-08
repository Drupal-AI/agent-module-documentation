<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring CiviCRM → Drupal user sync

**Route:** `/admin/config/cmrf_user_sync/usersyncconfig`.

## Steps
1. Ensure `cmrf_core` has a working CiviCRM connection (CiviMRF) and the Change Messages extension in CiviCRM.
2. Select the **Connection** and a **Change MessageDefinition**.
3. Choose a **Processor**:
   - **Basic User Sync** (`cmrf_basic_user_sync`): create when no user has the contact id; update name/email on match; block (non-admin) when email empties. Map `name`, `email`, `contact_id` fields.
   - **Portal User Sync** (`cmrf_portal_user_sync`): matches by email; creates users, sends the `status_activated` mail, assigns **roles**, and applies a **userdeletepolicy** of `delete` or `block`. Map `name`, `email`, `old_email`, `contact_id`, `roles`, plus arbitrary user fields.
4. Tick **Enabled** so cron processes messages. Disabling deletes the queue.

## Runtime
- `hook_cron` seeds a `['get', NULL]` item when the queue is empty.
- The QueueWorker `get` calls `ChangeMessageApiQueue.get`, enqueuing one `['process', message]` per value; `process` runs the configured processor's `process($contactId, $message, $config)`.

## Security
- The route is only `access administration pages`-gated, yet the Portal processor can grant roles and delete users. Restrict the route (e.g. to `administer users`) if that permission is broadly held.
- `field_user_contact_id` write access requires `administer users`.
- Admin-role accounts are never auto-deleted/blocked. New accounts are created with no password (user must reset).
