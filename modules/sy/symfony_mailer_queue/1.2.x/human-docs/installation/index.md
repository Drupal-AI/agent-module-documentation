# Installation

## Requirements

Symfony Mailer Queue needs:

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- The **Symfony Mailer** module (`symfony_mailer`) — the base mail system this
  module extends. Drupal enables it automatically as a dependency.

It works with Drupal's built-in **database queue** out of the box, so there is no
extra infrastructure or PHP library to install.

## Install with Composer

From the project root:

```bash
composer require drupal/symfony_mailer_queue -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Symfony Mailer
and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/symfony_mailer_queue -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en symfony_mailer_queue -y
```

If Symfony Mailer is not already enabled, list both:

```bash
drush en symfony_mailer symfony_mailer_queue -y
```

Enabling the module does **not** queue any mail on its own — you have to attach
the Queue sending adjuster to a mailer policy first. See
[Configuration](../configuration/index.md).

## Verify it worked

After you have attached the adjuster to a policy and some mail has been sent, you
can confirm the queue is receiving items with:

```bash
drush queue:list | grep symfony_mailer_queue
drush queue:run symfony_mailer_queue
```

The first command shows the `symfony_mailer_queue` queue and how many items are
waiting; the second processes them immediately.
