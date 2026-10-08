# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Filter** module (`filter`) — enabled on any standard Drupal site.
- The contributed **Token** module (`token`) — Composer pulls it in for you.

There are no third‑party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/node_token_filter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Token module and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/node_token_filter -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en node_token_filter -y
```

## Verify it worked

Go to **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`), edit a trusted text format, and confirm the Node
Token Filter appears in the **Enabled filters** list. Tick it, save, then place a
`[node:title]` token in content using that format and view it on a node page — the
token should resolve to that node's title.
