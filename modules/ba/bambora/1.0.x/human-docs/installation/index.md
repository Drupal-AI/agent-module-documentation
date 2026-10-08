# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- **Drupal Commerce**, specifically the **commerce_payment** and
  **commerce_order** modules. If Commerce is not already on your site, requiring
  this module with Composer will pull it in.
- A **Bambora (Worldline) merchant account** with API credentials.

This is a **1.0.x-dev** release. There are no additional third-party PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/bambora -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer fetch the Commerce
dependencies along with the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bambora -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bambora -y
```

## Handle the Bambora credentials securely

Your Bambora merchant/API credentials are payment secrets and fall under PCI
scope. **Never** hard-code them in tracked configuration or paste them where they
end up in a Git export or a database dump. Store them in the environment instead.

With DDEV, set the values and restart so the container picks them up:

```bash
ddev dotenv set .ddev/.env --bambora-merchant-id=<id> --bambora-api-key=<key>
ddev restart
```

`.ddev/.env` must stay out of version control. Confirm the variables reached the
container **without printing their values**:

```bash
ddev exec 'test -n "$BAMBORA_API_KEY" && echo set'
```

Then reference the variables from `settings.php` via
`getenv('BAMBORA_API_KEY')` (and, where the gateway supports a Key entity, back
its credential field with a Key that reads the environment variable). This keeps
the secrets in the environment, never in committed config.

## Next: configure the gateway

Once enabled, add and configure the Bambora payment gateway in Commerce — see
[Configuration](../configuration/index.md).
