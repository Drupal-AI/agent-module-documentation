# Installation

## Requirements

- **Drupal 10.1, 11, or 12** (`core_version_requirement: ^10.1 || ^11 || ^12`).
- Core's **Editor** (`editor`) and **Filter** (`filter`) modules — part of a standard
  install.
- The contrib **Embed** module (`drupal/embed`, `^1.4`), which supplies the
  `<drupal-url>` tag convention and the embed-button framework this builds on.
  Composer pulls it in for you.
- The **`embed/embed`** PHP library (`oscarotero/embed`, `^4.4`) — the module checks
  for this at install time and **will not enable** without it. Composer installs it
  when you require the module.

## Install with Composer

From the project root:

```bash
composer require drupal/url_embed -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed and ensures the Embed module and the `embed/embed` library are
installed alongside it.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/url_embed -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en url_embed -y
```

Core's Editor, Filter, and the contrib Embed module are enabled automatically as
dependencies. Enabling the module also installs a "URL" embed button/type so that
"URL" is available in the Embed module's UI.

## Grant the permission

The settings form is gated by the **Administer URL Embed** permission
(`administer url_embed`). Grant it at **People → Permissions**
(`/admin/people/permissions`) to the role(s) that should be able to change the
Facebook/Instagram credentials.

## Next: configure it

Installing the module does not embed anything on its own — you enable its filters on a
text format (and optionally add the CKEditor 5 toolbar button). Follow the
[Configuration](../configuration/index.md) guide to switch it on.

## Verify it worked

Visit **Configuration → Media → URL Embed** (`/admin/config/media/url_embed`) — the
settings form should load. Then enable the filters on a text format and paste a
YouTube URL into a field that uses that format; on save it should render as an embedded
player.
