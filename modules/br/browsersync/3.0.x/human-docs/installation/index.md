# Installation

## Requirements

Browsersync (the Drupal module) needs:

- **Drupal 10.1+ or 11** (`core_version_requirement: ^10.1 || ^11`).

It depends on no other Drupal modules and has no third-party Composer or PHP
library requirements.

**Separately**, you need the actual **Browsersync server** (the Node.js tool),
which this module does *not* install. Install it yourself in your development
environment, for example:

```bash
npm install -g browser-sync
```

or wire it into a Gulp/Grunt task. The Drupal module only injects the client
script that talks to that server.

## Install with Composer

From the project root:

```bash
composer require drupal/browsersync -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/browsersync -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix. This is a
> development-only module, so it's fine to require it as a dev dependency.

## Enable the module

```bash
drush en browsersync -y
```

## After enabling

1. Grant **Use browsersync** at **People → Permissions** to your developer role
   (and yourself) — the client script is injected only for users who hold it, so
   anonymous visitors never get it.
2. Go to **Appearance → Settings → (your theme)**, open **Browsersync settings**,
   and tick **Enable Browsersync** (optionally set Host/Port). See the
   [overview](../index.md) for details.
3. Start the Browsersync server yourself and begin editing your theme.

This module is intended for local development only; do not enable it in
production.
