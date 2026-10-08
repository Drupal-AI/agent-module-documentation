# SmugMug API — manual setup guide

**SmugMug API** (`smugmug_api`) is a base integration that gives Drupal
programmatic access to the **SmugMug** photo‑hosting API. It doesn't add a
visible feature on its own — instead it provides a set of Drupal **services** that
other code (custom modules, or modules built on top of it) can use to fetch
albums, users, images, and nodes from SmugMug, for example to display or import
photos into your site. Think of it as the connector layer, not a ready‑made
gallery.

The services it exposes are: an **API Client** service (`Drupal\smugmug_api\Service\Client`)
that is the core connector and uses Guzzle to make the API calls, plus **Album**,
**User**, **Image**, and **Node** services that wrap specific groups of SmugMug
endpoints. It has no other module dependencies and lives in the *Media* package.

Configuration is simple: register an application with SmugMug to obtain an API key
and secret, then enter those on the module's settings page. On the security side,
those credentials authenticate you to SmugMug, so **store them as secrets** — keep
them out of exported configuration and version control — and the API is accessed
over HTTPS. Photos and albums fetched from SmugMug are external content. The module
has no access‑control role of its own.

This guide is written for a **human** setting the connection up through the admin
UI. If you want terse, token‑cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — register your SmugMug application and
   enter the API key and secret.

## Where it lives in the admin menu

The settings form is at **`/admin/config/media/smugmug_api`** (config route
`smugmug_api.settings`).

## How to use it

Once your API key and secret are saved, the module's services are ready for other
code to use. For instance, custom code can call the Album, User, Image, or Node
service to pull data from SmugMug and render or import it. Because this is a base
API integration, you (or a module built on it) provide the actual display or
import logic; SmugMug API just handles the authenticated connection and endpoint
calls.
