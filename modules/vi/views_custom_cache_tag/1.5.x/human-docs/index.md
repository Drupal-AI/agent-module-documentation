# Views Custom Cache Tag — manual setup guide

**Views Custom Cache Tag** (`views_custom_cache_tag`) gives you **precise, manual control over
when a View's cache is cleared**. It adds a new caching option to Views — *Custom Tag based* —
that lets you attach your own cache tags to a view and, crucially, **stops the view from being
flushed by the broad automatic tags** (like `node_list`) that Views normally adds. The result:
your view stays cached until *you* deliberately invalidate one of the tags you chose, instead
of being rebuilt every time any content of that type is saved anywhere on the site.

This is a performance tool for expensive or rarely‑changing views. A "latest articles" block,
a heavy aggregate report, a view of imported data, or a REST export can be cached long‑term
and busted only at the exact moment it matters — when an editor publishes, when a nightly
import finishes, or from your own custom code, a queue worker, or an event subscriber. The tag
list also supports Twig tokens, so a view with a contextual filter can keep a **separate cache
per argument value** (for example one tag per content type). An optional lifespan setting adds
a time‑based expiry on top of tag invalidation as a safety net.

Because caching now depends on you invalidating the right tag, this is a **developer‑oriented**
module: the payoff comes when your code (or another module like ECA/Rules) calls the matching
`Cache::invalidateTags()` at the right time. It requires only core's **Views** module and adds
no permissions or Drush commands. It ships a *demo* submodule with example content and views to
illustrate the plugin; that submodule is for demonstration only and isn't meant for production.

This guide is written for a **human** configuring caching in the Views UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead — including how to invalidate the tags from code.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.

## Where it lives in the admin menu

There is **no settings page**. You choose this cache option per view, inside the Views UI at
**Structure → Views** (`/admin/structure/views`), under a display's **Advanced → Caching**
setting.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Edit a view at **Structure → Views → *your view***.
3. In the display, open **Advanced → Other → Caching** and click the current value.
4. Choose **Custom Tag based** and click **Apply**.
5. In the plugin settings:
   - **Custom tag list** — enter one cache tag per line, e.g. `my_module:report`. These tags
     are added to the view, and the view stays cached until one of them is invalidated. You
     can use Twig here — for example `node:type:{{ raw_arguments.type }}` gives a view with a
     `type` contextual filter its own separate cache per content type argument.
   - **Rendered output** — an optional lifespan (TTL) for the rendered HTML: **Unlimited
     (tag‑based only)**, a preset interval from 1 minute up to 6 days, or **Custom**.
   - **Custom expression** (only when *Custom* is chosen) — a `strtotime()` string such as
     `+1 hour` or `tomorrow 6am`, which must resolve to a time in the future.
6. Save the view.

From then on, the view is *not* flushed by unrelated saves of that entity type — you bust it
yourself by invalidating one of your custom tags from code, a hook, a queue worker, or a tool
like ECA/Rules. See the [`agent/`](../agent/start.md) docs for the exact invalidation calls
and a debug flag that reveals which views actually re‑execute.
