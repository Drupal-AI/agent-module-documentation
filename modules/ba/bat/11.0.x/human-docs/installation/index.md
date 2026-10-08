# Installation

## Requirements

- **Drupal 9.4, 10.2, or 11** (`core_version_requirement: ^9.4 || ^10.2 || ^11`).
- Two Composer (PHP) libraries, pulled in automatically:
  - **`roomify/bat`** (`~1.3`) — the calendar/availability engine BAT is built on.
  - **`rlanvin/php-rrule`** (`^2.2`) — recurrence-rule handling for recurring
    availability.

The base module has no Drupal module dependencies of its own; the submodules bring
in what they need (for example some rely on core Layout/Views, and pricing
features integrate with Drupal Commerce).

## Install with Composer

From the project root:

```bash
composer require drupal/bat -W
```

The `-W` (`--with-all-dependencies`) flag is important — it lets Composer pull in
`roomify/bat`, `rlanvin/php-rrule`, and any other shared dependencies together.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/bat -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bat -y
```

This enables only the framework layer. To get real booking functionality, enable
the submodules you need (below).

## Submodules — the actual booking features

BAT ships ten submodules. Enable them individually with `drush en`. A typical
booking site uses **BAT Unit + BAT Event + BAT Booking + BAT FullCalendar**, often
with **BAT Event UI**.

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **BAT Unit** | `bat_unit` | The **Unit** and **Unit Type** entities — the bookable things and their types. |
| **BAT Event** | `bat_event` | **Events**, availability/pricing **States**, and the fast per-event-type calendar storage engine. The heart of availability management. |
| **BAT Event Series** | `bat_event_series` | Recurring events driven by recurrence rules (rrule). |
| **BAT Booking** | `bat_booking` | The **Booking** entity — who reserved what. |
| **BAT FullCalendar** | `bat_fullcalendar` | FullCalendar-based rendering and a calendar management API. |
| **BAT Calendar Reference** | `bat_calendar_reference` | Reference and display availability on any entity. |
| **BAT Options** | `bat_options` | A Commerce pricing-options field. |
| **BAT Facets** | `bat_facets` | An availability-aware Search API facet. |
| **BAT Event UI** | `bat_event_ui` | The admin calendar management UI. |
| **BAT Group** | `bat_group` | A group service (skeleton). |

For example, to stand up a basic booking stack:

```bash
drush en bat_unit bat_event bat_booking bat_fullcalendar bat_event_ui -y
```

Each submodule has its own documentation under `modules/<name>/11.0.x/`; check
those for the entity-specific permissions and configuration.

## Verify it worked

Log in as an administrator and confirm the **Bat** section appears at `/admin/bat`
(and in the toolbar), with **Configuration** and **Group** subsections. Then set
your date formats at **`/admin/bat/config/date`** — see
[Configuration](../configuration/index.md).
