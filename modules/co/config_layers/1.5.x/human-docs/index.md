# Config Layers — manual setup guide

**Config Layers** (`config_layers`) lets you organise your site's configuration into
multiple **layers** and manage them as independent workflows, rather than a single
flat config export. Each layer has both a database storage and a matching file
storage on disk. Layers are merged together — in weight order — to produce the final
merged configuration, which is then synchronized into the site's active
configuration. Think of it as something like config splits, but built around
layering and de-duplication.

The clever part is how layers stay lean. During the merge, each layer keeps **only
the configuration that differs from the layers below it** (lower weight). So a layer
becomes a snapshot of the *differences* from everything beneath it — a base profile
layer, an active layer on top, an overrides layer on top of that. Optionally, a
layer can carry a **reset** flag, which makes the merge use that layer's config
as-is and ignore what's already been merged — handy for forcing specific active
config objects to be reset by an "override layer."

Typical use cases: keeping profile/feature configuration separate from site changes,
running several independent configuration workflows, or letting an override layer
reset specific active config. It supports Drupal 11 and provides its own permission.

Config Layers is primarily **Drush-driven** — layers are imported, exported, and
synchronized from the command line — though the layer entities themselves can be
created either in the admin UI or via Drush.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — create and manage config layer
   entities (id, label, path, weight, reset).

## Where it lives in the admin menu

Config layer entities are managed at **Configuration → Development → Configuration
layers**, where you can add, edit, enable/disable, and delete layers. The actual
import/export/synchronize operations are run with Drush.

## How to use it (the Drush workflow)

Each layer has a folder on disk (its `path`) and a `weight` that sets its merge
order. Once your layers exist, you drive them with Drush:

```bash
# Import a layer's file config into its database storage
drush config-layers:import <layer_id>

# Import the current active config into a layer
drush config-layers:import <layer_id> --from-active

# Export a layer's config to disk
drush config-layers:export <layer_id>

# Merge all layers and write the result into active config
drush config-layers:synchronize

# Reverse: synchronize active config back into the layers
drush config-layers:reverse-synchronize   # alias: clrevsync
```

Additional commands mirror core config tooling for layers:
`config-layers:create`, `config-layers:delete`, `config-layers:get`,
`config-layers:set`, `config-layers:status`, `config-layers:enable`, and
`config-layers:disable`.

A common three-layer setup uses weights `-10`, `0`, `10`:

```bash
drush config-layers:create --id profile   --label Profile   --path profiles/contrib/xyz/config --weight -10
drush config-layers:create --id active    --label Active    --path config/layers/active        --weight 0
drush config-layers:create --id overrides --label Overrides --path config/layers/overrides     --weight 10
```

You might then import the profile config (`drush config-layers:import profile`),
import active config into the active layer
(`drush config-layers:import active --from-active`), and synchronize the merged
result into active config (`drush config-layers:synchronize`).
