<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

`advancedqueue.permissions.yml` defines exactly one:

```yaml
administer advancedqueue:
  title: 'Administer queues'
  restrict access: true
```

`restrict access: true` means Drupal marks it as security-sensitive on the permissions page.

## What it gates

- The `advancedqueue_queue` entity type's `admin_permission`, so every CRUD operation on
  queue config entities: `/admin/config/system/queues`, `/add`,
  `/manage/{queue}`, `/manage/{queue}/delete`.
- Every job route declared in `advancedqueue.routing.yml`:
  `advancedqueue.job.release`, `advancedqueue.job.retry`, `advancedqueue.job.delete`
  and `advancedqueue.bulk_action_confirm`.
- The **Queues** menu link under *Configuration → System*.

## The delete exception

`QueueAccessControlHandler::checkAccess()` overrides the `delete` operation: a queue whose
`locked` property is `TRUE` returns `AccessResult::forbidden()` **even for a user holding
`administer advancedqueue`**. Every other operation is a plain
`allowedIfHasPermission($account, 'administer advancedqueue')`.

So to make a queue undeletable from the UI, set `locked: true` on the config entity rather
than fiddling with permissions.

```bash
drush role:perm:add content_editor 'administer advancedqueue'
drush user:role:add content_editor someuser
```

There is **no** separate permission for viewing the job list or for enqueueing jobs from
code — enqueueing is a pure API operation with no access check at all.
