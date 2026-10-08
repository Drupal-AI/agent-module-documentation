# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Link Checker** contrib module (`linkchecker`) — this module reports on
  Link Checker's findings, so install and configure Link Checker first.
- A working outbound **mail setup** on your site, since the whole point is to
  send email. Confirm your site can send mail (core's mail system, or a mail
  module such as SMTP/Symfony Mailer) before relying on the digest.

This is a **beta** release (version 2.0.0-beta4) — it is covered by Drupal's
security advisory policy, but test it before using it on a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/linkchecker_summary_mail -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed — including Link Checker if it isn't already present.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/linkchecker_summary_mail -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en linkchecker_summary_mail -y
```

Drupal enables **Link Checker** automatically as a dependency if it is not
already on.

## Verify it worked

Once enabled, open the Link Checker configuration (**Configuration → Content
authoring → Link checker**) and confirm the new summary-email options appear —
see [Configuration](../configuration/index.md). Set a schedule and recipient,
then let cron run (or run cron manually) to confirm a summary email is sent as
expected.
