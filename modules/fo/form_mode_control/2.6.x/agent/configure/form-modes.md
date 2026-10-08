# Configure form modes per bundle & role

## Prerequisites (core Field UI)

1. Add a form mode: `/admin/structure/display-modes/form/add` (or per entity type). This creates
   an `entity_form_mode` config entity, e.g. `node.compact`.
2. Activate it for a bundle on that bundle's **Manage form display** page
   (`/admin/structure/types/manage/article/form-display`) — tick the form mode and Save. This
   creates an **enabled** `entity_form_display` config entity
   `core.entity_form_display.node.article.compact` (status: true). Form Mode Control only sees
   form displays whose `status` is true.

## Set the per-role defaults

Admin form: route `form_mode_control.configuration` →
`/admin/structure/display-modes/form/config-form-modes` (permission: `administer site configuration`).
For every entity type/bundle that has at least one non-default form mode, and for each role, you
pick a default form mode for **Create** and for **Edit**.

Values are stored in the config object **`form_mode_control.settings`** under `defaults`:

```yaml
defaults:
  node:
    article:
      create:
        editor: compact       # role_id: form_mode_id
      update:
        editor: full
```

Key path: `defaults.<entity_type>.<bundle>.<operation>.<role_id> = <form_mode_id>`, where
`operation` is `create` or `update`. Choosing the `default` form mode in the UI **removes** that
role's entry (the map only stores non-default overrides).

Read/write with drush:

```bash
drush config:get form_mode_control.settings defaults
drush config:set form_mode_control.settings defaults.node.article.create.administrator compact -y
```

## How the default is chosen at runtime (`hook_entity_form_display_alter`)

- Form mode `default`/`add` → operation `create`; `edit`/`entity_edit` → operation `update`.
  For the `user` entity: `register` → create, `default` → update.
- The current user's applicable role with the **highest weight** is used as `<role_id>`.
- If `defaults[...][role]` names an existing, enabled form display, it replaces the active one.

## Switch form mode by URL (`?display=`)

Append `?display=<form_mode_id>` to the create/edit URL, e.g.
`/node/add/article?display=compact` or `/node/1/edit?display=compact`. This overrides the default
**only when** the target form display is enabled **and** the user has permission
(the per-form-mode permission for that display, or `access_all_form_modes` — see
[../permissions/permissions.md](../permissions/permissions.md)).

## Automatic cleanup

`hook_entity_delete()` prunes `defaults` entries when the referenced form display **or** a role is
deleted, so stale mappings do not linger in `form_mode_control.settings`.
