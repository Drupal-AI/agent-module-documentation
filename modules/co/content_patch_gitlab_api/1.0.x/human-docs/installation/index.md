# Installation

## Requirements

- **Drupal 10.5+ or 11.2+** (`core_version_requirement: ^10.5 || ^11.2`).
- Core's **Serialization** module (`serialization`) — enabled automatically as a
  dependency.
- A **GitLab repository** you can push to, and a **GitLab access token** with
  permission to create branches and merge requests in it. You supply these during
  [Configuration](../configuration/index.md).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/content_patch_gitlab_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_patch_gitlab_api -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_patch_gitlab_api -y
```

## Verify it worked

After enabling, open the module's settings page (see
[Configuration](../configuration/index.md)) and confirm you can enter a GitLab
URL, project ID, and export path (the token goes in `settings.php`, not on this
form). Then, on **Content** (`/admin/content`),
check that an **Export to GitLab** option appears in a content row's operations
dropdown. Once both are present, continue to
[Configuration](../configuration/index.md) to connect GitLab and store your token
securely.
