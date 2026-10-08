# Advanced Help Block — manual setup guide

**Advanced Help Block** (`advanced_help_block`) lets your team put **editorial
help content on the admin pages where it is needed**, maintained by the team
rather than by a developer. The guidance an editorial team relies on is
site-specific — "use the summary field for the homepage card, not the teaser",
"images on this content type must be 16:9", "ask legal before publishing in this
section" — and the moment it is needed is while someone is looking at the form it
applies to. This module lets you author that guidance as fielded **help block
entities** and show them as blocks on the relevant administrative pages.

It comes from the **YMCA Website Services** distribution, which explains its
dependency list — including `field_group`, `libraries`, core `text`, `options`,
`user`, `help`, and, worth noticing, **`datalayer`** (a tracking-adjacent
module). If you are installing this outside that distribution, take note of the
`datalayer` dependency before you do. Permissions are split into **view**, **add**,
and **edit** of the help entities separately, which is the right split: writing
guidance is an editorial act and should not require the permission to configure
blocks.

Two things worth keeping in mind. **Help that is wrong is worse than no help**,
because people trust it — so give this content an owner and a review point like
any other content. And **the audience is authenticated editors on administrative
pages**, so scope the blocks to those routes rather than placing them site-wide,
both to avoid leaking internal instructions onto public pages and because
guidance shown where it does not apply trains people to ignore it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   note its dependencies, and enable it.
2. [Configuration](configuration/index.md) — create help block entities, place
   them on admin pages, and assign the view/add/edit permissions.

## Where it lives in the admin menu

You maintain the help content as entities and then place them as blocks on the
admin routes where they apply (via **Block layout**). The separate view / add /
edit permissions are set on **People → Permissions**. See
[Configuration](configuration/index.md) for the steps.
