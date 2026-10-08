# Installation

## Requirements

Feeds 3.2.x needs:

- **Drupal 10.2+ or 11** (`core_version_requirement: ^10.2 || ^11`).
- **PHP 8.0** or newer.
- The **laminas/laminas-feed** library (`^2.22`), which Composer pulls in
  automatically. This is the reader Feeds uses to parse RSS/Atom syndication
  feeds.
- Core's **Options** module (`options`), enabled automatically as a dependency.

## Install with Composer

From the project root:

```bash
composer require drupal/feeds -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the
`laminas/laminas-feed` library and update any dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/feeds -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en feeds -y
```

This also enables core's `options` module. Once enabled, the feed-type screens
appear under **Structure → Feed types** (`/admin/structure/feeds`).

## Optional companion modules

Feeds covers CSV, RSS/Atom, OPML, and XML sitemaps out of the box. Two popular
companion projects extend it further — install them only if you need what they
add:

- **Feeds Extensible Parsers** (`drupal/feeds_ex`) — adds JSON and XML parsing
  with XPath / JMESPath expressions, so you can import from JSON or arbitrary XML
  APIs.
- **Feeds Tamper** (`drupal/feeds_tamper`) — lets you modify and transform source
  values (trim, rewrite, split, convert) before they are mapped onto fields.

```bash
composer require drupal/feeds_ex drupal/feeds_tamper -W
drush en feeds_ex feeds_tamper -y
```

Feeds also ships a **Feeds Log** submodule (`feeds_log`) that records detailed
per-item import reports for debugging. Enable it the same way when you need it:

```bash
drush en feeds_log -y
```

## Verify it worked

Log in as an administrator and go to **Structure → Feed types**
(`/admin/structure/feeds`). You should see the **Feed types** page with an
**+ Add feed type** button:

![The Feed types page after installation](../images/types.png)

If the page loads and the **+ Add feed type** button is present, the module is
installed correctly. Next, read the [configuration](../configuration/index.md)
overview and then [create your first feed type](../creating-a-feed-type/index.md).
