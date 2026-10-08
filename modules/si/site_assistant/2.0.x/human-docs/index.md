# Site Assistant — manual setup guide

**Site Assistant** (`site_assistant`) lets you build *assistants* — guided helpers
that give visitors a shortcut to the content and actions most useful to them at a
given moment. Instead of leaving people to hunt through your site, you create an
assistant that surfaces the right links and information for a particular audience or
part of the site, improving onboarding and self-service.

Each assistant is made of two parts: a **content** field, where you add any number of
assistant list entries, and a **visibility conditions** field, where you set when the
assistant should appear (using Drupal's condition plugin system — path, user role, and
so on). Assistant list entries are content entities that come in different shapes,
from a simple *Headline* to a more involved *Subpage*, and you can even define your own
entry type. For content you want to reuse across several assistants, **assistant
library items** bundle a set of list entries together so they can be shared.

Because everything is modelled as content entities, Site Assistant needs configuration
to be useful — you build the assistants that fit your site. Typical uses: a
path-targeted assistant for journalists under a `public-relations/*` section, or two
role-targeted assistants in an online shop, one for anonymous visitors and one for
logged-in customers, sharing common information through a library item. The module
depends on the **Inline Entity Form** module and supports Drupal 10.6+ and 11.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependency.

## How to use it

After enabling the module you create and manage assistants through their admin entity
pages. Each assistant gets its content (the list entries a visitor sees) and its
visibility conditions (when and where it shows). Build a shared **assistant library
item** when the same block of entries should appear in more than one assistant. The
module ships a set of CRUD permissions across the assistant, library-item, and
list-entry entity types plus an overall **`administer site_assistant`** permission —
grant editing and administration only to trusted roles.
