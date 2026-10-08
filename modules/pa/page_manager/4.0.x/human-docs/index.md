# Page Manager — manual setup guide

**Page Manager** (`page_manager`) lets you create custom pages at any path and
control exactly what renders there through selectable "variants" — arrangements of
blocks, a Layout Builder layout, a Panels layout, or even a bare HTTP status code.
It can also *take over* existing core routes, so you can replace the default
`/node/{node}` or `/user/{user}` page with your own design. Once part of the CTools
suite, it is now its own project and is a long-standing tool for building
structured, condition-driven pages.

Each page you create is a configuration entity with a path (which can include typed
parameters such as `{node}`), optional access conditions, and one or more
*variants*. When the page is requested, Page Manager evaluates each variant's
selection criteria — role, path, language, entity bundle, and so on — in weighted
order and renders the first variant that matches, falling back to the next if none
apply. This is what lets you show one layout to editors and another to the public,
or one layout for articles and a different fallback for everything else. Contexts
such as the current user, the route's entity, and the interface language are handed
to variants and their blocks automatically.

Everything is stored as exportable configuration, so pages move cleanly between
environments. Importantly, the main `page_manager` module is the **engine only** —
to build pages through a UI you also enable the **Page Manager UI**
(`page_manager_ui`) submodule, which provides the wizard at **Structure → Pages**.
For drag-and-drop layouts, the separate **Panels** module adds a Panels variant.

Page Manager depends on core's **Block** module and the contrib **CTools** module.
It adds one permission, `administer pages`. This guide is written for a **human**
clicking through the admin UI; if you want terse, token-cheap references for an AI
coding agent — including the page/variant config entity shapes, display-variant
plugins, and the context event — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module and CTools with
   Composer, then enable the engine and the UI submodule.
2. [Configuration](configuration/index.md) — build a page and its variants with the
   Structure → Pages wizard, step by step.

## Where it lives in the admin menu

With the **Page Manager UI** submodule enabled, you manage pages at **Structure →
Pages** (`/admin/structure/pages`). Creating, editing, deleting, and reordering
pages and variants there is gated by the **Administer pages** (`administer pages`)
permission — grant it only to trusted roles, since a page can override core routes.
Each page's own *view* access is controlled separately by the access conditions you
set on the page.
