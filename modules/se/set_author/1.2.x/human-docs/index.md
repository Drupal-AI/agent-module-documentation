# Set Author — manual setup guide

**Set Author** (`set_author`) is a small add-on for the **Entity Share** ecosystem.
When you pull content from another Drupal site with **Entity Share Client**, Set
Author decides which *local* user becomes the author (`uid`) of each imported item —
so authorship is preserved (or sensibly reassigned) instead of everything landing on
whoever ran the import.

It ships as a single Entity Share Client **import processor** plugin. There's no
admin settings page, no permissions, and nothing to configure globally: you enable
and tune it **per import config** inside Entity Share's own UI. When an entity is
imported, the processor reads the source author from the JSON:API payload and resolves
a local user in this order: match by UUID → look the remote user up and match by email
→ then by username → optionally create a new local user → and finally fall back to a
configured "shared author" (anonymous by default). The resolved user is written to the
entity before it is saved.

Because it's purely a developer/integration processor with no UI of its own, this
guide folds the "how to use it" into this page rather than a separate configuration
section. The module requires **Entity Share** 3.x (`drupal/entity_share ^3.0`) with the
**Entity Share Client** submodule enabled, PHP 8.1+, and supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and its Entity Share dependency).

## Where it lives in the admin menu

Set Author has no menu entry of its own. It appears as a **Set author** processor you
can enable on an Entity Share Client import config, under **Configuration → Web
services → Entity Share → Import config** (`/admin/config/services/entity_share/import_config`).

## How to use it

1. Make sure **Entity Share Client** is set up with a remote and at least one
   **import config** (this is standard Entity Share configuration).
2. Edit the import config and enable the **Set author** processor in its processor
   list. (The processor runs in the `process_entity` stage; it is unlocked, so you can
   turn it on or off per import config.)
3. Configure its two settings, which are stored on that import config:
   - **Shared author** — the fallback user to assign when the source author can't be
     matched locally. Chosen with a user autocomplete; **anonymous** by default.
     Required.
   - **Create author if it does not yet exist** — when ticked, and no local match is
     found, a local user is created from the remote author's name, email, and status.
     Off by default.
4. Save, then run your import. As each item comes in, its `uid` is set following the
   resolution order described above. A missing or broken remote author never blocks
   the import — it simply falls back to the shared author.

> **Upgrading from an older release?** An update hook migrates the legacy
> `set_node_author` setting key to `set_author` on your existing import configs
> automatically when you run database updates.
