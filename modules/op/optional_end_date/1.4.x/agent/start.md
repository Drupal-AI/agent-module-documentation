# optional_end_date — agent start

Makes the end date of a core **Date range** (`daterange`) field optional. Alters the
`daterange` field type, widgets, and formatters so `end_value` can be left blank. No admin
settings page — you opt in per field via an **"Optional end date"** checkbox on the field's
**Storage settings**. Depends on core `datetime_range`.

- Make a daterange field's end date optional (storage setting, widgets, formatters, validation)
  → [configure/optional_end_date.md](configure/optional_end_date.md)
