<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Assigning shortcut sets to roles

## UI

Go to **Configuration → User interface → Shortcuts → Shortcuts Per Role**
(`/admin/config/user-interface/shortcut/roles`, route `shortcutperrole.admin_config`,
permission `administer shortcut per role`). Each role has a select listing every existing
shortcut set; pick one per role and Save.

Prerequisite: create the shortcut sets first under **Shortcuts** (core
`entity.shortcut_set.collection`). The select only offers sets that already exist.

## Where it is stored

Simple config object `shortcutperrole.settings`:

```yaml
role:
  content_editor: editors_set     # role_id: shortcut_set_id
  administrator: admin_set
```

Read/write with drush:

```bash
drush config:get  shortcutperrole.settings
drush config:set  shortcutperrole.settings role.content_editor editors_set -y
```

Programmatically:

```php
\Drupal::configFactory()->getEditable('shortcutperrole.settings')
  ->set('role.content_editor', 'editors_set')   // shortcut set id
  ->save();

// Read back:
\Drupal::config('shortcutperrole.settings')->get('role.content_editor');
```

## Resolution rule (which set a user gets)

`hook_shortcut_default_set($account)` (in `shortcutperrole.module`):

1. Loads all roles in role order and intersects with the account's roles.
2. Takes `end()` of that list — the **last / highest-weight** matching role.
3. Returns `shortcutperrole.settings:role.<that_role>`, or `'default'` if unset/empty.

So a user with both `authenticated` and `administrator` gets the `administrator`
mapping (administrator is heavier). Only roles whose users have core's toolbar + shortcut
access actually see a difference.

## Cleanup

`hook_user_role_delete()` deletes `shortcutperrole.settings:role.<role_id>` automatically
when a role is removed, so no stale mapping remains.
