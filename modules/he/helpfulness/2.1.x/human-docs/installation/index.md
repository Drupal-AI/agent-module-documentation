# Installation

## Requirements

Helpfulness has no third‑party dependencies:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).

There are no Composer library or PHP extension requirements. If you plan to expose
the feedback block to anonymous visitors, consider adding the
[CAPTCHA](https://www.drupal.org/project/captcha) module for spam protection.

## Install with Composer

From the project root:

```bash
composer require drupal/helpfulness -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/helpfulness -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en helpfulness -y
```

## Verify it worked

After enabling, place the **Helpfulness** feedback block from **Structure → Block
layout** and visit a page where it appears. You should see the "Was this helpful?"
yes/no question, and choosing an answer should expand the comment area. See
[Configuration](../configuration/index.md) to customize the wording, turn on email
notifications, and set who can view the collected feedback.
