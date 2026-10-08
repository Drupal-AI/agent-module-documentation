# Installation

## Requirements

Term Merge has no third-party libraries, but it does depend on another contrib
module to do the reference rewriting:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Taxonomy** module (`taxonomy`).
- The **[Term reference change](https://www.drupal.org/project/term_reference_change)**
  module (`term_reference_change`) — a hard dependency that handles re-pointing
  content from the old terms to the survivor. Composer pulls it in automatically.

The [Synonyms](https://www.drupal.org/project/synonyms) module is **optional** — if
present, Term Merge can carry old term labels over as synonyms on the surviving term.

## Install with Composer

From the project root:

```bash
composer require drupal/term_merge -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — here it also brings in Term reference change.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/term_merge -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en term_merge -y
```

This enables Term reference change as well if it isn't already on. There are no
submodules and no configuration form.

## Grant access

Nothing happens until you grant the two required permissions to a role — see
[How to use it](../index.md#grant-the-two-permissions) in the overview. Without both,
the **Merge** tab won't appear on your vocabularies.

## Verify it worked

Go to **Structure → Taxonomy**, open a vocabulary, and choose **List terms**. Once
the module is enabled and your role has the required permissions, a **Merge** tab
appears alongside *List terms*.
