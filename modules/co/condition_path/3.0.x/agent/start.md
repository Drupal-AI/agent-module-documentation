# Condition path — agent index

Provides one Condition plugin, **Request Path Include Exclude** (`request_path_inclexcl`), that includes
AND excludes paths in a single visibility rule (core's Request Path is whitelist-only or blacklist-only).
No admin settings page (`configure` null), no permissions, no Drush. Config schema for the `pages` string.

- **The plugin: `pages` syntax, `!` exclude prefix, ordering/last-match-wins, `<front>`/`*`, where config
  lives, programmatic use** → [configure/visibility.md](configure/visibility.md)

Key facts:
- Plugin id `request_path_inclexcl`, class `RequestPathInclexcl extends system RequestPath`.
- Each *Pages* line is a pattern; leading `!` = exclude. Groups of consecutive include/exclude lines are
  matched in order; the **last matching group wins**, so put more specific paths lower.
- Matches internal path and alias (lowercased); supports `<front>` and `*`. Honors the `negate` flag.
- Instance config stored on the host entity as `condition.plugin.request_path_inclexcl` → `pages` (string).
- `hook_form_block_form_alter` relabels it to "Pages (include and exclude)" on block forms.
