# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Several **third-party PHP libraries** for the protocol implementations,
  installed with Composer (see below). Which ones you strictly need depends on
  the submodules you enable, but installing them all up front is simplest.
- This `8.x-1.x` branch is for a **single-user site**. If you need multiple users
  publishing from one site, look at the `8.x-2.x` branch instead.

## Install with Composer

From the project root, require the module:

```bash
composer require drupal/indieweb -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

The module relies on a set of IndieWeb PHP libraries. Depending on your Composer
setup these come in as dependencies, but if any are missing you can add them
explicitly:

```bash
composer require indieweb/mention-client indieauth/client p3k/xray p3k/websub p3k/micropub lcobucci/jwt
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/indieweb -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module and the submodules you need

Enable the base module first, then add only the submodules that match the
features you want:

```bash
drush en indieweb -y
```

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| IndieAuth | `indieweb_indieauth` | Authentication/token endpoints; log in and create accounts with IndieAuth (internal or external). |
| Webmention | `indieweb_webmention` | Send and receive webmentions and pingbacks; store syndications; optionally create comments from replies. |
| Micropub | `indieweb_micropub` | A Micropub endpoint so external apps can create posts on your site. |
| Microsub | `indieweb_microsub` | A Microsub reader/subscription server (internal or external). |
| WebSub | `indieweb_websub` | WebSub (PuSH 0.4) publishing and subscribing. |
| Microformats | `indieweb_microformat` | Applies Microformats2 markup to your output. |
| Feed | `indieweb_feed` | Microformats2, Atom, and JF2 feeds. |
| Contact | `indieweb_contact` | Stores contacts for Micropub contact queries and mentions. |
| Context | `indieweb_context` | Fetches and stores post context for content and reader items. |
| Cache | `indieweb_cache` | Caches remote images locally for the internal endpoints. |

For example, to run a site that receives webmentions and accepts Micropub posts
authenticated with IndieAuth:

```bash
drush en indieweb_indieauth indieweb_webmention indieweb_micropub -y
```

## Verify it worked

Log in as an administrator and open the **IndieWeb dashboard** under
**Configuration → Web services → IndieWeb**. Each submodule you enabled should
appear as its own section there, ready to configure — see
[Configuration](../configuration/index.md). Remember to serve the site over
**HTTPS** before exposing any of the authentication or Micropub endpoints.
