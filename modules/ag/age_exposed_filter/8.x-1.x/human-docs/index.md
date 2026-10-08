# Age Exposed Filter — manual setup guide

**Age Exposed Filter** (`age_exposed_filter`) adds a Views filter that works on a
person's *age* rather than on a raw date. A date-of-birth field stores a date, but
people think in ages — "members over 65", "applicants aged 18–25". Expressing that
as a date range is awkward and, worse, the correct range keeps shifting as time
passes. This module computes the age from a date field and exposes it as a Views
filter, so the control your visitors see is an age (or an age range) and the module
quietly translates it into the underlying dates.

It works on Date-type fields in Views. It is a query/UI convenience with no
security surface of its own — it only filters what the View already exposes.

**A note on privacy.** Age derived from a date of birth is personal data. A public
listing that can be filtered by age is exposing an inferred attribute of real
people, so this is a data-modelling and privacy decision about your View — confirm
the View's access settings and what it makes visible before exposing an age filter
publicly.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Age Exposed Filter has no settings page of its own; you use it inside Views:

1. Go to **Structure → Views** (`/admin/structure/views`) and edit a View whose
   content has a Date field holding a date of birth (or similar).
2. Add the **Age exposed filter** provided by this module as a filter on that
   date field.
3. Mark the filter **exposed** so visitors can set it, and configure it as an age
   or an age range.
4. Save the View. Visitors now filter the listing by age, and the module converts
   their choice into the appropriate date range behind the scenes.

This is the right control for directories, membership listings, and any content
where age — not a calendar date — is the meaningful axis. Before exposing it on a
public View, double-check the View's access so you are comfortable surfacing an
age-derived attribute of real people.
