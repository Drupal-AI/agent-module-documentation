# REST Menu Tree — manual setup guide

**Menu Tree** (`rest_menu_tree`), often called REST Menu Tree, exposes a single
REST endpoint that returns an entire menu's link tree — nested subtrees and all —
in one request. That's exactly what a decoupled or headless front‑end needs to
build its navigation: instead of walking menu links one at a time, a React, Vue,
Next.js, or mobile app can fetch the whole `main` (or `footer`, or any custom)
menu as nested JSON in a single call, already filtered by the requesting user's
access and correctly cached.

Under the hood it registers one core REST resource, `menu_tree`, at
`/entity/menu/{menu}/tree`. A GET loads the full menu link tree, sorts it, drops
any links the current user can't view, and serializes the nested structure through
the required **Menu Normalizer** module. The response carries proper cacheability
metadata, so it render‑caches while still varying correctly per user. It's a
lighter‑weight alternative to traversing menus through JSON:API.

Because it plugs straight into Drupal core's REST system, the module has **no
settings UI, no permission, and no configuration schema of its own** — access,
formats, and authentication are all governed by core REST. The one thing to know
is that the resource is **not enabled by default**: after installing the module
you must switch the `menu_tree` REST resource on and grant a permission. This
guide covers that here rather than in a separate configuration page.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside REST and Menu Normalizer.

## Where it lives in the admin menu

There's no page of its own. You enable and configure the resource through the REST
system at **Configuration → Web services → REST** (most easily with the REST UI
module), and grant its permission on **People → Permissions**.

## How to use it

### 1. Enable the REST resource

After enabling the module, the `menu_tree` resource is registered but disabled.
Turn it on one of two ways:

- **With REST UI** (`drupal/restui`, recommended): go to **Configuration → Web
  services → REST**, enable **Menu Tree**, and choose the methods (`GET`), formats
  (`json`, `hal_json`, `xml`), and authentication (cookie, basic auth, OAuth) you
  want.
- **In configuration**: add a `menu_tree` entry under the `resources:` section of
  `rest.settings` with the same method/format/auth structure core REST expects.

### 2. Grant access

Reading the endpoint requires the core‑generated permission **`restful get
menu_tree`**. On **People → Permissions**, grant it to the roles that may read
menus — often `anonymous` and/or `authenticated`, or a dedicated API role. Access
is governed entirely by core REST plus this permission; the module adds none of
its own.

### 3. Call it

```
GET /entity/menu/{menu}/tree?_format=json
```

Replace `{menu}` with a menu's machine name (`main`, `footer`, `admin`, or a
custom menu), send whatever `Authorization` header or cookie your chosen
authentication requires, and use an `Accept`/`_format` matching an enabled format.
You'll get back a nested array of menu link items, each with its link data and a
`subtree`.

> **Security note.** The endpoint only exposes menu **link** data, and every link
> is filtered by the requesting user's core view access — it does not bypass access
> control. Granting `restful get menu_tree` to anonymous simply publishes your menu
> structure, which is normal for a decoupled site.
