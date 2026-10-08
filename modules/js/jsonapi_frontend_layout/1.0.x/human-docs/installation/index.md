# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- The **JSON:API Frontend**
  ([`jsonapi_frontend`](https://www.drupal.org/project/jsonapi_frontend)) module —
  this add-on extends it and reuses its resolver, negotiation, and access checks.
- Core's **Layout Builder** (`layout_builder`) and **Block Content**
  (`block_content`) modules — the layout data and inline blocks it exposes.

Composer installs the contributed dependency for you; the core modules are enabled
as dependencies.

> **Not covered by the security advisory policy.** This project isn't tracked
> through Drupal's official security process — worth weighing before using it on
> a production site.

## Install with Composer

From the project root:

```bash
composer require drupal/jsonapi_frontend_layout -W
```

The `-W` (`--with-all-dependencies`) flag pulls in JSON:API Frontend and any other
shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jsonapi_frontend_layout -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jsonapi_frontend_layout -y
```

This also enables JSON:API Frontend, Layout Builder, and Block Content if they
aren't already on. Remember to set JSON:API Frontend's routes-feed secret as part
of setting up that base module.

## Enable Layout Builder for the bundles you want exposed

The layout endpoint only returns a layout tree for pages that actually use Layout
Builder. For each bundle you want to render headlessly, go to its **Manage
display** (for example **Structure → Content types → *(type)* → Manage display**)
and turn on **Use Layout Builder**, then build the layout.

## Verify it worked

Request `GET /jsonapi/layout/resolve?path=/your-page&_format=json` for a page whose
bundle has Layout Builder enabled. The response should include the normalized
layout tree (sections and components) alongside the usual resolver output. For a
page without Layout Builder, you get the normal resolver contract without a layout
tree, which is expected.
