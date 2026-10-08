# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- The **Paragraphs** module (`paragraphs`) — Drupal enables it automatically as a
  dependency when you turn on Paragraphs Selection.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_selection -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_selection -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_selection -y
```

## Submodules

Paragraphs Selection ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Paragraphs Sets support** | `paragraphs_selection_paragraphs_sets_support` | Compatibility with the [Paragraphs Sets](https://www.drupal.org/project/paragraphs_sets) module, so bundle-declared selection rules apply there too. Enable it only if your site uses Paragraphs Sets. |

Enable it when needed with:

```bash
drush en paragraphs_selection_paragraphs_sets_support -y
```

## Verify it worked

After enabling, configure a paragraph bundle to declare where it may be used, then
edit content and confirm the paragraph-add widget offers exactly the types your
bundle-side rules allow. Because the field's own allowed-bundles setting still
exists, double-check that the two agree — see "How to use it" on the
[overview page](../index.md).
