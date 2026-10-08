# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3||^11`).
- **EU Cookie Compliance** (`eu_cookie_compliance`) — the consent banner.
- **Cookie Content Blocker** (`cookie_content_blocker`) — blocks embedded content
  until consent.
- **EU Cookie Compliance GTM** (`eu_cookie_compliance_gtm`) — gates Google Tag
  Manager behind consent.
- Intended for a **Rocketship**‑based site.

Composer pulls in the three dependency modules automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/eu_cookie_compliance_rocketship -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed and fetch the required consent modules.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eu_cookie_compliance_rocketship -W`, `ddev
> drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en eu_cookie_compliance_rocketship -y
```

Drupal will enable `eu_cookie_compliance`, `cookie_content_blocker` and
`eu_cookie_compliance_gtm` as dependencies.

## Verify it worked

Load a front‑end page as an anonymous visitor — the EU Cookie Compliance consent
banner should appear, styled to fit Rocketship. Then do the substantive
configuration in the underlying modules (see the parent guide's "How to use it"),
and confirm non‑essential cookies and scripts do not load until you consent.
