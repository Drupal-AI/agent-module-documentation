# Installation

## Requirements

Tarte au citron Media Remote Videos needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- Core's **Media** module (`media`) — which provides the remote video (oEmbed)
  media type this module gates.
- The **Tarte au citron** module (`tarte_au_citron`) — the consent manager it
  plugs into.

Composer resolves these dependencies for you. There are no third-party Composer or
PHP library requirements, and the module is covered by Drupal's security advisory
policy.

## Install with Composer

From the project root:

```bash
composer require drupal/tarte_au_citron_media_remote_video -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Media and Tarte au
citron as needed. (The Composer package name,
`drupal/tarte_au_citron_media_remote_video`, matches the module's machine name,
`tarte_au_citron_media_remote_video`.)

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tarte_au_citron_media_remote_video -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tarte_au_citron_media_remote_video -y
```

Once enabled, the module works immediately — core-media remote video embeds are
held back until the visitor grants consent through Tarte au citron. There is
nothing to configure on this module itself; manage the video service's appearance
from the parent Tarte au citron services configuration.

## Verify it worked

Load a page with a core-media remote video (a YouTube or Vimeo embed) as an
anonymous visitor. Before you accept the relevant service in the Tarte au citron
consent banner, the video should not load or contact the provider; after you
accept, the embed should appear.
