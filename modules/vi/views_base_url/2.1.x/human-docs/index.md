# Views Base URL — manual setup guide

**Views Base URL** (`views_base_url`) adds a single global field to Views that
outputs your site's complete base URL — the scheme, host, and base path together,
for example `https://example.com`. It is a small, focused tool that solves a common
Views problem: how to build **absolute** links inside a view.

Relative paths (`/node/1`) break the moment a view's output leaves the page — in an
RSS feed, an email newsletter, a CSV export, or JavaScript that reads the markup.
The old workaround was to drop PHP or `l()` calls into a view, which is slow and
uncached. Views Base URL replaces that with a proper, cacheable native field. Add
the **Global: Base url** field to any view and it prints the base URL; enable its
**Display as link** option and you get a full set of link sub-options (path, text,
CSS class, title, rel, fragment, query, target) for hand-building absolute links.

You can also use the field as a token. Add it, tick *Exclude from display*, and then
reference `[base_url]` inside a **Global: Custom text** field to weave the base URL
into your own markup — for example `<a href="[base_url]/home">Home</a>`. Because the
field reads the live request's base URL, the same view produces correct absolute
links across every environment (dev, staging, production) with no per-environment
configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Views Base URL has **no settings page of its own**. Everything happens inside the
Views UI (**Structure → Views**, `/admin/structure/views`) when you add and
configure the field. The field's configuration is stored in the view itself.

## How to use it

**Add the field.** In the Views UI, click **Add** next to *Fields* and search for
**Global: Base url**. On its own, it prints the site's complete base URL as a
column.

**Use it as a `[base_url]` token in Custom text:**

1. Add the **Global: Base url** field and tick **Exclude from display**.
2. Add a **Global: Custom text** field *below* it (order matters — a field can only
   use tokens from fields above it).
3. In the Custom text, reference `[base_url]`, e.g.
   `<a href="[base_url]/home">Home</a>`.

**Render it as a link (the field's own options).** Tick **Display as link** on the
Base url field and fill in the sub-options you need:

| Option | What it does |
|---|---|
| **Link path** | A Drupal path appended to the base URL (run through the alias manager). Leave empty to link to the base URL itself. |
| **Link text** | The visible link text. Empty shows the URL. |
| **Link class** | CSS class(es) on the `<a>`, space-separated. |
| **Link title** | The `title` attribute. |
| **Link rel** | The `rel` attribute. |
| **Link fragment** | A `#anchor` appended to the URL. |
| **Link query** | Query string, e.g. `destination=node/add/page`. |
| **Link target** | The `target` attribute, e.g. `_blank`. |

Most of these sub-options accept Views **`{{ token }}`** replacement patterns, so
you can weave in the value of another field or argument that appears above this one
in the view — for example building a per-row absolute link.

This is a display-only helper: there are no permissions, no Drush commands, and
nothing to configure outside the view.
