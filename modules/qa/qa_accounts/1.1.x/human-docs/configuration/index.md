# Configuration

QA Accounts works the moment it's enabled — the full set of `qa_<role>` accounts
is created on install. This page covers the two optional settings, the accounts
themselves, the Drush commands, and how to remove everything again.

> **Reminder:** this is a development‑only module with guessable credentials.
> Never enable or configure it on a production site.

## What accounts get created

For every user role except *anonymous*, the module creates one account:

- **Username:** `qa_<role_machine_name>` — e.g. `qa_administrator`, `qa_editor`.
- **Email:** `qa_<role_machine_name>@example.com`.
- **Password:** the **same string as the username** (`qa_<role>`). These are known
  credentials by design.
- **Status:** active.
- **Role:** the matching role is granted. (The `qa_authenticated` account gets no
  extra role, since every logged‑in user is already authenticated.)

Creation is idempotent — if a username already exists it is skipped and logged, so
running the create routine again is safe.

## The settings form

Go to **Configuration → People → QA Accounts**
(`/admin/config/people/qa-accounts`). It exposes two checkboxes, both **off by
default**:

- **Auto‑create a user per new role** (`auto_create_user_per_new_role`) — when on,
  creating a new role automatically spawns its matching `qa_<role>` account.
- **Auto‑delete the user for a deleted role** (`auto_delete_user_per_deleted_role`)
  — when on, deleting a role automatically removes its `qa_<role>` account.

Turn these on if you frequently add or remove roles and want the QA set to track
them without re‑running the create/delete commands by hand.

### Heads‑up: who can actually open this form

In this release there is a mismatch between the permission the module defines
("**Administer QA Accounts settings**") and the permission string the route
actually requires. Because the required string doesn't correspond to a real
permission, Drupal denies the form to everyone **except user 1** — granting the
"Administer QA Accounts settings" permission to a role will *not* open the page.
In practice, only uid 1 can reach the settings form. You can still change the two
values from the command line:

```bash
drush config:set qa_accounts.settings auto_create_user_per_new_role true -y
drush config:set qa_accounts.settings auto_delete_user_per_deleted_role true -y
```

## Drush commands — create and tear down on demand

| Command | Aliases | What it does |
|---------|---------|--------------|
| `drush qa_accounts:create` | `qac`, `test-users-create`, `create-test-users` | Create a `qa_<role>` account for every role except *anonymous*. Idempotent — existing usernames are skipped. |
| `drush qa_accounts:delete` | `qad`, `test-users-delete`, `delete-test-users` | Delete all `qa_<role>` accounts. |

```bash
# Regenerate the full set after adding roles.
drush qa_accounts:create

# Remove them all again (before a demo, handoff, or uninstall).
drush qa_accounts:delete
```

Neither command takes arguments; results and skips are written to the
`qa_accounts` log channel.

## Teardown

There is no uninstall hook that cleans up the accounts, so **always delete them
before uninstalling** the module, otherwise the `qa_<role>` users linger:

```bash
drush qa_accounts:delete
drush pm:uninstall qa_accounts -y
```
