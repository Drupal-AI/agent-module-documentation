# Configuration

This module has no stored settings of its own — there is nothing to save on a
settings form. Instead it gives you a **fixer tool** (a UI form plus two Drush
commands) that acts on the live state of your database. Its "configuration" is
really "operating the tool," which is what this page covers.

> **Always run this on a dev or staging copy first**, then re-export your
> configuration afterwards. The tool deletes key-value rows and can delete
> leftover configuration objects.

## Open the fixer form

1. Log in as a user with the **Administer module missing message fixer**
   permission.
2. Go to **Configuration → System → Module Missing Message Fixer**, or navigate
   directly to `/admin/config/system/module-missing-message-fixer`.

## What the form shows

The form scans every `system.schema` record in the `key_value` table and, for
each one, checks whether that module still exists on disk. Any name whose code is
gone is listed as a **ghost** in a table with a checkbox next to it. The columns
are simply the module **Name** and its **Type** (always `module`). If there are
no ghosts, the table shows *"No Missing Modules Found!!!"* and there is nothing to
do.

## Removing ghosts

1. Tick the checkbox beside each ghost you want to clear. You can select several
   at once.
2. Click **"Remove These Errors!"**

For each selected module the form does two things:

- **Deletes leftover configuration** — any config object named `<module>.*` is
  removed. Because this touches your configuration, the form shows a *"Don't
  forget to export your config"* reminder.
- **Deletes the stale schema record** — the module's row is removed from the
  `key_value` table's `system.schema` collection.

Once done, the recurring "missing module" warning for those modules stops.

## Doing the same from Drush

The module ships two Drush commands, useful for scripting cleanup or working
without the UI.

### List ghosts — `mmmfl`

```bash
drush module-missing-message-fixer:list
drush mmmfl
```

Read-only. Prints the ghost modules it found (Name and Type columns), or *"No
Missing Modules Found!!!"* if there are none.

### Remove ghosts — `mmmff`

```bash
# Remove a single ghost by machine name
drush module-missing-message-fixer:fix my_old_module
drush mmmff my_old_module

# Remove every ghost at once
drush mmmff --all
```

Two important differences from the form to keep in mind:

- **`--all`** clears every ghost on the site *and*, like the form, also deletes
  each module's leftover `<module>.*` configuration. It prints *"All missing
  references have been removed."*
- **The single-name form** (`mmmff my_old_module`) only acts if that name is
  actually a ghost, and it removes just the `system.schema` key-value row — it
  does **not** delete leftover `<module>.*` config. Use the form or `--all` if you
  also need the config cleaned up.

> **Caution:** `--all` removes *every* ghost. On a shared environment prefer the
> named form so you don't touch entries a colleague is investigating.
