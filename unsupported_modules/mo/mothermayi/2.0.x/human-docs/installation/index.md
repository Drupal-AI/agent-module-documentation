# Installation

> **Before you install:** Mother May I is **unsupported**, and its Drupal
> security-advisory coverage has been **revoked** because of an unfixed security
> issue. Consider an actively maintained anti-spam module instead. Install this
> only if you understand and accept that status.

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).

There are no other module dependencies and no third-party PHP libraries. The
module protects core's user-registration form, so self-registration should be
enabled on your site for it to be useful.

## Install with Composer

From the project root:

```bash
composer require 'drupal/mothermayi:^2.0'
```

(If you are coming from the older `8.1.x` series, this same command upgrades you
to `2.0.x`.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require 'drupal/mothermayi:^2.0'`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mothermayi -y
```

Enabling the module has **no effect until you set a secret word** — with no word
defined, the registration form behaves normally. See
[Configuration](../configuration/index.md).

## Verify it worked

Confirm the module is enabled:

```bash
drush pm:list --status=enabled | grep mothermayi
```

Then set a secret word (next page) and load the registration form as an anonymous
visitor: you should see the secret-word field (and hint), and submitting a wrong
word should block registration and appear in **Reports → Recent log messages**.
