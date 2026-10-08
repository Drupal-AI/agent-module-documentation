# LocalGov Events — manual setup guide

**LocalGov Events** (`localgov_events`) is the events section for a LocalGov Drupal site. It
ships a ready-made **Event** content type with proper recurring-date support, a date-filtered
listing page, a keyword search page, and category facets — everything you need to publish a
council's "what's on" section out of the box.

The heart of it is the `localgov_event` content type, whose date field is a **date_recur**
field rather than a plain date. That means an event can repeat on a rule — every Tuesday, the
first Monday of the month, and so on — and each occurrence is indexed separately, so a recurring
event shows up on **every date it actually happens**, not just its first. Editors get a friendly
recurrence widget on the add/edit form instead of typing raw RRULE strings. Alongside the date,
each event carries an image, categories, a price, a locality and location (which can link to a
directories venue), a call-to-action link, and a description.

Two Views come with the module: a date-filtered browse listing and a keyword search. The listing
quietly fixes two everyday annoyances — an empty "from" date defaults to today, and the "to" date
is treated inclusively so events *on* the end date are shown. A once-a-day cron task keeps
infinitely recurring events from generating occurrence rows forever, and event pages under
`/events` get their styling attached automatically.

This module has **no settings page of its own** (no `configure` route, no permissions it adds
directly). Most of what you'd think of as "configuration" is really the pre-built content type,
fields, and views that install brings — you tune them the normal Drupal way. Its optional
submodule, **LocalGov Events: Remove expired** (`localgov_events_remove_expired`), *does* add a
settings page for automatically cleaning up finished events.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its dependencies with
   Composer, enable it, and optionally add the expired-events submodule.

## Where it lives in the admin menu

The module has no central settings page. What it adds:

- **Content → Add content → Event** — create events (the `localgov_event` type).
- **Structure → Views** (`/admin/structure/views`) — the `localgov_events_listing` and
  `localgov_events_search` views.
- The **/events** browse and search pages on the front end, plus category **facet** blocks
  (placed via **Structure → Block layout**).
- If you enable the submodule: **Configuration → Content authoring → Expired events**
  (`/admin/config/content/expired-events`).

## How to use it

### Create an event

1. Go to **Content → Add content → Event**.
2. Give it a title, image, description, price, locality/location, and a call-to-action link as
   needed.
3. Set the **date** — for a one-off event just pick start and end; for a repeating event, use
   the recurrence widget to set the pattern (for example "weekly" or "first Monday of the
   month"). Prefer a bounded rule (a repeat count or an end date) where you can.
4. Assign one or more **categories** — these drive the category facet on the listing.
5. Save. A recurring event will appear on each of its occurrence dates in the listing.

### The listing and its date filters

The events listing has exposed **start** and **end** date filters. Two behaviors are worth
knowing:

- If a visitor leaves the **start** date empty, it defaults to **today** — so a bare link to the
  listing means "from today onward", not "all time". To show past events, pass an explicit start
  date.
- The **end** date is inclusive: an event happening *on* the chosen end date is included in the
  results.

> **Cloning the listing view?** These two adjustments are applied by the view's id
> (`localgov_events_listing`). If you clone the view under a new id you'll lose them — instead,
> keep the id and add a new display to it.

### Category facets and search

Category facets come from the Facets module and are placed as blocks; use them to let visitors
narrow the listing by category. The separate search view provides keyword search across events.

### Cleaning up finished events

Enable the **LocalGov Events: Remove expired** submodule to archive or delete events after they
finish, and configure its behavior at **Configuration → Content authoring → Expired events**.
