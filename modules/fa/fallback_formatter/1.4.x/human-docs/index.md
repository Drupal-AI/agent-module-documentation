# Fallback Formatter — manual setup guide

**Fallback Formatter** (`fallback_formatter`) adds one new field formatter,
called **Fallback**, that chains several other formatters together and, for each
value in a field, uses the output of the *first* one that actually produces
something. It is the "rich, else simple" strategy in a single reusable formatter:
try your preferred display, and if it comes up empty for a given value, quietly
fall through to a plainer one.

A classic example is a link field: render it with the **Link** formatter, but for
any item whose URL is malformed or empty, fall back to the **Plain text**
formatter so you never show a broken link — or nothing at all. It is equally handy
for imported or migrated data with inconsistent values, for date fields where you
want to try several date formats, or for entity references that should show a
rendered view but degrade to just a label.

An important detail: the "first formatter that produces output wins" decision is
made **per field item**, not for the whole field. So in a multi-value field, item 1
might be rendered by your preferred formatter while item 2 falls through to the
next one in the list — every item gets the best available rendering independently.

The module has **no settings page, no permissions, and no dependencies** — it is
purely a per-field display option you pick on *Manage display*. That is why this
guide has an installation page but no separate configuration page; everything you
tune lives inside the formatter's own settings on the field.

This guide is written for a **human** clicking through the admin UI. If you want a
terse, token-cheap reference for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no central admin page. The Fallback formatter appears as an option on
each field's display settings at **Structure → *(entity type)* → Manage display**
(for example `admin/structure/types/manage/article/display` for the Article
content type). It only shows up for field types that already have **two or more**
formatters available — chaining a single formatter would be pointless, so the
module hides the option where it makes no sense.

## How to use it

1. Go to the **Manage display** screen for the entity and view mode you want to
   change (for example Article, *Default* view mode).
2. Find the field you want a fallback for and, in its **Format** column, choose
   **Fallback**.
3. Click the **cog** to open the formatter's settings. You will see three linked
   parts:
   - **Enabled formatters** — tick each candidate formatter you want in the chain
     (all of the field type's formatters except Fallback itself).
   - **Formatter processing weight** — a drag-and-drop table that sets the order
     the formatters are tried; the one with the lowest weight runs first.
   - **Per-formatter settings** — each enabled formatter's own settings form,
     shown inline so you can configure it exactly as you normally would.
4. Order the list so your preferred display sits at the top and your last-resort
   display sits at the bottom, then **Update** and **Save**.

At render time the module runs the enabled formatters in order and, for each field
item, keeps the output of the first one that returns something visible — falling
through to later formatters only for the items that still have no output.

A couple of built-in limits worth knowing: Fallback cannot fall back to itself (no
infinite loops), and it cannot be used as an Entity Embed display plugin.
