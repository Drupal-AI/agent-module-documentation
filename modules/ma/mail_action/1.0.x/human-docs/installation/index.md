# Installation

## Requirements

- **Drupal 10.3 or newer, or Drupal 11** (`core_version_requirement: ^10.3||^11`).
- **Drupal core only** — no other contrib module is required.
- A configured **mailer transport (DSN)** so the site can actually send email (see
  below).
- To be genuinely useful, a module that *invokes* actions — most commonly
  **Views Bulk Operations** or **ECA**.

## Install with Composer

From the project root:

```bash
composer require drupal/mail_action -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/mail_action -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mail_action -y
```

Once enabled, the two action plugins — **Send email with formatted text** and
**Send email with raw HTML** — become available anywhere actions are used.

## Configure your site's mail transport (DSN)

Sending email requires a working mailer DSN. You usually set this once for the
whole site. For **local testing** with a tool like MailHog, you can add the
following to your local `settings.php`:

```php
// Mailer DSN settings for local testing with MailHog.
$config['system.mail']['mailer_dsn'] = [
  'scheme' => 'smtp',
  'host' => 'localhost',
  'port' => 1025,
];
```

The module also registers its own mail interface when installed
(`$config['system.mail']['interface']['mail_action'] = 'mail_action_html';`) — this
is configured automatically and normally needs no manual intervention. For details
on configuring the transport DSN in general, see the Drupal.org documentation on
mailer DSN settings.

## Verify it worked

Add the Views Bulk Operations field to a view (or open an ECA model) and confirm
that **"Send email with formatted text"** and **"Send email with raw HTML"** appear
as selectable actions. Sending yourself a test message — and, locally, seeing it
land in MailHog — confirms the transport is wired up. Remember to restrict the
action to trusted roles.
