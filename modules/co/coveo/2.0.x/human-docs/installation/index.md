# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A **Coveo** account with an organization/index and API credentials — this module is
  a client for Coveo's hosted platform, so you need somewhere to push content to.
- For the Search API submodule you will use Drupal's **Search API** framework; for
  secured search you will store token/API credentials as secrets (covered in
  [Configuration](configuration/index.md)).

There are no bundled PHP or JavaScript library requirements listed for the module
itself; the Atomic front-end is delivered through the Coveo Atomic submodule.

## Install with Composer

From the project root:

```bash
composer require drupal/coveo -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/coveo -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module first:

```bash
drush en coveo -y
```

## Submodules — enable only what you need

Coveo ships three optional submodules. Enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Coveo Search API** | `coveo_search_api` | A Search API backend that pushes your content (and, optionally, user identities) to a Coveo organization/index. Enable this to get content *into* Coveo. |
| **Coveo Atomic** | `coveo_atomic` | Development tools and a block for building search experiences with Coveo's Atomic web-component UI. Enable this to render Coveo search *on your site*. |
| **Coveo Secured Search** | `coveo_secured_search` | A security-provider integration that issues search tokens so access-restricted content isn't exposed. Enable this whenever any indexed content is not public. |

For example, to index content and render an Atomic search experience:

```bash
drush en coveo_search_api coveo_atomic -y
```

Each submodule requires the base Coveo module, which is already present once you have
installed it above.

## Verify it worked

1. Confirm the modules appear at **Extend** (`/admin/modules`).
2. Continue to [Configuration](configuration/index.md) to connect your Coveo
   organization, store the API credentials as secrets, and index content. Nothing
   will reach Coveo until those credentials are in place.
