# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **File** module (part of the standard install).
- **S3 File System** (`drupal/s3fs`, `^3.0`) — the base module this one extends. It
  must be installed **and already configured** with a working bucket, region, and
  credentials; this module reuses all of that.
- **Token** (`drupal/token`, `^1.0`).

Composer pulls in S3 File System and Token automatically, and Drupal enables them
(and File) as dependencies.

You'll also need an **AWS S3 bucket** and credentials with permission to configure
the bucket's CORS rules and to write objects (or an IAM role / STS federation setup).

## Install with Composer

From the project root:

```bash
composer require drupal/s3fs_cors -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer resolve the S3 File System
and Token dependencies and update any shared packages.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/s3fs_cors -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en s3fs_cors -y
```

Drupal enables **S3 File System**, **Token**, and **File** at the same time as
dependencies.

## Before you configure

Make sure S3 File System itself is working — that you can store and serve files on S3
through the normal `s3fs` stream wrapper — before setting up direct uploads. This
module only adds the CORS/direct‑upload layer on top; it does not configure your
bucket credentials. Then continue to [Configuration](../configuration/index.md).

There are no submodules. The module defines two permissions, **administer s3fs CORS**
and **generate s3fs CORS upload parameters**, which you'll find under
**People → Permissions**.
