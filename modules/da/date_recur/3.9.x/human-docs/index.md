# Recurring Dates Field — manual setup guide

**Recurring Dates Field** (`date_recur`) adds a field type that stores a
*repeating* schedule in a single field. Instead of creating one node per
occurrence of a recurring event, you store the start/end date once together with
a repeat rule — "every Tuesday and Thursday at 18:00", or "the first Monday of
each month" — and the module works out every concrete date the rule produces.

Under the hood it extends core's Datetime Range field with an extra `rrule`
column that holds an RFC 5545 (iCalendar) recurrence rule, plus a timezone and a
derived "infinite" flag. When you save content, the module expands the rule into
individual occurrences and writes them to a per-field occurrence table, so those
dates can be queried and listed in Views. Editors type the rule using the
*Simple Recurring Date* widget, and the *Date recur basic* formatter shows the
next few upcoming occurrences along with a plain-language summary of the rule.

The plain-English summaries are produced by **interpreter** plugins, which you
manage as configuration entities at **Configuration → Regional and language →
Recurring date interpreters**. That is the only site-wide settings screen the
module adds; everything else is configured per field on the content type where
you add the field. The module relies on the `rlanvin/php-rrule` PHP library,
which Composer installs for you.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and note the optional submodule.
2. [Configuration](configuration/index.md) — the interpreter settings screen and
   the per-field options (frequencies, parts grid, formatter).

## Where it lives in the admin menu

The module's own settings screen — the list of recurring date interpreters —
sits at **Configuration → Regional and language → Recurring date interpreters**
(`/admin/config/regional/recurring-date-interpreters`). Everything else lives
inside **Structure → Content types → *(your type)* → Manage fields** once you
add a Recurring date field.

## How to use it

1. Add a **Recurring date** field to a content type (or any fieldable entity)
   through Manage fields, just like any other field.
2. On the field's settings, decide which recurrence frequencies and parts
   editors are allowed to use (see [Configuration](configuration/index.md)).
3. When creating content, editors fill in the start/end date and a repeat rule
   in the *Simple Recurring Date* widget.
4. On display, the *Date recur basic* formatter lists the next occurrences and a
   readable summary. To build calendars or agendas, expose the generated
   occurrences through Views.
