# Browser Development — manual setup guide

**Browser Development** (`browser_development`) gives a developer an in‑browser code
editor for writing CSS/SCSS and JavaScript that is compiled and attached to the
current theme. The idea is to iterate on front‑end tweaks straight from the browser
— live‑compiling SCSS and saving the resulting CSS — without setting up a local
build toolchain. It is a development and QA convenience, useful for prototyping and
design review, and it is explicitly **not** something to run on a production site.

Under the hood it ships a home page, an editor page, a settings form, and a POST
`api` endpoint. The editor talks to that endpoint with JSON commands to live‑compile
SCSS, save compiled CSS to disk, and reopen previously saved snippets, which are
stored as a custom configuration entity. Writing compiled CSS to the filesystem and
compiling SCSS on demand is a powerful, developer‑oriented surface — which is why it
belongs on local/QA environments only. It has no dependencies and supports Drupal
10 and 11.

**An important caveat about this release.** All four of the module's routes —
including the home, editor, settings, and the POST `api` that compiles SCSS and
writes CSS to disk — are declared with `_permission: 'TRUE'`. That requires a
permission literally named "TRUE", which no role can ever hold. As shipped, that
means **every route fails closed and is inaccessible to all users**, so the editor
cannot actually be reached without a code change. Treat this as a local development
module, understand that it does not work out of the box in its current form, and do
not deploy it to production regardless.

This guide is written for a **human**. If you want terse, token‑cheap references for
an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, installing with Composer,
   and enabling the module (development environments only).

## Where it lives in the admin menu

The module registers pages under `/admin/browser-development` (a home page, an
editor at `/admin/browser-development/editor`, and a settings form), plus a POST
`api` endpoint. In practice, because every route requires the impossible‑to‑hold
`TRUE` permission, none of these pages are reachable as the module ships.

## How to use it

1. Only consider this on a **local or QA environment**, never production.
2. Install and enable the module (see [Installation](installation/index.md)).
3. Be aware that, as shipped, the editor and API are inaccessible because their
   routes fail closed on a permission no role can hold — using it meaningfully would
   require a code change to the module's route definitions. Given that and its
   filesystem‑writing, SCSS‑compiling surface, keep it well away from production.
