# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Single Directory Component** module (`sdc`) — Drupal enables it as a
  dependency.
- The **CommonMark** Markdown library, installed by Composer as a dependency.

## Install with Composer

Because DAB is a development tool that should not run in production, install it as
a **dev** dependency:

```bash
composer require --dev drupal/dab:^1.x
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require --dev drupal/dab:^1.x`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dab -y
```

Enable it in your local and development environments — the maintainers advise
against running it in production.

## Verify it worked

Log in as a developer with the DAB permissions and confirm the component list /
preview area appears in the admin interface. From there you can browse and preview
your Single Directory Components. Assign `access dab components` to developers who
should view the library, and keep the `administer dab …` permissions restricted to
trusted developers.
