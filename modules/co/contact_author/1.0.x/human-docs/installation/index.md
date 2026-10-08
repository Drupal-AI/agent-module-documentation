# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Contact** module (`contact`) enabled — this is the only dependency, and
  Drupal enables it automatically. The module relies on core's *personal* contact
  form feature, so users who should be contactable must have their personal
  contact form enabled on their profile.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/contact_author -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/contact_author -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en contact_author -y
```

## Verify it worked

After enabling, grant the **Use users' personal contact forms** permission and
place the **Contact author** block (see "How to use it" in the
[overview](../index.md)). Then view a node whose author has an email address and
an enabled personal contact form: the "Contact author" link should appear, and
clicking it should open the author's contact form in an off-canvas dialog.
