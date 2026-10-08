# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- **PHP 8.1** or newer.
- The **Social API** module (`drupal/social_api ^4`) and core's **Link** module
  (`link`) — both are pulled in as dependencies.
- At least one **Social Post provider module** (for example Social Post Mastodon
  or Social Post X) to actually post anywhere. Social Post on its own has no
  networks to publish to.

## Install with Composer

From the project root:

```bash
composer require drupal/social_post -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, including Social API.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/social_post -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en social_post -y
```

## Verify it worked

Go to **Configuration → Social API → Social Post**
(`/admin/config/social-api/social-post`). You should see the integrations page —
empty until you install a provider module. Next, add a provider (such as
`social_post_mastodon` or `social_post_x`) and configure it, then read the
permission notes in
[Configuration](../configuration/index.md) before granting access to anyone.
