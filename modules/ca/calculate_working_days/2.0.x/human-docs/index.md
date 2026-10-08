# Calculate Working Days — manual setup guide

**Calculate Working Days** (`calculate_working_days`) is a business-calendar
utility for working out how many *working* days fall between two dates — or the
date you reach after a given number of working days — while skipping weekends,
fixed holidays, and one-off occasions you define. It is the kind of building
block you reach for when estimating delivery dates, calculating SLA deadlines,
or driving any logic that has to count business days rather than calendar days.

You describe your organisation's calendar once on a settings form: which
weekdays are free (Saturday and Sunday, say), recurring annual holidays, single
-year holidays, and named "occasion" free days. The module stores that calendar
and applies it whenever you call one of its helper functions.

Most of its value is for developers: it exposes a small `CalculateWorkingDays`
value object and a handful of procedural wrapper functions
(`calculate_working_days_get_work_days()`, its monthly variant, and so on) that
other code can call to count working days, find an end date, or list the working
and free days of a month. The functions take UNIX timestamps and validate their
inputs; they do no database queries or external calls of their own.

**Important security note:** in this version the settings form is registered
with only the "access content" permission, which anonymous visitors have by
default — so the admin form is effectively public, and any visitor could load
it and overwrite your weekend/holiday configuration. Before you rely on this
module, re-gate the route to require "Administer site configuration" (or a
dedicated permission). This is covered in [Configuration](configuration/index.md).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the working-days settings form,
   plus the access-control fix you should apply first.

## Where it lives in the admin menu

The settings form sits at **Configuration → Regional and language → Calculate
Working Days** (`/admin/config/regional/calculate-working-days`). Its values are
stored in the `calculate_working_days.settings` config object.

## How to use it

Set up your calendar on the settings form, then call the module's helper
functions from custom code to count working days, project an end date, or list a
month's working and free days. The datepicker on the form also lets you preview
free days interactively.
