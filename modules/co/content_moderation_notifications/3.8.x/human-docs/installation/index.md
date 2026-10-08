# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Content Moderation** (`content_moderation`), **Text** (`text`), and
  **Workflows** (`workflows`) modules — all enabled automatically as
  dependencies. You'll also need an actual content‑moderation **workflow** set up
  and applied to some content type, so there are transitions to notify on.
- The **Token** module (`drupal/token`) is optional but recommended — it provides
  the token browser used when composing notification subjects and bodies.
- A working **mail system**, so Drupal can actually send the emails.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/content_moderation_notifications -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. To add the recommended token browser as well:

```bash
composer require drupal/token -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_moderation_notifications -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_moderation_notifications -y
```

Or enable **Content Moderation Notifications** from **Extend**
(`/admin/modules`). Enable **Token** too if you installed it.

## Next steps

Grant the **Administer content moderation notifications** permission to trusted
roles, then create your first notification — see
[Configuration](../configuration/index.md).
