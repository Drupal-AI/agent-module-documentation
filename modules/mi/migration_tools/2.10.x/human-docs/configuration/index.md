# Configuration

Migration Tools is mostly a developer toolkit, so its only admin screen is a small
**debug‑logging** settings form. These options change how *chatty* a migration run is —
they do **not** change migration behavior, mappings, or destinations.

## Open the settings form

Go to **Content → Migrate → Migration Tools**
(`/admin/content/migrate/migration_tools`). You need the core **Administer site
configuration** permission.

## The settings

| Setting | Default | What it does |
|---|---|---|
| **Enable Debug Logging** (`debug`) | Off | Master switch for verbose migration debug output. |
| **Debug Level** (`debug_level`) | `3` | The log‑level threshold for messages emitted through the module's `Message` service (`0` = all messages, otherwise standard RFC log levels). |
| **Enable Drush Debug** (`drush_debug`) | On | Emit debug output to the Drush console during command‑line migrations. |
| **Enable Drush Stop On Error** (`drush_stop_on_error`) | Off | Halt the Drush migration run on the first error instead of continuing. |

## Set them from the command line

You can configure these without the UI:

```bash
drush config:set migration_tools.settings debug 1 -y
drush config:set migration_tools.settings debug_level 3 -y
```

All four values live in the `migration_tools.settings` config object (they're simple
scalars — the module ships no config schema for them). Everything else you do with
Migration Tools happens in your migration configs and custom code, not here — see the
[overview](../index.md#how-to-use-it) and the sibling agent docs.
