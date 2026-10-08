# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Paragraphs** module (`paragraphs`).

There are no additional Composer or PHP library requirements.

> **Heads-up:** This module and the Graupl framework are at a very early stage
> of development and are **not recommended for production** until a stable
> release exists.

## Install with Composer

From the project root:

```bash
composer require drupal/graupl_paragraphs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and will pull in Paragraphs if it isn't already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/graupl_paragraphs -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en graupl_paragraphs -y
```

Drupal enables Paragraphs automatically as a dependency if it isn't on yet.

## Verify it worked

There is no settings page. Go to **Structure → Paragraph types**, edit a
paragraph type, and confirm the Graupl behavior(s) appear in its **Behaviors**
section, ready to enable.
