<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

Defined in `symfony_mailer_log.permissions.yml`:

| Permission | Gates |
|---|---|
| `view symfony mailer log entries` | Viewing log entries (the `view` operation, enforced by `SymfonyMailerLogAccessControlHandler`). |
| `delete symfony mailer log entries` | Deleting individual log entries (the `delete` operation). |
| `administer symfony mailer entity log entries` | Full administration of the entity (`admin_permission` on the entity type; also covers Field UI / manage displays). |

The settings form route (`symfony_mailer_log.settings`) is separately gated by the core
`administer site configuration` permission, not one of the above.

Access logic (from the access control handler): `view` and `delete` each require their matching
permission; any other operation returns *neutral* (so the entity-type `admin_permission`
`administer symfony mailer entity log entries` is what grants blanket access). Grant example:

```bash
drush role:perm:add support 'view symfony mailer log entries'
```

Log entries can contain full email bodies and recipient addresses, so treat "view" as sensitive.
