# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Three third-party PHP libraries, pulled in automatically by Composer:
  - **`getbrevo/brevo-php` `~2.0`** — Brevo's official API SDK.
  - **`nyholm/psr7` `~1.2`** — PSR-7 HTTP message implementation.
  - **`html2text/html2text` `^4.0.1`** — generates plain-text versions of HTML
    mail.
- A **Brevo account** and an **API v3 key** (you create the key in your Brevo
  dashboard under *SMTP & API*).

Optional, depending on what you want to do:

- **[Mail System](https://www.drupal.org/project/mailsystem)** or
  **[Symfony Mailer](https://www.drupal.org/project/symfony_mailer)** — needed by
  the **Brevo Mailer** submodule to route Drupal's mail through Brevo.
- **[Webform](https://www.drupal.org/project/webform)** — needed to use the Brevo
  transactional-email Webform handler.
- **[Token](https://www.drupal.org/project/token)** — adds a token browser to the
  Brevo Commerce list-subscriber pane.

## Install with Composer

From the project root — Composer resolves the SDK libraries for you:

```bash
composer require drupal/brevo -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/brevo -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en brevo -y
```

Then head to [Configuration](../configuration/index.md) to enter your API key.

## Submodules — enable only what you need

Brevo ships two optional submodules. Enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Brevo Mailer** | `brevo_mailer` | Routes Drupal's outgoing mail (`hook_mail`) through Brevo, via Mail System or Symfony Mailer. Adds queue, theme-wrapper, and sandbox/test options. |
| **Brevo Commerce** | `brevo_commerce` | Adds a checkout pane to Drupal Commerce so customers can opt in to selected Brevo newsletter lists. |

For example, to route all site mail through Brevo:

```bash
drush en brevo_mailer -y
```

Both submodules require the base Brevo module, which is already present once you
have installed it above.

## Verify it worked

Open **Reports → Status report** (`/admin/reports/status`). Brevo reports there
whether the SDK library is installed and whether the API key is configured and
valid.
