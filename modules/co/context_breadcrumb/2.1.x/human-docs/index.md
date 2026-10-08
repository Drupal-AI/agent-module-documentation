# Context Breadcrumb — manual setup guide

**Context Breadcrumb** (`context_breadcrumb`) lets you define custom, dynamic
breadcrumb trails through the [Context](https://www.drupal.org/project/context)
module — without writing a custom breadcrumb builder. You add a **Breadcrumb**
reaction to a context, list the breadcrumb rows (each a title and a URL, with
full **token** support), and Context Breadcrumb applies that trail wherever the
context's conditions match. Because it builds on Context, you can target
breadcrumbs precisely by path, role, taxonomy vocabulary, and any other Context
condition.

The module also helps with SEO: an optional setting emits your breadcrumbs as
Schema.org `BreadcrumbList` **JSON‑LD** structured data (automatically skipped on
admin pages), so search engines can show breadcrumb rich results. Tokens let
titles and URLs be dynamic — for example `[node:title]`, `[term:name]`, or the
module's special `[term_hierarchy]` token that builds a trail from a taxonomy
term's ancestors.

Context Breadcrumb requires the **Context** module (version 4 or 5), which
Composer installs for you, and the **Token** and **Ctools** modules are
recommended for the best experience. It provides one permission and a small
settings form, has no submodules, and works on Drupal 10 and 11. Note that its
breadcrumb builder runs at very high priority, so it overrides Drupal's default
breadcrumbs (and most other breadcrumb modules) wherever a context applies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the reaction,
condition, and provider plugins and the JSON‑LD services — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, and how to
   define breadcrumbs on a Context.

## Where it lives in the admin menu

The module's own settings form is at **Configuration → User interface → Context
Breadcrumb** (`/admin/config/user-interface/context-breadcrumb`), gated by the
**Administer context breadcrumb** permission. The actual breadcrumb trails,
though, are defined on your contexts under **Structure → Context**
(`/admin/structure/context`).

## How to use it

Enable the module, then add a **Breadcrumb** reaction to a context and enter your
breadcrumb rows there; the context's conditions decide where the trail applies.
If you want the SEO structured data, turn on the JSON‑LD toggle on the settings
form. The [Configuration](configuration/index.md) page walks through both.
