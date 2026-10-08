# Installation

## Requirements

Simple Comment eMail Notification is about as lightweight as a module gets:

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- A working site mail system — the module uses Drupal's normal mail delivery to
  reach the administrator, so make sure your site can actually send email.
- No other modules, PHP extensions, or third‑party libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/simple_comment_email_notification -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/simple_comment_email_notification -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en simple_comment_email_notification -y
```

That is all. There is no settings form to fill in — the module begins emailing the
administrator on new comments immediately.

## Verify it worked

Post a test comment on any node that has comments enabled. The site
administrator's mailbox should receive a notification containing the comment, and
a matching entry should appear at **Reports → Recent log messages**
(`/admin/reports/dblog`). If no email arrives, check your site's mail
configuration first — the module relies on it.
