# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No third‑party PHP libraries and no other contrib module dependencies for the
  base module — the integration and meta-type submodules ship inside the same
  project.

> **Heads up:** on Drupal.org this project is currently marked *Unsupported /
> no further development* and is not covered by the security advisory policy.
> That does not stop it working, but weigh it before adopting it on a new site.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_meta_relation -W
```

Note that the Composer package name (`drupal/entity_meta_relation`) is different
from the module's machine name (`emr`). The `-W`
(`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/entity_meta_relation -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module first:

```bash
drush en emr -y
```

## Submodules

The base `emr` module provides the framework; you get useful behaviour by
enabling the submodules that ship with it:

| Submodule | What it adds |
|-----------|--------------|
| **`emr_node`** | Integrates the meta-entity system with the Node (content) entity type. Enable this if you want to attach metadata to nodes. |
| **`entity_meta_audio`** | An example meta type carrying an audio profile. |
| **`entity_meta_speed`** | An example meta type carrying a reading/playback speed profile. |
| **`entity_meta_visual`** | An example meta type carrying a visual variant. |
| **`entity_meta_force`** | An example meta type carrying feature toggles. |
| **`entity_meta_example`** | A reference implementation — **read this one** before writing your own meta type. |

For example, to attach metadata to nodes and try the visual meta type:

```bash
drush en emr_node entity_meta_visual -y
```

## Verify it worked

Check that `emr` and your chosen submodules appear as enabled on the
**Extend** page (`/admin/modules`). Because the metadata is revision-aware, a
good functional check is to save a node, add its metadata, create a new revision,
then view the earlier revision — it should still show the metadata that revision
had rather than the current values.
