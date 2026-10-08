# Google Calendar Entity — manual setup guide

**Google Calendar Entity** (`gcal_entity`) displays Google Calendar events on your
Drupal site as a simple **agenda list** — each entry showing a date and event
title. It fetches events from the Google Calendar API and represents each calendar
as a Drupal **content entity**, so you can reference a calendar from a content type
and embed its agenda wherever you like. It was inspired by the Drupal 7 Agenda
module.

To use it you need a free **Google Calendar API key** and the calendar you want to
show must be set to **public**. You enter the API key once on the module's global
settings page, then create a "GCal entity" for each calendar (identified by its
calendar ID) and publish it.

> **Treat the API key as a secret.** The module stores it in plaintext — either in
> configuration or in Drupal's state — and has no Key‑module integration. Prefer
> the **state** storage option (which is not exported with config) and keep any
> config exports private. See [Configuration](configuration/index.md) for details.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and the Google API
   client library) with Composer and enable it.
2. [Configuration](configuration/index.md) — enter your API key, tune the agenda
   display, and create a calendar.

## Where it lives in the admin menu

The global settings form is at `/admin/config/gcal_entity/config`, behind the
**Administer gcal entity entities** permission. Individual calendars are managed as
content — **Add GCal entity** — and can be embedded via an entity‑reference field.
