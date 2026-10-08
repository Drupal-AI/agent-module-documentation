# Field Group EU Cookie Compliance — manual setup guide

**Field Group EU Cookie Compliance** (`field_group_eu_cookie_compliance`) adds a
single **Field Group display formatter** that hides a group of fields until the
visitor has accepted a particular cookie category from the
[EU Cookie Compliance](https://www.drupal.org/project/eu_cookie_compliance)
module. It's the tool you reach for when a page carries third‑party embeds —
YouTube videos, Google Maps, analytics pixels — that you don't want dropping
cookies before the visitor has consented to them.

The way it works is simple: you wrap the fields you want to gate inside a field
group on an entity's *Manage display*, choose the "EU Cookie Compliance"
formatter for that group, and pick the cookie category the visitor must have
accepted. At render time the formatter checks the visitor's consent cookie. If
the required category has not been accepted, every field inside the group is
removed before the page is built — the markup never reaches the browser at all,
so nothing loads and no cookies are set.

One important caveat: this is a **display‑time hide keyed on a client cookie**,
not an authorization control. It keeps consent‑sensitive embeds out of the HTML,
but you should not rely on it to protect genuinely sensitive or private data —
use proper field access for that. It also has caching implications you must
address for consent variation to work correctly (see below and in
[Installation](installation/index.md)).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its dependencies, and apply the required cache settings.

There is **no configuration page** for this module — it has no settings form of
its own. You set it up entirely on your entity's *Manage display*, described in
"How to use it" below.

## Where it lives in the admin menu

Field Group EU Cookie Compliance adds no admin page. You use it from **Structure
→ Content types (or any fieldable entity) → *(bundle)* → Manage display**, where
its formatter appears in the list of field group formats. The cookie categories
themselves are defined in the EU Cookie Compliance module at its own settings
page.

## How to use it

1. Make sure EU Cookie Compliance is installed and configured with the cookie
   categories you care about (for example *marketing* or *statistics*).
2. On the display you want to gate (a node's *Manage display*, for instance),
   add a **field group** and give it the **EU Cookie Compliance** format.
3. Move the fields you want to hide — the video embed, the map iframe, the
   tracking pixel field — inside that group.
4. In the group's format settings, choose the **required cookie category**. Only
   visitors who have accepted that category will see the group's fields.
5. Save the display.

When the required category has not been accepted, the formatter unsets the
group's child elements so they are never rendered, adds the
`cookies:cookie-agreed-categories` cache context, and sets the response
`max-age` to `0`.

> **Caching matters here.** Because the output varies per visitor's consent, the
> module's README requires you to **disable the core Internal Page Cache module**
> and add `cookies:cookie-agreed-categories` to your site's
> `required_cache_contexts` (there's a `services_example.yml` in the project to
> copy from). Without those steps a cached page can leak the pre‑consent or
> post‑consent version to the wrong visitor. See
> [Installation](installation/index.md) for the details.
