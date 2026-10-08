# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- Core's **Contact** module (`contact`) — the only dependency, enabled
  automatically as needed. No modules outside core are required.

There are no additional PHP libraries or third‑party Composer requirements. This
project is covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/contact_tools -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/contact_tools -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en contact_tools -y
```

## Verify it worked

There is no UI to check — Contact Tools exposes its features to code, Twig, and the
text filter. Confirm it is enabled under **Extend** (or with `drush pml | grep
contact_tools`), then start using its service, Twig functions, or text filter as
described in the module's developer documentation.
