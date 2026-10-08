# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.2 or later**.
- The Composer library **`webklex/php-imap`**, which is installed automatically
  when you install the module with Composer.
- An **IMAP‑accessible email account** whose folder you want to publish as a feed.
- A regular **cron** setup is recommended so new messages are fetched
  automatically.

No other Drupal modules are required.

## Install with Composer

From the project root:

```bash
composer require drupal/email_to_rss -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the
`webklex/php-imap` library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/email_to_rss -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en email_to_rss -y
```

## Verify it worked

Log in as an administrator and go to **Configuration → Web services → Email to
RSS**. If the settings form loads, the module and its IMAP library are installed
correctly. From here, follow [Configuration](../configuration/index.md) to
connect a mailbox and publish the feed.
