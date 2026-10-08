# Dblog Time Filter — manual setup guide

**Dblog Time Filter** (`dblog_time_filter`) makes Drupal's *Recent Log Messages*
report easier to work with by adding quick, relative time-range filtering. Core's
report at `/admin/reports/dblog` lets you filter by type and severity, but not by
time — so narrowing down to "what happened in the last ten minutes" means scrolling
or fiddling with dates. This module adds a simple **Select** dropdown to the log
report's exposed filter form with common relative ranges such as *Last 10 minutes*,
*Last hour*, and *Last day*, so you can jump to recent events in one click.

It also adds a **live server clock** just above the filter form that updates every
second (using a client-side offset). That gives you a consistent time reference for
correlating log entries with events, regardless of what your own machine's clock
says. Along the way it tightens the filter form's layout for a cleaner debugging
view.

The module works automatically once enabled — there is nothing to configure. It
adds no permissions of its own; the log report is already gated by core's *access
site reports* permission, so it has no access-control role. Two things worth noting:
it deliberately **alters a core feature** (the watchdog View's exposed form), and
the maintainer intends it as a **temporary, high-value stop-gap** — if these
features are ever adopted into Drupal core, the module will be deprecated in favour
of the native solution.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** for this module — it has no settings form and
works the moment it is enabled.

## Where it lives in the admin menu

There is no admin page to visit. The new time-range dropdown and the live server
clock appear directly on **Reports → Recent log messages**
(`/admin/reports/dblog`).

## How to use it

Enable the module, then open **Reports → Recent log messages**. You'll see a live
server clock above the filters and a new time-range dropdown in the exposed filter
form. Pick a range (for example *Last hour*) to instantly narrow the log to entries
from that period — no need to calculate or type timestamps.
