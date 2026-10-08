# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- For **free checks**: nothing to configure — no account or API key is needed.
  (Keyless checks are rate-limited; a free EqualWeb API key removes the limit.)
- For **AI remediation**: a free EqualWeb account with credits.
- Outbound network access from the server to the EqualWeb service, since files are
  sent there for processing when you run a check or remediation.

## Install with Composer

From the project root:

```bash
composer require drupal/equalweb_pdf -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/equalweb_pdf -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en equalweb_pdf -y
```

## Verify it worked

Go to **Reports → EqualWeb PDF Accessibility** (`/admin/reports/equalweb-pdf`). You
should see the dashboard listing the PDFs already on your site. Running a free check
on one of them should return an accessibility score and a rule-by-rule report. Next,
see [Configuration](../configuration/index.md) for registration, permissions and the
remediation workflow.
