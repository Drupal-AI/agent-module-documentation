# Event Platform Bundle — manual setup guide

**Event Platform Bundle** (`event_platform`) is a set of modules that, together,
configure a Drupal site for a **conference or Drupal Camp** in one step. Rather than a
single feature, it is an ecosystem: enabling the top-level module installs a group of
submodules, each of which imports the content types, views, vocabularies, and workflow
configuration for one part of an event site.

The pieces cover the whole event: **Sessions** (visitor-suggested sessions with a
content-moderation approval workflow, accept/reject notifications, and rooms, tracks,
and time slots), **Speakers**, **Sponsors** (grouped by tier — bronze, silver, gold),
**Ratings**, **Job Listings**, and **Details** (a central admin section for the event's
key information, hero/CTA/copyright blocks, and metatag defaults). A **Scheduler**
provides a drag-and-drop interface for assigning accepted sessions to rooms and time
slots, plus a form for generating many time slots across several days at once. An
optional **Olivero** submodule automatically places all the provided blocks into the
right regions of the Olivero theme.

Because the bundle mainly *imports configuration*, the top-level module can be
uninstalled once setup is complete — the content types and other config it created stay
behind. It cannot be re-installed on the same site unless you first delete those
bundles. The one part that keeps a live interface is the **Scheduler**, which has an
ongoing UI and its own settings form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the bundle with Composer and choose
   which submodules to enable.
2. [Configuration](configuration/index.md) — the Session Scheduler and its settings
   form, the only part that stays configurable after setup.

## Where it lives in the admin menu

Once enabled, the **Details** submodule adds an **Event details** admin section as a
central place to manage the event's key information. The Session Scheduler lives under
it at **/admin/event-details/scheduler**, with its settings at
**/admin/event-details/scheduler/settings** and a time-slot generator at
**/admin/event-details/scheduler/time_slots**. All of these are permission-gated to
session-content editors and administrators.

## How to use it

1. Enable the bundle (and optionally `event_platform_olivero`) to import the full event
   site configuration in one step — or enable just the submodules you need, such as
   Sessions and Speakers only.
2. Let visitors suggest sessions through the moderated Sessions content type; run them
   through the approval workflow, which sends accept/reject notifications.
3. Publish accepted sessions in the provided listing view, and associate them with
   rooms, tracks, and time slots.
4. Use the **Scheduler** to generate time slots and then drag accepted sessions onto
   rooms and time slots. See [Configuration](configuration/index.md) for its settings.
5. Add speakers and sponsors (grouped by tier), collect ratings, and post job
   listings. With the Olivero submodule enabled, the hero, CTA, and copyright blocks
   are placed for you.
6. Once the site is built, you may uninstall the top-level module if you wish; the
   created content types and config remain.
