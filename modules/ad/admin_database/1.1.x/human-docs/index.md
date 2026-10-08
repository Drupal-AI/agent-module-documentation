# Admin Database — manual setup guide

**Admin Database** (`admin_database`) embeds the third‑party **Adminer** database
tool directly inside your Drupal back‑office so an administrator can browse tables,
run SQL, and manage the site database without leaving the admin area. Once enabled,
it exposes a single page at `/admin/admin-db` that renders Adminer inside an iframe,
pre‑filling the server, username, and database name from Drupal's own connection so
you land straight on your site's database.

The Drupal page itself is gated behind a dedicated **administer database**
permission (a restricted‑access permission), and on install the module copies a
tokenised Adminer file into its own `assets/` directory. It is meant as a
convenience tool for operations and DBA‑style work — full SQL execution, table
maintenance, and optimisation — for a small number of fully trusted administrators.

> **Important security warning.** The Adminer PHP files this module ships are served
> as ordinary static files from the module's `assets/` directory, which means the
> web server executes them **outside** Drupal's routing and permission system — the
> `administer database` permission does **not** protect them. Published security
> analysis of this version found that these files can be reached directly by anyone
> and can be abused (including a cookie‑controlled file‑include path), so treat
> exposure as critical. Do not run this module on an internet‑facing production site
> unless you have blocked direct web access to the module's `assets/` directory at
> the web‑server level, and only ever grant the permission to people you trust
> completely. The [`agent/`](../agent/start.md) docs and the module's own README
> carry the same strong warning.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Once enabled, the embedded tool is reached at **`/admin/admin-db`**. There is no
field‑by‑field settings form — the page *is* the tool. Access is controlled by the
**administer database** permission at **People → Permissions**
(`/admin/people/permissions`).

## How to use it

1. Grant the **administer database** permission to a fully trusted administrator
   role only.
2. Visit `/admin/admin-db`. Adminer loads inside the page with your site's server,
   username, and database already filled in.
3. Use Adminer to browse tables, run SQL queries, and perform maintenance.

Because the underlying Adminer files sit outside Drupal's access control, review the
security warning above **before** enabling this on any shared or public server. When
you uninstall the module, it deletes the tokenised Adminer file it created on
install.
