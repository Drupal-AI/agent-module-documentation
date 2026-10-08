# Taarikh — manual setup guide

**Taarikh** (`taarikh`) lets your editors enter dates using the Hijri (Islamic)
calendar and lets your site display them the same way — all on top of Drupal
core's ordinary date fields. It does *not* add a new field type. Instead it
provides a widget (for entering a Hijri date) and a formatter (for showing one),
which you switch on for any existing core **Date** (`datetime`) field. Underneath,
the value is still stored as a normal Gregorian date in the database, so you can
turn Taarikh on or off, or mix Gregorian and Hijri displays, without ever losing
or converting your stored data.

The clever part is the conversion itself. Turning a Gregorian date into a Hijri
one (and back) can be done with different astronomical or arithmetic algorithms,
and Taarikh treats that as a pluggable choice: it ships with a **Fatimid
Astronomical** algorithm as the default, and a developer can add their own
conversion algorithm as a plugin. It also exposes reusable form elements
(`TaarikhDate`, `TaarikhDatetime`) that developers can drop into their own custom
forms.

Taarikh is a pure field-and-UI layer. It has no configuration page of its own, no
routes, no permissions, and it never makes outbound network calls — so there is
nothing site-facing to lock down. Its only dependency is core's **Datetime**
module, which Drupal enables for you. Once enabled, you configure it entirely on a
field's *Manage form display* and *Manage display* tabs.

This guide is written for a **human** setting the module up through the admin UI.
If you are an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead — they are terser and token-cheaper.

## Contents

1. [Installation](installation/index.md) — install with Composer, add the
   required jQuery Calendars library, and enable the module.

## How to use it

Taarikh works per field, so there is no central settings page — you switch the
widget and formatter on each date field you want in the Hijri calendar:

- **To let editors enter a Hijri date**, go to the entity's **Manage form
  display** tab, find your date field, and change its widget to *Taarikh date and
  time*.
- **To show a stored date in the Hijri calendar**, go to the **Manage display**
  tab, find the same field, and change its formatter to *Taarikh date and time*.
  In the formatter settings you can pick which conversion **algorithm** to use and
  the date **format**.

A useful thing to remember: the widget and formatter are independent. If you only
switch the *widget*, editors can type dates in Hijri but the site will still
*display* them in Gregorian — so for a fully Hijri experience set both. Because
storage stays Gregorian, you can safely present the same underlying date in Hijri
on one display and Gregorian on another.
