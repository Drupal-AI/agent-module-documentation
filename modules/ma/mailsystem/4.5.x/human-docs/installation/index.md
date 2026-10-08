# Installation

## Requirements

Mail System runs on **Drupal 9, 10.1+, or 11** (`^9 || ^10.1 || ^11`). It depends on
core's **Filter** module (`filter`), which ships with Drupal and is enabled
automatically as a dependency.

Mail System is the integration layer that other mail modules plug into, so on its own
it only changes *which* plugins core uses. To actually format or send mail differently
you will typically also install a contrib mail module — for example **Symfony Mailer**,
**SMTP**, **Swift Mailer**, **Mime Mail**, or **Mailgun** — which registers the
formatter and sender plugins you then select on the settings form. Install those first
if you need them; they are optional as far as Mail System itself is concerned.

## Install with Composer

From the project root:

```bash
composer require drupal/mailsystem -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/mailsystem -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mailsystem -y
```

This also enables core's `filter` module if it is not already on. Once enabled, the
settings screen appears under **Configuration → System → Mail System**
(`/admin/config/system/mailsystem`).

## Verify it worked

Log in as an administrator and go to `/admin/config/system/mailsystem`. You should see
the **Configure the Mail System** page with a **Default Mail System** section
(Formatter, Sender, and theme selects) and a **Module-specific configuration**
section. If that page loads, the module is installed correctly — continue to
[Configuration](../configuration/index.md).
