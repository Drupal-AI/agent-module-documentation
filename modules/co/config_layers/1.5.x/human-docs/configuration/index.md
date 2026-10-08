# Configuration

Config Layers is configured by creating **config layer entities**. Each layer
describes a folder of configuration on disk, where it sits in the merge order, and
whether it resets already-merged config. You can create layers in the admin UI (this
page) or with `drush config-layers:create`; either way, the import/export/synchronize
operations are then run with Drush (see the [overview](../index.md)).

## Open the layers admin page

1. Log in as a user with the module's manage-layers permission.
2. Go to **Configuration → Development → Configuration layers**.

You'll see the list of layers with options to add, edit, enable/disable, and delete
them.

## Add or edit a layer

Click **Add** (or **Edit**). A layer has these fields:

- **Id** — the machine name of the layer (for example `profile`, `active`,
  `overrides`). It's how you reference the layer in Drush commands.
- **Label** — the human-readable name shown in the layer list.
- **Path** — the folder this layer imports from and exports to (for example
  `profiles/contrib/xyz/config`, `config/layers/active`, or
  `config/layers/overrides`). This is the layer's file storage; the module also
  maintains a matching database storage for it.
- **Weight** — the merge order. Layers are merged from lowest weight to highest, and
  each layer keeps only the configuration that differs from the layers below it. A
  common scheme is `-10` (base/profile), `0` (active), `10` (overrides).
- **Reset** — when set, the merge process ignores already-merged configuration and
  uses this layer's config as-is. Use it for an "override layer" that must force
  specific active config objects to particular values.

## Enable / disable a layer

Layers can be individually **enabled or disabled** from the list (or with
`drush config-layers:enable` / `config-layers:disable`), so you can temporarily take
a layer out of the merge without deleting it.

## After creating layers

Creating a layer only defines it. To move configuration in and out, use the Drush
commands described in the [overview](../index.md#how-to-use-it-the-drush-workflow) —
`config-layers:import`, `config-layers:export`, and `config-layers:synchronize` —
which perform the merge and write the merged result into active config.
