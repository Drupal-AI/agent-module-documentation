# Configuration

Hijri Format has two sides: a **settings form** where you decide how Hijri dates
are built and adjusted, and the per‑field **display** settings where you actually
switch a date to Hijri.

## Open the settings form

1. Log in as a user with the appropriate permission (the module provides its own
   permissions — grant them to trusted administrator roles at **People →
   Permissions**).
2. Go to the Hijri settings form, provided as `hijri_format.hijri_settings`, in
   the **Configuration** area.

## What you can control on the settings form

- **Custom date format.** Rather than pick from a fixed list, you build your own
  Hijri date format string (choosing how the day, month name, and year appear).
- **Umm al‑Qura adjustment.** Enable this to nudge the calculated Hijri date to
  match **Umm al‑Qura**, the official calendar of the Kingdom of Saudi Arabia.
  Turn it on if your audience expects Umm al‑Qura dates.
- **Indian (Arabic‑Indic) numerals.** Toggle this to render the numbers in the
  date using Indian numerals instead of Western digits.
- **Multilingual output.** The module is built with translation in mind and does
  not rely on a third‑party library, so month names and labels can be translated
  through Drupal's normal interface translation.

Save the form when done.

## Apply Hijri display to a field

The settings above govern how Hijri dates look; to actually show a field in Hijri:

1. Go to the bundle's **Manage display** tab — for example **Structure → Content
   types → *(your type)* → Manage display**.
2. For a **date field**, or for the **Authored on (created)** / **Changed** dates
   on Nodes and Comments, set the **Format** to the Hijri option.
3. Adjust any per‑field format options offered, then **save**. That date now
   renders in the Hijri calendar on the front end.

## The current‑date block

Hijri Format also provides a **current‑date block** that shows today's date in a
Hijri format you define. Place it like any other block via **Structure → Block
layout**, choosing the region where you want today's Hijri date to appear. You can
add as many as you need, each with its own custom format.
