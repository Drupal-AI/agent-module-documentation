# REST menu items — manual setup guide

**REST menu items** (`rest_menu_items`) exposes a Drupal menu over a REST endpoint,
so a decoupled ("headless") front end can render your site navigation from the menu
name alone. Ask for `/api/menu_items/main` and you get the main menu's links back as
nested JSON (or XML), ready for a React, Vue, Next, mobile app, or static‑site
generator to turn into a navigation bar or drawer.

The endpoint is `/api/menu_items/{menu_name}`, where `{menu_name}` is a menu's
machine name such as `main`, `footer`, or `account`. Children are nested under a
`below` key so the tree structure is preserved. You can trim the response with
`min_depth` and `max_depth` query parameters, and choose the response format with
the required `_format` parameter (`json`, `hal_json`, or `xml`). Custom fields you
have added to menu link entities — an icon image, an entity reference — are included
automatically.

Because it is built on Drupal's core REST system, the resource has to be **enabled**
and a **permission granted** before it responds — that is the one step people most
often miss. A small settings form then lets you control which menus may be exposed,
which fields each item carries, and how absolute URLs are built for a front end that
lives on a different domain.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

The module's own settings form is at **Configuration → Web services → REST menu
items** (`/admin/config/services/rest_menu_items`). You enable the REST resource
itself under **Configuration → Web services → REST** (easiest with the REST UI
module), and grant the access permission at **People → Permissions**.

## How to use it

### 1. Enable the REST resource

The module ships the resource but, like any core REST resource, it does not respond
until you enable it:

- The easiest way is to install the **REST UI** module (`drupal/restui`), go to
  **Configuration → Web services → REST** (`/admin/config/services/rest`), and enable
  **"Menu items per menu"**, choosing the formats and authentication you want.
- Alternatively, enable it through configuration.

### 2. Grant the permission

At **People → Permissions**, grant **`restful get rest_menu_item`** to the roles
that should read the endpoint (often the anonymous role, for a public front end).

### 3. Tune the settings

Open **Configuration → Web services → REST menu items**
(`/admin/config/services/rest_menu_items`), which requires the **Administer REST menu
items** permission. The options:

- **Output values** — tick which fields each menu item should carry (title, uri,
  alias, weight, enabled, options, and more). Untick fields you do not need to keep
  the response lean.
- **Allowed menus** — restrict which menus may be requested over REST. Leave it empty
  to allow all menus; tick specific menus to expose only those. A menu that is
  listed but not allowed returns a **403** — a good way to make sure the admin menu
  is never exposed.
- **Base URL** — override the domain used when building absolute URLs, which is handy
  when your front end lives on a different domain from Drupal. Leave it empty to use
  the site's own base URL.
- **Add fragment** — when enabled, appends anchor fragments (`#section`) from a link's
  options to the URL output.

### 4. Request the menu

With the resource enabled and permission granted, fetch a menu:

```
/api/menu_items/main?_format=json
/api/menu_items/footer?_format=xml&max_depth=1
/api/menu_items/account?_format=hal_json&min_depth=2
```

Remember that `_format` is **required** — a request without it returns a 406.
Responses are cached with proper cache tags (so they refresh automatically when a
menu changes) and vary by permission.
