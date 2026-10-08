# Configuration — the splits list and how splits work

Config Split does not have a global settings form. Instead, each split you create is
its own configuration entity, and they are all managed from a single list page. This
page explains where that list lives and how the splits on it take part in Drupal's
normal configuration import and export.

## Open the splits list

1. Go to **Configuration → Development → Configuration synchronization →
   Configuration Split**
   (`/admin/config/development/configuration/config-split`).
2. The page shows every split defined on the site.

![The Configuration Split setting list](../images/list.png)

Each row shows the split's **label**, its **machine name**, its **description**, its
**current status** (whether it is active right now, taking environment overrides
into account) and its **default status** (the value stored on the entity), plus an
**Operations** menu. From that menu you can edit or delete a split and run its
per-split operations. Click **+ Add Configuration Split setting** to create a new
one — see [Creating a split](../creating-a-split/index.md).

## How splits take part in import and export

The configuration listed as part of a split is **exported to the split's own
storage rather than the usual sync directory** when you export the whole
configuration. When you import the whole configuration, the config in the split
storages is merged back with the default sync directory and overrides it.

Because Config Split hooks into core's configuration synchronization, you normally
do **not** need to do anything special: your existing
`drush config:export` / `config:import` (or the **Synchronize** UI) already respect
whichever splits are active. Two kinds of split behave differently at export time:

- A **complete split** removes its config from the main sync entirely and stores it
  only in the split. On environments where the split is inactive, that config (and
  the module it belongs to) is absent — this is what lets a dev-only module stay off
  production.
- A **partial split** keeps a base version of the config in the main sync and stores
  only the per-environment differences as a patch, which is merged back on import.

Both are configured when you [create the split](../creating-a-split/index.md).

## The Drush workflow

Alongside the standard sync commands, Config Split provides commands for operating on
a single split explicitly:

| Command | What it does |
|---|---|
| `drush config-split:export <split>` | Export the config the split selects into the split's storage/folder. |
| `drush config-split:import <split>` | Import the split's stored config into the active configuration. |
| `drush config-split:activate <split>` | Write the split's config into active storage (activate the split). |
| `drush config-split:deactivate <split>` | Remove the split's config from active storage. Add `--override` to also set a runtime status override. |
| `drush config-split:status-override <name> [active\|inactive\|none]` | Set or clear a runtime status override (alias `csso`); run with no value to show the current setting. |

For example:

```bash
drush config-split:export development
drush config-split:import development
drush config-split:status-override development active
```

These commands require **Drush 10 or newer**. In everyday use you will mostly rely on
the ordinary `drush config:export` / `drush config:import`, which already apply your
active splits — the commands above are for acting on one split on its own.
