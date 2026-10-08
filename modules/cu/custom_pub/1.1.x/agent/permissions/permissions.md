# Custom Publishing Options — permissions

## Static permission

- **`administer custom publishing options`** — create/edit/delete custom publishing option
  entities (`restrict access: true`). Defined in `custom_pub.permissions.yml`.

## Dynamic per-option permissions

A permission callback, `Drupal\custom_pub\CustomPublishingOptionPermissions::permissions()`,
generates one permission per option:

```
can set node publish state to <option_id>
```

with title "Can set node publish state to <Label>". This controls whether that option's checkbox
is shown (`#access`) on the node add/edit form. So for an option `archived` the permission is
`can set node publish state to archived`.

## Important core-status caveat

The custom options are gated **only** by their per-option permission. But to see core's own
`status` / `promoted` / `sticky` checkboxes at all, a role still needs `administer nodes` (or the
Override Node Options module). Without `administer nodes` a role can still see and set the custom
publishing options, just not the core ones.

## Grant with drush

```bash
drush role:perm:add editor 'can set node publish state to archived'
drush role:perm:add editor 'administer custom publishing options'
```
