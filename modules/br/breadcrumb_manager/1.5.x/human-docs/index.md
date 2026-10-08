# Breadcrumb Manager — manual setup guide

**Breadcrumb Manager** (`breadcrumb_manager`) replaces Drupal's default breadcrumb
builder with a **path‑based** one. Instead of configuring breadcrumbs per content
type, it builds the breadcrumb automatically from the current URL: it walks the
parent segments of the path, matches each to a route, checks that the user is
allowed to see it, and works out a sensible title for every segment. The result is
consistent, autonomous breadcrumbs across your whole site based on your URL
structure.

The clever part is how it names each segment. Each path segment's title is resolved
through a **weighted chain of "title resolver" plugins**, and the first one that
returns a title wins. Out of the box three resolvers ship: one takes the title from
a **menu link** on that route, one takes the **page (route) title**, and one falls
back to a **humanized version of the raw path** (used for "fake" segments that have
no route of their own). You can turn resolvers on and off and reorder them from the
settings form, and developers can add their own resolver plugin.

A single settings form controls the rest: which paths to exclude (wildcards
allowed), whether to show the breadcrumb on the front page, whether to show and
relabel a "Home" link, whether to show the current page (as a link or plain text),
and whether to include route‑less "fake" segments. Two alter hooks let modules
rewrite the path or give fake segments meaningful labels and links.

An optional **Breadcrumb Manager Context** (`breadcrumb_manager_context`) submodule
adds a resolver that pulls segment titles from the **Context** module. Breadcrumb
Manager works on Drupal 8 through 11 and has no third‑party dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and optionally add the Context submodule.
2. [Configuration](configuration/index.md) — the settings form, field by field,
   including the title‑resolver priority table.

## Where it lives in the admin menu

Once enabled, Breadcrumb Manager takes over breadcrumb building site‑wide
immediately. Its settings form sits at **Configuration → User interface →
Breadcrumb Manager** (`/admin/config/user-interface/breadcrumb-manager`) and is
gated by the **Administer Breadcrumb Manager** permission.

## How to use it

For most sites, enabling the module is enough — you immediately get path‑based
breadcrumbs. From there, open the settings form to fine‑tune the "Home" link, decide
whether the current page is shown, exclude paths you do not want breadcrumbs on, and
reorder the title resolvers if you prefer, say, page titles over menu link titles.
See [Configuration](configuration/index.md) for the details.
