# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3||^10||^11`).
- No other Drupal modules and no third‑party Composer or PHP libraries are required.

> **Maintenance note:** this project is *minimally maintained* and is not covered by
> Drupal's security advisory policy. Given that it deliberately renders HTML in
> titles (see the security caution below), weigh that status carefully before using
> it on a production site.

## Install with Composer

The recommended way to install is via Composer. From the project root:

```bash
composer require drupal/html_titles -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/html_titles -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en html_titles -y
```

## Verify it worked

Edit a node, taxonomy term, or block, put some simple markup in its **title** field
(for example `A <em>test</em> title`), and save. If the title displays with the
formatting applied rather than showing the literal `<em>` tags, the module is
working.

> **Before you roll this out,** re‑read the security caution in the
> [overview](../index.md): allowing HTML in titles is a stored‑XSS surface, so
> restrict title editing on the affected entities to trusted editors only.
