# Views Contextual Filter Default Entity Field Values — manual setup guide

**Views Contextual Filter Default Entity Field Values** (`views_arg_entity_field`) adds one
option to Views' contextual filters: it can supply a filter's default value from a **field on
the "current" entity** — the entity resolved from the page's URL. In plain terms, if a view is
embedded on a node page (or a term, user, or media page), this lets the view filter itself using
a field value taken from *that* node, without you hard-coding an ID into the view's path.

That makes it the tool for classic "related content" patterns: show other content that shares a
taxonomy term with the node you are viewing, build a "more like this" block driven by a
reference field, or contextualize a listing off the current page's author, category, or region.
Because it reads the entity from the current route, the same view works on any entity of that
type — the value comes from whichever page the view happens to be rendered on.

You choose a content entity type and one of its fields (down to a specific property, like
`field_ref:target_id`). Multi-value fields can be joined for an OR match (`+`) or an AND match
(`,`), or you can take a single delta. An **empty value** fallback is returned when the field
exists but is empty, which pairs neatly with a Views exception value to skip filtering
altogether. The plugin also caches correctly by inheriting the source entity's cache tags, so
results invalidate when that entity changes.

The module works on Drupal 10.3+ / 11 with no dependencies beyond core Views. It has **no admin
settings page, no permissions, and no Drush** — it is configured entirely on the contextual
filter inside a view, so enabling it simply makes the new default-value option available.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent — every option and the runtime resolution logic —
read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## How to use it

1. Edit a view and add a **Contextual filter** (typically the numeric or string argument you
   want to match — for example a taxonomy term ID or an entity-reference target ID).
2. In the contextual filter settings, under **When the filter value is NOT available in the
   URL**, choose **Provide default value**, then set the default-value type to **Field value
   from Current Entity**.
3. Configure the options:
   - **Entity type** — the content entity type to resolve from the route (default *node*).
   - **Field** — the field to read, chosen as `field_name:property`. Pick the right property,
     e.g. `field_ref:target_id` for a reference ID or `field_link:uri` for a link.
   - **Empty value** — what to return when the field exists but is empty.
   - **Multiple values** — *concatenate* all deltas, or use a *single* delta.
   - **Separator** — `+` (OR) or `,` (AND), when concatenating.
   - **Single value delta** — which delta to use in *single* mode.
4. Save.

Tips: to OR-match a multi-value reference field, use the `+` separator together with **Allow
multiple values** in the contextual filter's *More* section; use `,` for AND. To skip the filter
entirely when the current entity's field is empty, set **Empty value** and add a matching
**Exception value** in the *Exceptions* section. The full option table and the exact
resolution/caching behaviour are in
[`agent/configure/argument.md`](../agent/configure/argument.md).

## Where it lives in the admin menu

Nowhere of its own — there is no settings page. The option appears inside the Views UI, on any
contextual filter, under **Provide default value → Field value from Current Entity**.
