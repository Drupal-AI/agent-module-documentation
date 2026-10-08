# EDTF — manual setup guide

**EDTF** (`edtf`) adds a date field that understands the **Extended Date/Time
Format** — the standard for dates that are *uncertain*, *approximate*, *partial*,
or expressed as *ranges*. It is aimed at archival, library, and scholarly metadata,
where "sometime in the 1920s", "probably 1923", or "December 1st to 24th, 2023"
are perfectly ordinary things to need to record and Drupal's normal date fields
cannot express them.

The field stores its value as an EDTF string and validates/parses it with the
well-regarded `ProfessionalWiki/EDTF` library. A few examples of what an editor can
enter: `2023-12-24` (a full date), `2023-12` (a month), `2023-12-XX` (an unknown
day in December 2023), `202x-12-24` (December 24 in an unknown year in the 2020s),
`2023?` (uncertain year), `2023-12~` (approximately December 2023), and
`2023-12-01/2023-12-24` (an interval).

EDTF is a **field type** — you add it to a content type (or any fieldable entity)
like any other field, and it participates in normal field handling. It has no
content or access-control role of its own, and there is no site-wide settings page:
everything is configured on the field and its display. It works on Drupal 9, 10,
and 11 with no additional module dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. You
set it up by adding an EDTF field to a bundle and choosing a display formatter,
described in "How to use it" below.

## Where it lives in the admin menu

EDTF adds no admin page. You use it from **Structure → Content types → (type) →
Manage fields**, where you add a field of the EDTF type, and from that bundle's
**Manage display**, where you choose how the value is shown.

## How to use it

1. Go to **Structure → Content types → (your type) → Manage fields** and add a new
   field of the **EDTF** type. Give it a label and save.
2. On the bundle's **Manage display**, choose a formatter for the field:
   - **Plain** — shows the EDTF string exactly as stored.
   - **EDTF Humanizer** — renders the value in human-readable form using the EDTF
     library's humaniser (localised to the current language).
3. Create content and enter EDTF values in the field.

### Tokens and Twig helpers

For themers and site builders, the field also exposes tokens and Twig filters for
working with EDTF values:

- **Tokens:** `[node:field_name:year]` (just the year),
  `[node:field_name:year_period]` (the year with `X` for unspecified digits, e.g.
  `19xx`), and `[node:field_name:humanized]` (the humanised form).
- **Twig filters:** `edtf_validate` (is the value valid — boolean),
  `edtf_humanize` (human-readable string), `edtf_year` (the minimum year),
  `edtf_year_period` (year with `X` for unspecified rightmost digits), and
  `edtf_min` / `edtf_max` (the earliest and latest UNIX timestamps the value
  covers). Each returns `null` when the value is not valid.
