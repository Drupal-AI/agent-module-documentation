# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Text** module (`text`), enabled automatically as a dependency.
- **Token** (`drupal/token`, `^1.0`) — powers the token replacement used
  throughout templates. Pulled in by Composer.
- **jQuery UI Resizable** (`drupal/jquery_ui_resizable`, `^2`) — used by the
  template editing UI. Pulled in by Composer.

**You also need a real HTML mailer.** Easy Email builds the message but hands
delivery to Drupal's mail system, so install and enable **one** of:

- **Symfony Mailer Lite** (`drupal/symfony_mailer_lite`), or
- **Symfony Mailer** (`drupal/symfony_mailer`).

Without an HTML mailer enabled, HTML emails will not be delivered properly.

## Install with Composer

From the project root:

```bash
composer require drupal/easy_email -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Token and jQuery UI Resizable.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/easy_email -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en easy_email -y
```

Then make sure your HTML mailer is installed and enabled too, for example:

```bash
composer require drupal/symfony_mailer_lite -W
drush en symfony_mailer_lite -y
```

## Submodules — enable only what you need

Easy Email ships two optional submodules:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Easy Email Commerce** | `easy_email_commerce` | Drupal Commerce order emails and tokens, including rendered order tables — for sending order receipts as Easy Email templates. |
| **Easy Email Override** | `easy_email_override` | Lets you replace core and contrib emails (password reset, account activation, welcome, etc.) with your own Easy Email templates. |

Enable them individually as needed:

```bash
drush en easy_email_override -y
```

Each requires the base Easy Email module, which is already present once you have
installed it above.

## Next steps

After enabling, grant the relevant permissions to your roles (see
[Configuration → Permissions](../configuration/index.md#permissions)) and create
your first template at **Structure → Email templates**.
