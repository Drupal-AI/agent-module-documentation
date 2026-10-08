# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- No dependent modules and no third-party PHP library requirements — it relies only
  on Drupal core's field system.

## Install with Composer

From the project root:

```bash
composer require drupal/smart_read_more_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Pin a tagged release.** In some environments Composer resolves this project to
> the `2.0.x-dev` branch (a git clone) rather than a packaged release, which leaves
> a `.git` directory in the module folder and no `version:` line in its info file.
> To avoid that, require a specific tag, for example:
>
> ```bash
> composer require drupal/smart_read_more_link:^2.0
> ```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/smart_read_more_link -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en smart_read_more_link -y
```

## Verify it worked

Open the **Manage display** tab of a content type that has a long-text/body field
and confirm the Smart Read More Link formatter appears in the field's **Format**
dropdown. Select it, save, and check a listing: the "Read more" link should appear
only on items whose body is longer than the teaser.
