# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Taxonomy** module (`taxonomy`) — part of core and enabled automatically as a
  dependency.

There are no third-party Composer or PHP library requirements, and no submodules.

A compatibility note: the module replaces core's taxonomy access handlers and the term
entity-reference selection plugin. If **another** module has already replaced those, it
deliberately refuses to run (throwing a clear error) rather than risk producing wrong
access results — so check for conflicts if you run other taxonomy-access modules.

## Install with Composer

From the project root:

```bash
composer require drupal/taxonomy_access_fix -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/taxonomy_access_fix -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en taxonomy_access_fix -y
```

Enabling the module turns on its fine-grained permission checks immediately — there is
**no settings form and no config to import**. Disabling the module later reverts to
core's default taxonomy access behaviour, with no data or field changes either way.

## Next steps

After enabling, the new permissions appear under the **Taxonomy Access Fix** provider at
**People → Permissions** (and on each vocabulary's Manage permissions tab). Grant the
specific permissions each role needs instead of the broad *Administer taxonomy* — see
**How to use it** on the [overview page](../index.md).
