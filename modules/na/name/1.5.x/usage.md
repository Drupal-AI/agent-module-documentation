<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Name Field adds a `name` field type that stores a person's name as six discrete components (title, given, middle, family, generational suffix, credentials) and renders them through configurable, pattern-based "name format" config entities.

---

The module registers a compound `name` field type whose storage has six varchar columns, paired with a `name_default` widget ("Name components") and a `name_default` formatter ("Name formatter"). Per field you choose which components are enabled, which are required (minimum components), their max lengths, widget sizes, title/generational select options, and autocomplete sources. Output is driven by "name format" config entities (`name_format`), each holding a `pattern` string built from single-letter tokens — `t` title, `g` given, `m` middle, `f` family, `s` generational, `c` credentials, `i`/`j`/`k` the three separators, plus initials, conditionals, and case modifiers — assembled with a `+` conditional operator so separators collapse around empty components. It ships default formats (default, full, family, given, formal, short_full) editable at `/admin/config/regional/name`, and `name_list_format` entities that join several names into an "A, B and C" (or "et al") list. A settings form at `/admin/config/regional/name/settings` sets the global separators (`sep1`/`sep2`/`sep3`) and the required-component marker, and a name field on the User entity can override the account's login/display name. Programmatic formatting is available through the `name.formatter` and `name.format_parser` services, sample data through `name.generator`, and layouts are extensible via `hook_name_widget_layouts()`.

---

- Store structured personal names (title, given, middle, family, suffix, credentials) instead of one plain text field.
- Capture author names on articles so they can be re-formatted (full name, family-first, initials) per view mode.
- Show "Family, Given" in a listing view but "Given Family" on the full node using two formatter instances.
- Enable only given + family components for a simple two-box name field.
- Require family and given while leaving title, middle, generational, and credentials optional.
- Add a title dropdown (Mr., Mrs., Dr., Prof.) and a generational dropdown (Jr., Sr., III) to a name widget.
- Render academic credentials (PhD, MD) after the name via the `c` token.
- Build a custom name format pattern such as `f, g` to output "Smith, John".
- Produce initials-only output (`I`, `J`, `K`, `M` tokens) for compact bylines.
- Uppercase or title-case a component with the `U`, `L`, `F`, or `G` modifiers inside a pattern.
- Configure the three global separators (space, comma-space, empty) used between name components.
- Override a Drupal user's login/display name with a Name field on the user account.
- Format a list of authors as "Smith, Jones and Doe" using a `name_list_format` entity.
- Reduce a long author list to "Smith et al." with the list format's el-al threshold.
- Format name component arrays in custom code via `\Drupal::service('name.formatter')->format($components, 'full')`.
- Parse a raw component array against an arbitrary pattern with the `name.format_parser` service.
- Generate realistic sample names for tests or demos with the `name.generator` service.
- Wrap output in microdata or RDFa itemprop markup by choosing the formatter's markup mode.
- Add an "inline" widget layout via `hook_name_widget_layouts()` to lay components out on one row.
- Autocomplete title/generational values from configured option lists as editors type.
- Attach a name field to any fieldable entity — content types, users, taxonomy terms, media.
- Link the rendered name to the parent entity (e.g. the user profile) via the formatter's link target.
- Set per-component maximum lengths to constrain very long family or credential strings.
- Migrate legacy first/last name columns into a single name field using the provided migrate process plugin.
- Give each component a custom label (e.g. "Surname" for family) on the widget.
- Present a formal salutation format ("Dr. John Smith") separate from an informal given-name-only format.
- Mark required name components with a configurable asterisk marker across all name widgets.
- Expose a name field's family component to Views full-text filtering.
- Reuse one name format across many fields and change every rendering by editing a single config entity.
