# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.3 or newer** (`php_requirement: 8.3`).
- A **Tap Payments account** and its API secret keys (sandbox and/or live).
- No other Drupal modules are required for the base module. The optional integration
  submodules need their target projects: the Commerce integration needs **Drupal
  Commerce**, and the Webform integration needs the **Webform** module.

> **Security-advisory note.** This project is not currently covered by Drupal's
> security advisory policy — factor that into your risk assessment for a payment
> module.

## Install with Composer

From the project root:

```bash
composer require drupal/tap_payment -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tap_payment -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tap_payment -y
```

## Optional integration submodules

Tap Payment can be driven from your own module, but it also offers integration
submodules that plug the same gateway service into other systems:

| Integration | What it adds | Extra requirement |
|-------------|--------------|-------------------|
| **Drupal Commerce** | Drives Commerce checkout through Tap's hosted payment. | Drupal Commerce |
| **Webform** | Collects a Webform-based payment through Tap. | Webform module |

Enable whichever you need, for example:

```bash
drush en tap_payment_commerce -y
```

(Enable only the integrations you actually use; the base module is enough if you are
driving payments from your own code.)

## Next step

Before you can take a payment you must enter your Tap keys and choose the
environment — see [Configuration](../configuration/index.md).
