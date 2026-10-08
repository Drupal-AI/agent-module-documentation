EDTF adds a Drupal field type that stores and displays dates in the Extended Date/Time Format (ISO 8601-2), supporting uncertain, approximate, partial, seasonal and interval dates that ordinary date fields cannot express.

---

The Extended Date/Time Format module provides an `edtf` field type backed by the ProfessionalWiki/EDTF PHP library. Instead of a single fixed timestamp, an EDTF field stores a compact string that can represent varying precision (year, year-month, full date, date-time), uncertainty (`2023?`), approximation (`2023~`), unspecified digits (`202x`, `2023-12-XX`), seasons and intervals (`2023-12-01/2023-12-24`). Values are captured with a validating textfield widget that rejects malformed EDTF, and displayed with either a "Plain" formatter (the raw string) or an "EDTF Humanizer" formatter that renders a human-readable, language-aware phrase. The module also exposes field tokens (`year`, `year_period`, `humanized`) and Twig filters (`edtf_validate`, `edtf_humanize`, `edtf_year`, `edtf_year_period`, `edtf_min`, `edtf_max`) for use in templates and token-aware contexts. It is widely used in archival, library, museum, genealogy and historical-collection sites where dates are frequently imprecise. Core `^9 || ^10 || ^11`, PHP `>=8.1`.

---

- Record the date of a historical photograph whose exact day is unknown (`1923-06-XX`).
- Store an archival accession date that is only known to a decade (`192x`).
- Capture an uncertain publication year for a manuscript (`1876?`).
- Mark an approximate creation date for an artwork (`1600~`).
- Combine uncertainty and approximation for a museum object (`1600%`).
- Represent a date range / interval such as an exhibition run (`2024-05-01/2024-08-31`).
- Store an open-ended interval, e.g. "from 2020 onward" (`2020/..`).
- Express a season rather than a month for a periodical issue (`2023-21` for Spring 2023).
- Model a birth date known only to the year in a genealogy site (`1901`).
- Keep a precise UTC timestamp when it is known (`2023-12-24T18:00:00Z`).
- Provide a validated editor input that blocks non-EDTF strings before save.
- Display collection dates in readable prose via the EDTF Humanizer formatter.
- Show the raw EDTF string verbatim with the Plain formatter for cataloguers.
- Localize humanized output to the visitor's current language automatically.
- Render just the year of an EDTF value in a listing using the `year` token.
- Produce a decade label like `19XX` from an imprecise date with the `year_period` token.
- Insert a humanized date into an email or node title pattern via the `humanized` token.
- Validate an EDTF string inside a Twig template with `{{ value|edtf_validate }}`.
- Humanize a value directly in a custom template with `{{ value|edtf_humanize }}`.
- Compute the earliest/latest UNIX timestamp of a fuzzy date for sorting with `edtf_min` / `edtf_max`.
- Drive a timeline or facet from the min/max bounds of imprecise dates.
- Add EDTF dates to any fieldable entity (nodes, media, taxonomy terms, custom entities).
- Attach multiple EDTF values to one entity (multi-value date field) for objects with several key dates.
- Migrate legacy imprecise date strings into a structured, queryable field.
- Support library/museum metadata standards that mandate EDTF (LoC datetime standard).
- Build Views that display or expose EDTF dates using the module's formatters and tokens.
