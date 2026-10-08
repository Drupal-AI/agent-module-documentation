# Configuration

Recurring Dates Field is configured in two places: a small site-wide screen for
**interpreters** (the plain-language summaries), and the **per-field settings**
you set when you add a Recurring date field to a content type. There is no single
"main settings" form — most of the important choices are made on the field
itself.

## Recurring date interpreters (the site-wide screen)

Go to **Configuration → Regional and language → Recurring date interpreters**
(`/admin/config/regional/recurring-date-interpreters`). This requires the
**Manage date recur interpreters** permission (`date_recur manage
interpreters`).

An *interpreter* turns a raw recurrence rule into readable text such as "Weekly
on Monday, until 31 December". Each interpreter you create here is a reusable
configuration entity that fields can then reference in their formatter. The
module ships one interpreter plugin, **RL** (`rl`), and optionally installs a
ready-made `default_interpreter` you can use straight away.

The RL interpreter has a few options, including whether to show the start date,
whether to show the "until" end, the date format to use, and how to phrase
infinite rules. If you run multiple languages, you can create one interpreter per
language so summaries appear in the right language.

## Per-field settings

Add a **Recurring date** field to a content type through **Structure → Content
types → *(your type)* → Manage fields**. Two levels of settings then apply.

### Storage settings

- **Date type** — inherited from Datetime Range: store a *date* only or a *date
  and time* (`datetime`).
- **Maximum RRULE length** — an optional cap on how many characters the stored
  repeat rule may contain. Leave it empty for no limit.

### Field settings (per content type)

- **Precreate interval** — for rules that repeat forever ("infinite" rules), this
  ISO-8601 duration (default `P2Y`, meaning two years) controls how far into the
  future occurrences are pre-generated into the cache table. A longer window
  means more dates are ready to query up front.
- **Parts (the allow grid)** — this is where you decide *what editors are allowed
  to enter*. You can allow everything, or restrict it frequency by frequency. For
  each frequency (Secondly, Minutely, Hourly, Daily, Weekly, Monthly, Yearly) you
  choose:
  - **Disabled** — editors cannot use this frequency at all.
  - **All parts** — editors may use every rule part with this frequency.
  - **Specify parts** — you pick exactly which parts (Interval, Count, Until,
    By-day, By-month-day, and so on) are permitted.

  For example, to let editors build only "every N weeks on chosen weekdays"
  rules, enable **Weekly** with the *Interval*, *By-day*, *Count* and *Until*
  parts and disable the other frequencies. The module also enforces RFC 5545's
  own rules about which parts are legal with which frequency, so invalid
  combinations are rejected on save.

### Widget

The default **Simple Recurring Date** widget shows start/end date fields plus a
text area for the repeat rule, filtered to only the parts you allowed above.

### Formatter

The default **Date recur basic** formatter has these options:

- **Show next N occurrences** — how many upcoming dates to list (default 5).
- **Count per item** — whether the "next N" count applies per field value.
- **Occurrence date format** / **Same end date format** — which core date format
  to use when printing occurrences (default *medium*).
- **Interpreter** — which of the interpreters you created above to use for the
  human-readable summary of the rule. Leave it unset for no summary.

## Views

When you display generated occurrences in a listing, the module provides a
**Recurring date occurrences** Views filter (filter results by occurrence date)
and a **Recurring date** Views field, both operating on the per-field occurrence
table. This is how you build calendar or agenda pages.
