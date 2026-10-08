# Recurring Period — manual setup guide

**Recurring Period** (`recurring_period`) is a developer building block, not a
feature you configure and use directly. It provides a **plugin type** for
defining recurring time periods — things like "every 6 months" or "every year on
January 1" — and a small, consistent way to ask a configured period: *given this
start date, when does the period end?*

Different plugins model different behaviours. A **fixed** period aligns to
calendar boundaries (for example, the first of every month), a **rolling** period
counts forward from a given start date, and an **unlimited** period never ends.
The specifics — the interval and any anchor — live in each plugin's
configuration, so other modules can store a period definition and later hand it a
start date to calculate the corresponding end date.

Recurring Period was built to underpin **Commerce License** and **Commerce
Recurring**, where subscription and licence terms need exactly this kind of
recurrence logic — but it depends on no Commerce modules and can be reused
wherever you need standardised, reusable period calculations (memberships,
bookings, recurring donations, and similar).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its `interval`
   dependency with Composer, and enable it.

There is **no configuration page** for this module — it has no settings form and
adds no admin menu items. It exists to be used by other modules' code, described
in "How to use it" below.

## How to use it

Recurring Period does nothing visible on its own. You install it because another
module requires it (most commonly Commerce License or Commerce Recurring), or
because you are a developer who wants its period plugins.

For developers: the module exposes a plugin manager for the "recurring period"
plugin type. A period plugin is instantiated with its configuration (for example
`every 6 months`), and you then ask it to calculate an end date from a start
date. Fixed, rolling, and unlimited behaviours ship out of the box, and you can
add your own plugin to model a period the built-ins do not cover. Because the
logic is standardised behind the plugin interface, any code that consumes a
configured period works the same regardless of which period type is chosen.

If you installed it as a dependency of a Commerce module, there is nothing
further to do here — configure the period through that module's UI (for example
on a licence or subscription's settings), and Recurring Period does the
calculation behind the scenes.
