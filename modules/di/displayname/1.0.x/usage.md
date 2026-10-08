Display Name adds a multi-component "display_name" field type that stores a person's name as separate parts and renders it through a configurable format pattern, optionally replacing the core username.

---

The module defines a `display_name` field type whose storage holds six columns (title, first, middle, last, full, alias). A component widget (`display_name_default`) collects each enabled part with per-component labels, sizes, select/autocomplete inputs, and a stacked or inline layout. The `display_name_default` formatter renders the stored parts using a compact format string (tokens such as `t`, `f`, `l`, `p`, plus modifiers and conditionals parsed by `DisplayNameFormatParser`), with a choice of markup styles (no markup, raw, component-class spans, RDFa, or microdata) and an optional link target. It also ships a Views fulltext filter (`display_name_fulltext`) that searches across all name columns, a Feeds mapping target, an autocomplete controller backed by configured option sources, and format/list-format config entities. When a `display_name` field is attached to the user entity, the module can override the rendered username with the formatted display name through `hook_user_format_name_alter()`, tracking which field to use in the `displayname.settings` config object.

---

- Store a user's real name as structured parts (first, middle, last) instead of a single free-text field.
- Add a "display_name" field to the User entity so profiles capture a full name plus a nickname.
- Override the site's rendered username with a formatted real name across nodes, comments, and author links.
- Let members enter a preferred display name that shows instead of their login account name.
- Capture an academic or honorific title (Dr., Prof.) as a selectable component in the name widget.
- Display names in "First Last" on profiles but "Last, First" in an administrative Views listing via different formatter formats.
- Render only initials (for example `J. R. R.`) using the initials tokens in the format string.
- Show a nickname in parentheses after the full name using the alias component and conditional format tokens.
- Wrap each name component in a `<span>` with its component class for CSS styling.
- Emit schema.org microdata (`itemprop="givenName"` etc.) or RDFa properties around name parts for structured data.
- Provide autocomplete suggestions for title/first/last inputs sourced from an option list or a taxonomy vocabulary.
- Populate title options from a taxonomy vocabulary using the `[vocabulary:machine_name]` token in field settings.
- Enforce a minimum set of required components (for example require both first and last, or allow either one).
- Add a Views fulltext filter that matches a search term against any part of the stored name (contains, any word, all words).
- Link a rendered display name to the user's canonical entity URL or to a referenced entity or link field.
- Import display names from a CSV or remote feed by mapping columns to name components with the Feeds target.
- Present the widget inline (all components on one row) or stacked, per field or per form display.
- Override shared field settings on a specific form display so one form shows fewer components than another.
- Combine a preferred-name field and an alternative-name field into the rendered output via the additional-component references.
- Generate a computed "full" name at save time from the individual parts when no full name is entered.
- Gate the "Change own display name" capability with a dedicated permission.
- Show "et al." style truncated lists when a multi-value name field renders several entries.
