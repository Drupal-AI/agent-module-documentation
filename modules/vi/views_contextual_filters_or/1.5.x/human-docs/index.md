# Views Contextual Filters OR — manual setup guide

**Views Contextual Filters OR** (`views_contextual_filters_or`) adds a single
checkbox to a View display that changes how its contextual filters (arguments)
are combined — from the default **AND** to **OR**. With it on, a view that has
several arguments returns rows matching *any* of them instead of requiring *all*
of them.

By default, Views combines every contextual filter with AND: a row must match
argument 1 AND argument 2 AND so on. That's often too strict. This module lets
you build listings like "content by this author OR tagged with this term," a
"my content OR content shared with me" view, or a URL like `/list/1+2+3` where
each argument targets a different field and any one match is enough.

The whole feature is one per‑display checkbox under the view's **Query settings**.
It works for both regular (SQL) views and Search API views, and because the
switch happens at the query level it applies to all of that display's contextual
filters at once — there is no per‑argument toggle. It affects only the default
argument filter group, so any exposed or normal filters you place in other groups
keep their own AND/OR operators.

The module has **no admin settings page, no permission, and no Drush command** —
the setting lives on the view and exports with your view config, so it deploys
cleanly across environments.

This guide is written for a **human** working in the Views UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

There is no module settings page. The checkbox appears inside each View you edit
at **Structure → Views**, in the display's **Query settings**.

## How to use it

1. Make sure your view display actually has contextual filters defined
   (**Advanced → Contextual filters**) — the checkbox only has an effect when
   there are arguments to combine.
2. Edit the view (`/admin/structure/views/view/<view_id>`).
3. In the display's **Advanced** column, under **Other → Query settings**, click
   the current value.
4. Tick **Contextual filters OR** ("Contextual filters applied to OR logic."),
   click **Apply**, then **Save**.

That's it — the display's arguments are now OR'd together. (You can also set it
without the UI; the value is stored at
`display.<display_id>.display_options.query.options.contextual_filters_or`.)

A couple of things to keep in mind: only the default argument filter group is
flipped to OR — your Filter criteria groups keep their own operators — and if you
ever uninstall the module, remove the option from any saved views first so it
doesn't linger as an unrecognized config key.
