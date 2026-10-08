# JSON:API Menu — manual setup guide

**JSON:API Menu** (`jsonapi_menu`) adds a JSON:API resource that exposes a menu
and its items — including nested items — over JSON:API, so a decoupled front end
can fetch the site's navigation menus directly. Core JSON:API does not expose menus
this way out of the box; this module fills that gap with a single, predictable
endpoint: `/jsonapi/jsonapi_menu/{menu}`.

It supports both user-created and system-created menu items, works with the
`menu_link_content` entity, and integrates with the
[Menu Item Extras](https://www.drupal.org/project/menu_item_extras) module for
menus that carry extra fields. It depends on core's Menu Link Content module and on
the [JSON:API Resources](https://www.drupal.org/project/jsonapi_resources) module.

There is nothing to configure in the admin UI — enable the module and call the
endpoint. One thing to keep in mind: this endpoint reveals the **menu tree**,
including any links to admin or less-discoverable paths that happen to be in a menu
you expose. Menus are usually public navigation, but the module has no
access-control role of its own, so don't place sensitive URLs in exposed menus and
rely on each linked route's own access for real protection.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

There is **no configuration page** for this module.

## Where it lives in the admin menu

JSON:API Menu adds no admin page. You manage menus themselves at **Structure →
Menus** as usual; this module simply exposes them over JSON:API.

## How to use it

Fetch a menu and its items by menu machine name:

```
GET /jsonapi/jsonapi_menu/main
```

The response returns the menu together with its (nested) items. Use the menu's
machine name (for example `main`, `footer`, or `admin`) in place of `{menu}`.
