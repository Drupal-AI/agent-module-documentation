# Configuration

Client Config Care doesn't have a traditional "settings form" — instead you work
with the **config blocker entities** it records, control access through permissions,
switch protection on or off through a settings flag, and manage everything from the
command line with Drush. This page covers each of those.

## Reviewing config blockers

Go to **Structure → Config blocker entities**
(`/admin/structure/config_blocker_entity`). This is the overview of every config
item currently protected from being overwritten on import. Each blocker is a
revisionable entity that records what config changed and carries a log of who
changed it and when.

From here you can:

- **Review** the full list of protected config items before a deployment, so you
  know exactly what your next `drush config:import` will leave untouched.
- **Add** a blocker manually if you want to protect an item explicitly.
- **Delete** a blocker when you *do* want the next import to overwrite that item
  again — removing the blocker releases the item back to normal import behaviour.
- **View revisions** of a blocker to see the history of a tracked item.

## Permissions

All blocker operations are permission-gated. The permissions cover add, edit,
delete, view (published and unpublished), and revision management, plus an
**administer** permission that is flagged *restrict access*. Grant the administer
permission only to trusted, technical roles — it's the one that controls the
protection machinery, not just individual entities.

## Turning protection on and off

Protection can be switched off globally through a `settings.local.php` flag:

```php
$settings['client_config_care'] = [
  'deactivated' => TRUE,
];
```

Set this on local/dev environments where you want imports to apply cleanly. The
common pattern is: deactivate to force a full, clean re-import; run the import; then
reactivate so live changes are protected again. Confirm the current state with
`drush client_config_care:is_activated`.

## Drush commands

The module ships Drush commands for auditing and managing blockers:

| Command | What it does |
|---------|--------------|
| `client_config_care:show_all_blockers` | List all current config blockers (name, when, who) — use this to audit what's protected before a deploy. |
| `client_config_care:delete_config_blocker_by_name <name>` | Delete the blocker(s) for a specific config name, so the next import can overwrite that item. |
| `client_config_care:delete_all_blockers` | Remove every config blocker entity. |
| `client_config_care:is_activated` | Report whether protection is currently active. |
| `client_config_care:generate_fixtures` | Create sample/fixture blocker entities (for testing). |

A typical pre-deployment routine is: run `show_all_blockers` to see what's
protected, use `delete_config_blocker_by_name` to release anything you now want to
overwrite, confirm `is_activated`, then run your `drush config:import`.
