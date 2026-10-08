<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WissKI Edit Layout (wisski_editlayout) — agent index

Submodule of **wisski**. Replaces the standard entity edit form with a **denser layout**.
Version **8.x-4.3**. Core `>=10.4 <12`.

A record modelled against a serious ontology has many fields; Drupal's default one-field-per-row
layout makes the form several screens long, and a cataloguer working through hundreds of objects
spends a measurable part of the day scrolling.

**Worth naming as a category:** an editor writing three articles a week does not care about form
density; a cataloguer entering their four-hundredth object does. Treat form ergonomics as a
**requirement** on a system supporting cataloguing work.

Check it against the fields the pathbuilder actually produces — density helps most with many short
fields.