# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- **PHP 8.0 or newer** (`php: ^8.0`), and the PHP JSON extension (`ext-json`, standard on
  virtually all PHP builds).
- The [js_cookie](https://www.drupal.org/project/js_cookie) module (`js_cookie`, `^1.0 || ^2.0`)
  — Composer pulls it in automatically. It also uses core's **System** module.
- **A separate cookie consent manager** (for example Klaro, Cookiebot, or any script that sets a
  cookie or fires a DOM event). Cookie Content Blocker does the blocking, but it has no consent
  logic of its own — without a consent manager mapped under *consent awareness*, blocked content
  never reveals.

## Install with Composer

From the project root:

```bash
composer require drupal/cookie_content_blocker -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as needed
(including `js_cookie`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/cookie_content_blocker -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cookie_content_blocker -y
```

## Submodule — enable only if you need it

Cookie Content Blocker ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Cookie Content Blocker Media** | `cookie_content_blocker_media` | A media (oEmbed) formatter that blocks remote media entities per provider, with an optional thumbnail preview behind the consent message. |

Enable it only if you want to block **Media library** oEmbed items (as opposed to embeds pasted
into WYSIWYG text):

```bash
drush en cookie_content_blocker_media -y
```

After enabling, head to [Configuration](../configuration/index.md) to map your consent manager
and set up the filter/button and cookie categories.
