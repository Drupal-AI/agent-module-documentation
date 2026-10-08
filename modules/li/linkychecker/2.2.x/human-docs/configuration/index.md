# Configuration

Linkychecker's job is to check the links held in Linky entities and record their
status. This page covers how checking behaves, how to run checks, and where to see
the results.

## Checking behaviour

By default Linkychecker:

- **Checks a link when it is created.**
- **Re-checks links on an interval**, so their status stays current over time.
- Lets you **check links on demand** when you want an immediate result.

Configure the checking behaviour in the module's settings, then save. Because
re-checks and scheduled runs make outbound HTTP requests, keep the interval
reasonable — a checker that hammers external sites is indistinguishable from a
scraper (see the note below).

## Running checks

- **On cron / on a schedule** — the usual way to keep statuses fresh without
  manual effort.
- **On demand** — trigger a check for a link when you need an up-to-date result.
- **With Drush** — the module provides Drush commands, which are the right tool
  for running checks in bulk or from automation. Run `drush list` (or check the
  module's own documentation) to see the available `linkychecker` commands.

## Permissions

Grant Linkychecker's permissions at **People → Permissions**
(`/admin/people/permissions`) to the roles that should configure checking and see
results. The module has no access-control role beyond these permissions.

## Viewing results

The recorded status of each link is available both individually and as **Views
fields**. Add those fields to a View to build a broken-links report or to show a
status column in a listing of your Managed Links.

## A note on outbound requests

Checking a link means requesting the linked URL from your server. That is normal
link-checker behaviour, but it is real traffic to other people's sites — so run
checks on a sensible schedule and avoid excessively frequent re-checks. Running
via cron or Drush at a reasonable cadence is the recommended approach.
