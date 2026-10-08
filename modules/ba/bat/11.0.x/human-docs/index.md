# BAT: Booking and Availability Tools — manual setup guide

**BAT: Booking and Availability Tools** (`bat`) is a generalized **booking and
availability-management framework** for Drupal, built on the Roomify `roomify/bat`
PHP library. It is the foundation for building booking products of all kinds —
hotels, holiday rentals, appointment scheduling, equipment reservations — on
Drupal. BAT models "what can be booked" as **Units** and **Unit Types**, "when it
is available, blocked, or priced" as **Events** stored on fast per-event-type
calendar tables, and "who reserved it" as **Bookings**.

The important thing to understand is that the base `bat` module you are looking at
is a **framework layer, not a finished product**. On its own it provides the
cross-cutting scaffolding the rest of the suite reuses: a bundle-granular
entity-access model (with a full generated permission set per BAT entity type),
site-wide date-format settings, a `bat_type_group` grouping entity, the `/admin/bat`
admin section and toolbar item, and a set of helper APIs. Almost all of the actual
functionality — units, events, bookings, calendars, pricing — lives in the ten
submodules that ship with it. Installing `bat` alone makes sense only if you are
building directly on the framework; most sites enable a selection of the submodules
(see [Installation](installation/index.md)).

Because BAT is a suite, plan your setup around which pieces you need. A typical
booking site enables **BAT Unit** (the bookable things), **BAT Event** (the
availability/pricing calendar engine), **BAT Booking** (the reservations), and
**BAT FullCalendar** (calendar rendering and management), often with **BAT Event
UI** for the admin calendar screens. The framework's access model then gives every
one of those entity types a consistent, per-bundle permission scheme out of the
box.

This guide is written for a **human** setting the framework up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead — and each submodule has its own docs
under `modules/<name>/11.0.x/`.

## Contents

1. [Installation](installation/index.md) — install with Composer (it pulls in the
   Roomify libraries), enable the base module, and choose your submodules.
2. [Configuration](configuration/index.md) — the site-wide date settings, the
   type-group entity, and how the permission model works.

## Where it lives in the admin menu

The base module registers a **Bat** administration section at `/admin/bat`, with
**Configuration** (`/admin/bat/config`) and **Group** (`/admin/bat/group`)
subsections, plus a toolbar entry. The date settings form is at
**`/admin/bat/config/date`**. Submodules hang their own pages (units, events,
calendars, bookings) under `/admin/bat`.

## How to use it

1. Install BAT and enable the submodules that match what you are building (see
   [Installation](installation/index.md)).
2. Set your site-wide date formats and the earliest-start window at
   **`/admin/bat/config/date`** (see [Configuration](configuration/index.md)).
3. Grant the appropriate BAT permissions to your editorial and customer roles —
   BAT generates a per-bundle `create / view / update / delete` scheme (with `own`
   vs `any` variants) for each entity type.
4. Build out your bookable model in the submodules: define Unit Types and Units,
   set availability and pricing Events, and manage Bookings, usually through a
   FullCalendar interface.
