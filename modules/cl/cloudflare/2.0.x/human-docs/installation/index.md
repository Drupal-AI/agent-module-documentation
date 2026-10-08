# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **CTools** module (`drupal/ctools`, `^3.0 || ^4.0`) — the settings screen is
  built as a CTools wizard. Composer installs it as a dependency.
- The PHP **JSON** extension (`ext-json`), which is standard on any modern PHP.
- A **Cloudflare account** with a zone for your site, and an API token (or the
  legacy API key + email) to authenticate with.

For the optional **Cloudflare Purger** submodule you'll additionally need the
**Purge** module (`drupal/purge`), and typically **Purge Queuer URL**
(`drupal/purge_queuer_url`) if you want to purge by URL.

## Install with Composer

From the project root:

```bash
composer require drupal/cloudflare -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in CTools and update
any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cloudflare -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Store your credentials securely

Cloudflare API tokens and keys are secrets — never commit them to configuration or
code. Save the value in an environment variable (for DDEV,
`ddev dotenv set .ddev/.env --cloudflare-api-token=<value>` then `ddev restart`),
and reference it from a Key entity or from `settings.php`. See the project's
AGENTS.md for the full secret-handling workflow.

## Enable the module

```bash
drush en cloudflare -y
```

To also enable cache purging:

```bash
composer require drupal/purge drupal/purge_queuer_url -W
drush en cloudflarepurger -y
```

## Verify it worked

Visit **Configuration → Web Services → Cloudflare**
(`/admin/config/services/cloudflare`). You should reach the settings wizard, where
you can enter credentials and run a validation check. Once configured, its
`valid_credentials` flag records whether the credential check passed.
