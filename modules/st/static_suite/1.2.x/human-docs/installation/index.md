# Installation

## Requirements

Static Suite needs:

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- Core's **Locale** (`locale`) module, which Drupal enables as a dependency.
- On the server: shell access plus the tooling your pipeline uses — for example
  Node.js and your chosen SSG (Gatsby, Next.js, Eleventy, Hugo, Astro) for the
  build step, `git` if you use the Git-backed export stream wrapper, and
  credentials/CLI for your deployer (for example the AWS CLI for S3). The build and
  deploy steps run real shell processes from Drupal.

There are no third-party Composer or PHP library requirements in the base package.

## Install with Composer

From the project root:

```bash
composer require drupal/static_suite -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/static_suite -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the submodules you need

Static Suite is a set of layered submodules. For a basic working setup, the
module's own documentation recommends enabling the export layer with a GraphQL
resolver, the JSON output formatter, and the local stream wrapper:

```bash
drush en static_suite static_export static_export_data_resolver_graphql static_export_output_formatter_json static_export_stream_wrapper_local -y
```

Then add the higher layers as your pipeline grows:

| Submodule | What it adds |
|-----------|--------------|
| `static_export` | Exports Drupal data (entities, config, locale) to JSON/XML/YAML files via pluggable resolvers, re-exporting on content change. |
| `static_build` | Runs your chosen SSG (Gatsby, Next.js, Eleventy, Hugo, Astro) as a background build process. |
| `static_deploy` | Deploys a built release to a host or CDN (for example S3 via `static_deployer_s3`). |
| `static_preview` | Previews content without a full rebuild. |
| `static_preview_gatsby_instant` | Adds instant per-page Gatsby preview. |

## Verify it worked

Visit **Configuration → Static** (`/admin/config/static`) as a user with
*Administer site configuration*. You should see the Static Suite configuration.
Continue with [Configuration](../configuration/index.md) to set up the export,
build, and deploy layers.
