Year Only adds a single-value `yearonly` field type that collects and stores only the year portion of a date, presented to editors as a select list of years bounded by a configurable range.

---

Year Only provides one field type (`yearonly`) plus its default widget (`yearonly_default`, a "Select Year" dropdown) and default formatter (`yearonly_default`, prints the raw year). The stored value is a single integer `value` column, so there is no month/day/time to manage. Per-field settings define the valid range with two keys: `yearonly_from` (a minimum year, e.g. `1900`) and `yearonly_to` (a maximum year, given as a specific year like `2030`, the literal `now` for the current year, or a PHP relative format like `+5 years` / `-1 year`). The widget builds its option list by expanding that range and can sort years ascending or descending. A validator enforces that the resolved minimum is less than the resolved maximum. The module has no admin settings page and no permissions — everything is configured on the field itself through the standard Field UI. It also ships a Feeds target plugin so a year-only field can be populated during a Feeds import (when the Feeds module is present).

---

- Store a person's birth year without capturing a full date of birth.
- Record the model year of a vehicle in a classifieds or inventory content type.
- Capture the founding/establishment year of a company or organization.
- Track the release year of a book, album, film, or game in a catalog.
- Let editors pick a copyright year from a bounded dropdown.
- Record the graduation year on an alumni profile.
- Capture the vintage year of a wine in a product catalog.
- Store the construction year of a building in a real-estate listing.
- Record the year a historical event occurred, using a wide range like `530` to `now`.
- Limit a "year of manufacture" field to `1980`–`now` so editors can't enter impossible values.
- Provide a future-facing "target year" field with `yearonly_to` set to `+10 years`.
- Capture an expected completion year for a project with `now` to `+5 years`.
- Store the season/edition year for a recurring event or festival.
- Record the year a certification or license was obtained.
- Track the year a patent was filed or granted.
- Offer a descending year picker (newest first) for recent-year selections like "purchase year".
- Store the year a photograph or artwork was created in a media archive.
- Record the enrollment year for students in an education site.
- Capture the year a warranty expires using a relative `+N years` upper bound.
- Provide a compact single-select year input instead of a full date field where day/month are irrelevant.
- Populate a year-only field from an external CSV/feed via the bundled Feeds target.
- Sort or filter content by a clean integer year value in Views (the value is stored as an int).
- Restrict a "founded year" field to a plausible historical window to keep data clean.
- Show only the year on rendered pages while still using a native select widget for entry.
- Collect the year a membership started on a subscription profile.

