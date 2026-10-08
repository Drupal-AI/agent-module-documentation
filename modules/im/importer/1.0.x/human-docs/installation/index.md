# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Node** (`node`) and **Views** (`views`) modules.
- The **Paragraphs** module (`paragraphs`) — imported content is saved as nodes
  with paragraphs.

Composer pulls in Paragraphs for you; the core modules are enabled automatically as
dependencies. This release is **1.0.0‑rc3** (a release candidate).

## Install with Composer

From the project root:

```bash
composer require drupal/importer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in Paragraphs.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/importer -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en importer -y
```

Drupal enables Node, Views, and Paragraphs automatically if they are not already
on.

## Verify it worked

Because Importer is a framework, the clearest confirmation is functional: enable a
module that builds an import pipeline on top of Importer (or define your own), then
run that pipeline against a sample file and check that a draft node is created for
the editor to refine.
