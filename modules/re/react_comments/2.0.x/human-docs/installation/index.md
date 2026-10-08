# Installation

## Requirements

- **Drupal 10.6, 11.3, or 12** (`core_version_requirement: ^10.6 || ^11.3 ||
  ^12`).
- Core's **Comment** module (`comment`) — the commenting system it replaces the
  front end of.
- Core's **REST** module (`rest`) — used to read and post comments. (REST relies
  on core Serialization, which is enabled alongside it.)

The React application is bundled with the module, so there is no separate
JavaScript library to download.

## Install with Composer

From the project root:

```bash
composer require drupal/react_comments:^2.0@beta -W
```

This 2.0.x line is a beta release, hence the `@beta` stability flag. The `-W`
(`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/react_comments:^2.0@beta -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en react_comments -y
```

Core Comment and REST are enabled as dependencies if they are not already on.

## Verify it worked

Open a node that has comments enabled. The comment area should now be the React
application, letting you post and reply inline without a page reload. If comments
do not appear or you cannot post, check that the comment REST resources are
enabled and that your role has the appropriate comment permissions.
