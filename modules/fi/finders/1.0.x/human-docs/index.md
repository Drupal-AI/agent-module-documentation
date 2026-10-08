# Finders — manual setup guide

**Finders** (`finders`) is a framework for building searchable, filterable listing
pages that content editors can create themselves — without a site builder having to
change configuration each time. The idea is a "channel" entity that lists other
entities (its "entries"), with the list built on **Search API** and **Views**, and
optional faceted filters on top. Think directories, events, news, consultations —
anything that has entries grouped into a channel that visitors need to search and
filter through.

Finders provides the common display/index/filter plumbing and a basic Finder type;
other modules build richer, more specific Finder types on top of it (for example
the companion **Finders Events** module). The pattern originated in LocalGov Drupal
Directories and has been generalised so any information-architecture module can
offer editors an easy way to create find-and-filter experiences. It depends on
core's **Block** and **Views** modules plus the contributed **Search API** and
**Views Reference** modules.

This is an alpha-stage framework aimed at site builders and editors working
together. Note that it requires **Drupal 11.3+**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Search API /
   Views Reference dependencies with Composer, and enable it.

Finders has **no single settings form**. Instead, once it's enabled, editors work
with Finder (channel) entities, described in "How to use it" below.

## How to use it

Finders adds a **Finder** entity type that acts as a channel. In broad strokes:

1. Make sure your entries are indexed — Finders builds its lists with **Search
   API**, so you need a Search API index covering the content you want to list.
2. Create a **Finder** (channel) entity. Its list is assembled through Search API
   and Views (via **Views Reference**), and it can carry faceted filters so
   visitors can narrow results.
3. Place or link to the channel so visitors can browse and filter its entries.

The base module ships a basic Finder type. For richer, purpose-built types (such as
events with recurring dates and calendars), add a Finder-type module like **Finders
Events** on top. The module provides its own permissions — assign them under
**People → Permissions** to control who can create and manage Finder channels.
