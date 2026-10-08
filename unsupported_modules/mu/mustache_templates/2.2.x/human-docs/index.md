# Mustache Logic-less Templates — manual setup guide

**Mustache Logic-less Templates** (`mustache_templates`) brings the **Mustache**
templating language to Drupal, integrating both Mustache.php (server side) and
Mustache.js (client side). Its central pieces are a **text‑format filter** that
renders Mustache syntax and Drupal tokens inside filtered text, a **render
element**, a token‑aware rendering engine, and a **"Magic" plugin system** for
reusable `{{...}}` helpers. It bundles the Mustache libraries, so it has no
contributed dependencies.

Because Mustache is **logic‑less** — there is no arbitrary PHP evaluation — it
gives non‑developers a safe way to interpolate tokens and use simple
presentational sections without writing a custom Twig template. You can render
snippets like `{{site.name}}` or `{{node.title}}` inside content, share the same
template between the browser and the server, and extend the vocabulary with Magic
plugins (conditionals, filters, translation, introspection, attaching JS/CSS
libraries, messages, and more).

Three optional submodules extend the base: **Mustache Token**
(`mustache_token`) decorates the token system, **Mustache Views**
(`mustache_views`) exposes a Views style/integration, and **Mustache Magic**
(`mustache_magic`) adds a server endpoint at `/m/sync` that re‑renders a stored
template by an unguessable, salted `sha3‑512` hash key and runs entity **view**
access checks before rendering — so it behaves as a capability token, not an open
renderer. A single permission, **view mustache debug messages**, controls whether
debug `{{show.*}}` output is displayed.

> **Note on support:** this project is marked **Unsupported / no further
> development** and targets Drupal 9–10 (`^9 || ^10`). Weigh that before adopting
> it on a new or long‑lived site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and choose the submodules you need.

There is **no dedicated settings form** for this module. You "configure" it by
enabling the **Mustache filter** on a text format and granting the debug
permission, described in "How to use it" below.

## How to use it

The module works through Drupal's **text formats**, so the key step is turning on
its filter for the right format:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and edit a format used only by **trusted**
   roles.
2. Enable the **Mustache** filter for that format and save. As with any powerful
   filter, assign it only to formats that trusted users can write in — a
   malicious author could otherwise disclose tokenized data within their own
   access. Mustache being logic‑less limits the risk to token/data disclosure, not
   code execution.
3. Author content in that format using Mustache syntax and tokens (for example
   `{{site.name}}`, `{{node.title}}`, and section/conditional blocks).
4. If you want the debug `{{show.*}}` output to render, grant **view mustache
   debug messages** at **People → Permissions** to the appropriate roles.

To go further, enable the submodules: **Mustache Token** for richer token
handling, **Mustache Views** to template Views output, and **Mustache Magic** for
reusable `{{...}}` helpers and the `/m/sync` client‑sync endpoint.
