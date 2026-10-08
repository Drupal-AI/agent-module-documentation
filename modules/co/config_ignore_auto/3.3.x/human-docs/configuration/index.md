# Configuration

## Open the settings form

Go to **Configuration → Development → Configuration synchronization → Ignore Auto**
(`/admin/config/development/configuration/ignore_auto`). You need the **Import
configuration** permission.

## The settings

| Setting | Default | What it does |
|---|---|---|
| **Status** (master switch) | Off | Turns auto-tracking on. While off, nothing is recorded. |
| **Show message** | Off | Displays a status message each time a config object is auto-added to the ignore list — handy while you are getting a feel for what it captures. |
| **Auto-ignored config** | *(empty)* | The list the module builds automatically. You normally don't hand-edit it, except to **remove** lines (see "Resetting" below). |
| **Whitelist** | `core.extension` | Config names that must **never** be auto-ignored, listed exactly. `core.extension` (the enabled-modules list) is protected by default and should stay there. |
| **Direction operations** | all six | Which sync direction + operation combinations the auto-ignores apply to: `import_create`, `import_update`, `import_delete`, and the three `export_*` equivalents. Trim this if, for example, you only want to protect edits on **import**. |

## Recommended: turn it on only in production

So it never captures config changes you make locally or in CI, leave the **Status**
checkbox off in the UI and instead activate it with a `settings.php` override on
your production environment:

```php
// settings.php (production only)
$config['config_ignore_auto.settings']['status'] = TRUE;
```

This keeps the feature dormant everywhere else while protecting live edits on prod.

## How it decides what to ignore

Once active, the module listens for configuration being saved or deleted. When a
config object actually changes (it compares the new value against the old one, so a
no-op save is skipped) and it isn't whitelisted, the module appends that config
name to the auto-ignore list and feeds it to Config Ignore.

It deliberately does **not** record changes in these situations, to avoid capturing
changes that aren't real editor edits:

- during a **config sync** (`drush cim` / `drush cex`),
- during **module install or uninstall**,
- while the site is in **maintenance mode** — this is the intended way to apply
  database updates (`hook_update_N`) that change config without them being
  auto-ignored. While in maintenance mode, the module shows a warning on config
  forms to remind you.

## Reviewing and resetting the list

The settings form shows the accumulated auto-ignored list, which doubles as an
audit of which live edits have diverged from your code. Once you have merged those
edits back into your exported configuration, you can prune the corresponding lines
from the list (or clear it) so the items are no longer force-ignored.

## Save

Click **Save configuration**. Toggling **Status** off keeps everything already in
the ignore list ignored — it just stops new changes from being added.

## A note on Domain Config UI

If you use Domain Config UI, this module marks its **own** settings as not
overridable per domain, so its behavior stays consistent across domains.
