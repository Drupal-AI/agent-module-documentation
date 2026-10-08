# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **BigPipe** (`big_pipe`) and **Dynamic Page Cache** (`dynamic_page_cache`).
- The contributed **Paragraphs** module (`paragraphs:paragraphs`).
- The **Preprocess** module (`preprocess:preprocess`).

Composer pulls in the contributed dependencies when you require the module with the
`-W` flag; the core modules are enabled automatically as dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/big_pipe_paragraphs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer fetch and update the
Paragraphs and Preprocess dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/big_pipe_paragraphs -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en big_pipe_paragraphs -y
```

Drupal enables the core BigPipe and Dynamic Page Cache dependencies automatically;
make sure Paragraphs and Preprocess are enabled too. Once active, paragraphs load
progressively with no further configuration.
