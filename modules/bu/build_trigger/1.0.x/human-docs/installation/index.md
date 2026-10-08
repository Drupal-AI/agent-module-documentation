# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other module dependencies and no third-party Composer or PHP libraries.
- For the build-hook workflow: a deploy webhook URL from your host (for example a
  Netlify or Vercel build hook).
- For the GitLab workflow: a GitLab project, its base URL, and a **private
  token** with permission to create pipelines.

## Install with Composer

From the project root:

```bash
composer require drupal/build_trigger -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/build_trigger -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en build_trigger -y
```

For the GitLab CI pipeline workflow, also enable the submodule:

```bash
drush en build_trigger_gitlab_pipeline -y
```

## Set permissions

At **People → Permissions** grant:

- **administer build_environment** — to admins who define build environments.
- **build trigger build** — to editors allowed to trigger and update builds
  (this is what lets them deploy without full site-admin rights).
- **administer build_job** — a restricted permission; keep it to trusted admins.

## Next step

Add your build environments and start triggering builds — see
[Configuration](../configuration/index.md).
