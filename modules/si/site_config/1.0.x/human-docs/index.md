# Site Config — manual setup guide

**Site Config** (`site_config`) provides a centralized way to define, manage, and
expose global site configuration — the kind of site-wide values (a welcome message, a
featured piece of content, feature flags) that don't belong to any single content type.
It is built with decoupled and headless architectures in mind, so the values you manage
can also be read by a JavaScript or mobile front end over an API.

The heart of the module is a plugin type called **SiteConfig**. A developer defines a
plugin — a logical group of fields with types, labels, options, and validation — and the
module automatically generates an administration form for it at `/admin/site-config`. In
other words, you describe the settings you want in code, and Site Config builds the UI,
storage, and (optionally) the API for them. Each group can store its values in either
Drupal *state* or *config*, and can be marked translatable. A `SiteConfigService` lets
other code read and write these values programmatically.

Because the fields are defined by plugins rather than shipped as a fixed form, Site
Config is a developer-oriented building block: on its own it provides the framework and
the admin form; the actual settings appear once you (or a module you install) define
SiteConfig plugins. It depends on core **Language** for its translation support, and
ships two optional submodules — `site_config_jsonapi` and `site_config_rest` — that
expose the stored values over JSON:API and REST for decoupled front ends.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent — including the plugin definition syntax —
read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and choose whether to enable the API submodules.

## Where it lives in the admin menu

Once you have at least one SiteConfig plugin defined, the module exposes an
automatically generated administration page at **`/admin/site-config`**, where each
plugin's fields are rendered as a form and their values saved. With no plugins defined
yet, there is nothing to edit — the form is populated entirely from the SiteConfig
plugins present on your site.

## A note on exposing config over the API

If you enable the JSON:API or REST submodules, your site config becomes **readable over
an API** — JSON:API endpoints at `/jsonapi/site-config` (and `/jsonapi/site-config/item/{id}`)
and REST endpoints at `/api/site-config` (and `/api/site-config/{id}`). Only expose
settings that are safe to be public: keep secrets and admin-only values out of the
groups you publish, and gate the REST resources appropriately for your audience. The
module itself has no access-control role — that decision is yours.
