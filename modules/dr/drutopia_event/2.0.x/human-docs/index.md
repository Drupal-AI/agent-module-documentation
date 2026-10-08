# Drutopia Event — manual setup guide

**Drutopia Event** (`drutopia_event`) is a base *feature* module from the
[Drutopia](https://www.drupal.org/project/drutopia) distribution. It installs a
ready-made **Event** content type and all its supporting configuration in one
step, so a Drutopia site can start publishing events without hand-building the
date field, taxonomy, listing and displays.

Drutopia features are **config-only**: the module ships almost entirely as
`config/install` YAML and adds no custom PHP, routes, services or permissions of
its own. Enabling it creates the `event` node type with an event **date field**
(`field_event_date`, a datetime range for start/end), an `event_type` taxonomy
vocabulary and reference, topics/tags references, a media image with focal-point
cropping, a summary, and a Paragraphs body. It also installs multiple view
displays (card, teaser, full, micro, simple card, search index), a Search API
index, facets (by event type and topics), a Views-based event listing
(`view.event.page_listing`) with an "Add event" action link, Pathauto URL
patterns, Metatag defaults and a block visibility group for event listings.

Access follows the standard node access system: `config/actions` grant event
create/edit/delete permissions to the Drutopia editorial roles (contributor /
editor / manager). Editors add events from the listing's "Add" action; site
builders customise the shipped configuration like any other content type.

It depends on a large stack — **Drutopia Core** and **Drutopia SEO**, core
Datetime/Datetime Range, Media, Node, Taxonomy and Views, plus contrib Display
Suite, Paragraphs, Facets, Search API, Focal Point, Field Group, Metatag,
Pathauto, Entity Reference Revisions and Block Visibility Groups. See the
[Drutopia Core](../../drutopia_core/2.0.x/human-docs/index.md) guide for the
shared base it builds on. It is normally installed as part of a Drutopia site
rather than on its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   feature and its dependencies.

There is **no dedicated configuration page** for this module — it ships
configuration rather than a settings form. You manage what it installs through
the normal content-type, field, display, Views and taxonomy admin, exactly as you
would any other content type.

## Where it lives in the admin menu

Drutopia Event adds no settings page of its own. After enabling it you'll find:

- **The event listing** — a Views page (`view.event.page_listing`) carrying an
  **Add event** action link (also reachable at **Content → Add content → Event**,
  `/node/add/event`).
- **The content type** — **Structure → Content types → Event**
  (`/admin/structure/types/manage/event`), where its fields (including the event
  date range), form display and view displays live.
- **The vocabulary** — **Structure → Taxonomy → Event type**
  (`/admin/structure/taxonomy`), for the `event_type` classification terms.

## How to use it

Once enabled, an editor with the appropriate Drutopia role adds an Event from the
listing's "Add event" link or from **Content → Add content → Event**, sets the
start/end dates, chooses an event type, adds an image and body, and publishes. The
event then appears in the faceted listing (filterable by type and topics), is
indexed for site search, and gets an SEO-friendly URL and metadata automatically.
Site builders who want to change the fields or displays edit the `event` content
type like any other, and can combine it with other Drutopia features to build a
full events calendar or landing page.
