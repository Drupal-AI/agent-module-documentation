# LocalGov Microsites Colour Picker Fields — manual setup guide

**LocalGov Microsites Colour Picker Fields** (`localgov_microsites_colour_picker_fields`)
adds a **colour-picker widget** to the fields that define colours on LocalGov Drupal
**Microsites**. Instead of asking a microsite editor to type a hex code, it gives them
a visual picker to choose the branding and theming colours for their microsite — a
friendlier, less error-prone way to set colours.

This is a content-editing convenience: the chosen colour is authored data used to
theme a microsite, and the module has no access-control role. It is designed for the
LocalGov Microsites platform (part of the wider **LocalGov Drupal** distribution) and
is most often used together with the microsites group and live-preview modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it.

There is **no configuration page** for this module — it simply provides a field widget
that appears where colour fields are configured. Its use is described under "How to
use it" below.

## Where it lives in the admin menu

The module adds no admin settings page of its own (`configure` is `null`). The colour
picker appears as a **field widget** — you select it under **Manage form display** for
the relevant colour fields (on a LocalGov Microsites platform these are already wired
up for you), and editors then see the picker when they edit a microsite's design.

## How to use it

1. Install and enable the module on a LocalGov Microsites site (see
   [Installation](installation/index.md)).
2. The colour picker is applied to the microsite colour fields. If you are configuring
   fields yourself, choose the colour-picker widget under the relevant bundle's
   **Manage form display**.
3. Microsite editors then pick colours visually when editing their microsite's
   design, rather than typing hex values. The result is stored and used to theme the
   microsite.
