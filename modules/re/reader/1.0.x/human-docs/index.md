# Reader — manual setup guide

**Reader** (`reader`) turns your Drupal site into a personal, app-like reading
experience that visitors can **install as a Progressive Web App (PWA)** on a phone
or tablet and read offline. The project has two parts: the `reader` **module**,
which exposes an API for getting channels, streams, and so on (its main entry
point is at `/reader`), and a `reader_theme` **submodule**, the theme that
displays the content and enables installing the reader on a device's home screen.

Reader consumes content that follows your site's normal content access — it is a
front-end / user-engagement feature and does not grant any access of its own
beyond the permission it provides. It is designed to work with modules that
implement its API, such as
[ActivityPub](https://www.drupal.org/project/activitypub) and the
[IndieWeb Microsub](https://www.drupal.org/project/indieweb) endpoint, and it can
stand in for Aggregator-style feeds.

> **Heads up about a front-end library.** The reader theme uses the *Infinite
> Scroll* library to load the next page automatically, and by default it loads
> that library from a CDN (`unpkg.com`). If you would rather serve it locally (to
> avoid the external request), the module provides a Drush command to download it
> into your `libraries` folder: `drush reader:is`.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its theme.

The module's configuration lives at **Configuration → Web services → Reader**
(`/admin/config/services/reader`); the setup essentials are covered under "How to
use it" below, and the project's `README` documents the full feature set.

## Where it lives in the admin menu

Reader's settings are at **Configuration → Web services → Reader**
(`/admin/config/services/reader`), and the reading interface itself is served at
**`/reader`**. The `reader_theme` submodule provides the display and the PWA
install capability.

## How to use it

1. Enable the **reader** module and the **reader_theme** submodule (see
   [Installation](installation/index.md)).
2. Configure the reader at `/admin/config/services/reader`, and grant the reader
   permission to the roles that should use it.
3. Optionally run `drush reader:is` to serve the Infinite Scroll library locally
   instead of from the CDN.
4. Pair Reader with a module that implements its API (for example ActivityPub or
   the internal IndieWeb Microsub endpoint) so there is content to read.
5. Visit `/reader`; on a mobile device you can then add the reader to your home
   screen and read offline.
