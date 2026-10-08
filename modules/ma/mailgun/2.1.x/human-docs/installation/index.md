# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- The **Mailsystem** module (`drupal/mailsystem`), through which you select
  Mailgun as the site mailer. Composer installs it and Drupal enables it as a
  dependency.
- **PHP libraries**, pulled in automatically by Composer: `mailgun/mailgun-php`
  (`~3.0`), `nyholm/psr7` (`~1.2`), and `html2text/html2text` (`^4.0.1`).
- A **Mailgun account** with a verified sending domain and a private API key —
  external to Drupal, but required for real sending.

## Install with Composer

From the project root:

```bash
composer require drupal/mailgun -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Mailsystem and the
Mailgun PHP libraries and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mailgun -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mailgun -y
```

## Submodules — optional

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Email Templates Examples** | `mailgun_email_templates_examples` | Ready‑made branded HTML email templates you can adapt. |
| **Mailing Lists** | `mailgun_mailing_lists` | A newsletter signup block and mailing‑list management backed by Mailgun lists (reuses the *Administer Mailgun* permission). |

Enable either with `drush en`, for example:

```bash
drush en mailgun_mailing_lists -y
```

Once enabled, configure the connection at **Configuration → System → Mailgun** —
see [Configuration](../configuration/index.md).
