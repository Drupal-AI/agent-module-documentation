# Permissions

Defined in `moderation_sidebar.permissions.yml`.

| Permission | Gates |
|---|---|
| `use moderation sidebar` | Seeing the "Tasks" toolbar tab and opening the off-canvas sidebar; required on every sidebar route (`moderation_sidebar.sidebar`, `.sidebar_latest`, `.node.version_history`, `.translate`, `.translate_latest`). Note this only unlocks the UI — actual actions still go through the entity's own `entity.view`/`update`/`delete` access and core content-moderation transition validation. |
| `administer moderation sidebar` | The settings form (`moderation_sidebar.settings`) where per-workflow transitions are disabled. Marked `restrict access: true` (trusted/administrative). |

```
drush role:perm:add editor 'use moderation sidebar'
```

Beyond these two, what a user can actually do in the sidebar is bounded by content_moderation:
the quick-transition buttons are filtered to the transitions the user is permitted to make
(`content_moderation.state_transition_validation`), and edit/delete/translate buttons appear only
when the entity grants that operation.
