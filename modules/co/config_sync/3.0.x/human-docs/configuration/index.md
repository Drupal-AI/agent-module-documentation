# Configuration

Configuration Synchronizer has **no settings form of its own**. You work with it through
the **Distribution Updates** page (provided by its Config Distro dependency) and, if you
prefer, a couple of Drush commands.

## The Distribution Updates page

1. Log in as an administrator.
2. Go to **Configuration → Development → Distribution Updates**, or navigate directly to
   `/admin/config/development/distro`.

This page lists any configuration updates that your installed modules, themes, and
install profiles have shipped since they were installed (or last synchronized). For each
extension you can see which config objects have changes available, choose which to apply,
pick an update mode, and submit.

If nothing is listed, there are no pending extension config changes — either everything
is up to date, or you haven't updated any extensions since installing them.

## Update modes — how changes are applied

The **update mode** decides what happens to your existing configuration when you apply an
update. There are three:

- **Merge** *(the default)* — a three-way merge. The extension's changes are applied while
  your own local customizations are preserved. This is the safe, conservative choice:
  adopt upstream improvements without losing the label, permission, or setting edits you
  made on your site.
- **Partial reset** — resets **only** the config items that have available updates back to
  the version the extension provides. Use this when a specific item has drifted locally
  and you want to take the shipped version for just those items.
- **Full reset** — resets **all** extension-provided config to exactly what the extensions
  currently ship. This is the most aggressive option — it discards local changes to
  provided config — and is useful for returning a site to a known baseline.

On the Distribution Updates form you pick the mode before submitting. The choice is
remembered in Drupal's state system, so the mode you last used carries over until you
change it.

## Applying and reviewing updates from Drush

Configuration Synchronizer adds one listing command and extends Config Distro's apply
command with a mode option:

```bash
# List every extension that has config updates available:
drush config-sync-list-updates
drush cs-list                      # short alias

# Get the list as JSON instead of a table:
drush config-sync-list-updates --format=json
```

To apply the updates from the command line, use Config Distro's update command. Configuration
Synchronizer adds an `--update-mode` option to it:

```bash
drush config-distro-update --update-mode=1   # merge (default)
drush config-distro-update --update-mode=2   # partial reset
drush config-distro-update --update-mode=3   # full reset
```

If you omit `--update-mode`, whatever mode is currently stored in state is used (merge if
you've never changed it). You can also set the stored mode directly:

```bash
drush state:set config_sync.update_mode 3    # default to full reset
drush state:get config_sync.update_mode
drush state:delete config_sync.update_mode   # back to the default (merge)
```

## A note on how updates are detected

You don't configure this, but it helps to understand it: when you enable the module it
snapshots the config each installed extension provides. Installing further modules or
themes refreshes the snapshot for those extensions. After a `composer update`, the
updated extension's provided config differs from the snapshot, and that difference is
exactly the list of updates shown on the Distribution Updates page and by
`drush config-sync-list-updates`.
