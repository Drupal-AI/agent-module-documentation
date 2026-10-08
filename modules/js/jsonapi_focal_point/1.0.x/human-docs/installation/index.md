# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Focal Point**
  ([`focal_point`](https://www.drupal.org/project/focal_point)) module — supplies
  the focus data being exposed.
- The **JSON:API Extras**
  ([`jsonapi_extras`](https://www.drupal.org/project/jsonapi_extras)) module —
  the resource-shaping layer this extension builds on. (JSON:API Extras itself
  requires core JSON:API.)

Composer installs the contributed dependencies for you.

> **Not covered by the security advisory policy.** This project isn't tracked
> through Drupal's official security process — worth weighing before using it on
> a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_focal_point -W
```

The `-W` (`--with-all-dependencies`) flag pulls in Focal Point, JSON:API Extras,
and any other shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonapi_focal_point -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_focal_point -y
```

This also enables Focal Point, JSON:API Extras, and core JSON:API if they aren't
already on.

## Verify it worked

With Focal Point configured and a focus point set on an image, request the
relevant image resource through JSON:API and confirm the response now carries the
focal-point data. Manage exactly how the resource is shaped through **JSON:API
Extras** (**Configuration → Web services → JSON:API Overwrites**).
