# View mode page — manual setup guide

**View mode page** (`view_mode_page`) lets you expose an entity at one or more
**additional paths** that render it in a **chosen view mode**. For example, you
can show a node's *teaser* at `/{its-alias}/summary` while its full page stays at
its normal canonical URL — without creating a custom route or duplicating any
content.

You define the behavior as reusable **path patterns**. Each pattern has a path
template containing a `%` placeholder that stands for the entity's normal URL or
alias (for example `/%/summary` or `/%/print`), and it names the view mode to
render there. When a visitor hits a matching path, the module renders the entity
in that view mode *inline* — it is a real, self‑contained URL, not a redirect —
so it is clean for SEO and can be linked to directly.

Patterns can be as broad or as narrow as you like. Leave the conditions empty to
apply a pattern to any entity that has a canonical URL, or add **selection
criteria** to limit it to specific bundles (say, only Articles) or languages,
combined with and/or logic. When several patterns could match the same request, a
**weight** decides which one wins. Typical uses are teaser, print, card, email,
mobile, or "distraction‑free reading" versions of your content, each at its own
tidy path.

View mode page is a site‑builder tool. It depends on core's **Path** module and
the contributed **CTools** (for the condition plugins) and **Token** modules, and
provides an "alias type" plugin system so developers can extend which kinds of
paths patterns can match.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the pattern
config entity fields and how a request resolves — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies with Composer and enable it.
2. [Configuration](configuration/index.md) — creating and managing path patterns,
   field by field.

## Where it lives in the admin menu

Once enabled, the patterns list sits at **Configuration → Search and metadata →
View mode page** (`/admin/config/search/view-mode-page`), gated by the
**Administer view_mode_page** permission.

## How to use it

Add a pattern that maps a path template (with a `%` placeholder for the entity's
normal URL) to a view mode, optionally restricting it to certain bundles or
languages. Save it, and the entity is immediately reachable at that extra path,
rendered in your chosen view mode. See [Configuration](configuration/index.md) for
the details.
