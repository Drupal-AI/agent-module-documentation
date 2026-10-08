# Installation

## Requirements

Real-time SEO needs **Drupal 8, 9, 10 or 11** and the following:

- **Metatag** (`metatag`, `^1.3 || ^2.0`) — Real-time SEO builds on Metatag for the
  actual meta title and description output, and its snippet preview reads the Metatag
  defaults. Metatag in turn requires the **Token** module for the placeholder values
  it uses. If you are not already running Metatag, see its own
  [manual setup guide](../../../../metatag/2.2.x/human-docs/index.md) for how it and
  Token are installed and configured.
- **rtseo.js** (`goalgorilla/rtseo.js`, `^2.0`) — the JavaScript library that performs
  the content analysis in the browser. Composer installs it as a dependency (it belongs
  under the site's `/libraries/rtseo.js` directory).
- Core's **Path**, **Views** and **System** modules, which ship with Drupal. Path lets
  the snippet preview show the real URL alias; these are enabled automatically as
  dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/yoast_seo -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
`metatag`, `token` and `goalgorilla/rtseo.js` dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/yoast_seo -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en yoast_seo -y
```

This also enables `metatag` (and its `token` dependency) plus core's `path` and
`views` modules. Once enabled, the settings screen appears under **Configuration →
Search and metadata → Real-time SEO** (`/admin/config/yoast_seo`).

## Verify it worked

Log in as an administrator and go to `/admin/config/yoast_seo`. You should see the
**Real-time SEO** settings page. If it loads, the module is installed correctly. Next,
review the [configuration](../configuration/index.md) to set the site-wide options and
turn the analysis on for the content types you want.
