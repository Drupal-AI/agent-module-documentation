# Field Count Formatter (field_count_formatter) — agent index

One field formatter that outputs the *number* of values in a field (`$items->count()`) instead
of the values themselves — most useful on multi-value fields. Trivial module (~30 lines total):
no config page (`configure` null), no settings form, no config schema, no permissions, no
services, no routes, no plugin types, no dependencies beyond Drupal core. Core: `^9 || ^10 || ^11`.

- **Field formatter** — the one thing it provides: the `count` ("Field count") formatter, how it
  renders, and the hook that offers it for every field type → [fields/count.md](fields/count.md).

Quick use: on *Manage display* (or a Views field's format) set a field's Format to **Field count**.
No options. Empty fields render `0`. No security surface.
