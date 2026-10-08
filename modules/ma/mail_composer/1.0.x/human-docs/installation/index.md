# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **Drupal core only** — the module uses core services (the mail manager, language
  manager, and config factory) and has **no additional dependencies**.
- For **HTML** email delivery, an HTML‑capable mail plugin such as **Symfony
  Mailer** or **SwiftMailer** (optional, but recommended for rich messages).

## Install with Composer

From the project root:

```bash
composer require drupal/mail_composer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mail_composer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mail_composer -y
```

Enabling the module makes the `mail_composer.manager` service and the
`Drupal\mail_composer\Email` class available to other modules. There is nothing to
configure — this is an API module used from code.

## Verify it worked

Because Mail composer has no UI, the way to confirm it is working is from code:
inject the `mail_composer.manager` service into one of your own services or use
`\Drupal::service('mail_composer.manager')`, compose a simple message, and send it
to yourself. If delivery is configured (for example via Symfony Mailer, or MailHog
locally), the message should arrive. A `MailingException` indicates a required
property (`to`, `langcode`, or `key`) was missing.
