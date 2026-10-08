Date/Time Format Help adds an inline PHP `date()` format cheat-sheet directly onto Drupal's "Add date format" administration form.

---

The module is a tiny, dependency-free admin convenience. When you build a custom date/time format at `/admin/config/regional/date-time/formats/add`, Drupal asks for a PHP `date()` pattern (like `Y-m-d H:i`) but ships no on-page reference for the format characters. Date/Time Format Help alters that form to append a set of tables — grouped by Day, Week, Month, Year, Time, Timezone and Full Date/Time — listing each format character, a short description copied from the PHP manual, and a live example rendered with the current server time via `date($char)`. It also rewrites the pattern field's description to link to the PHP manual. There is no configuration, no permission, no route, no service and no stored data; it is purely a form/render-layer helper for site builders and administrators. Implementation is a single `hook_form_FORM_ID_alter()` in `date_format_help.module` plus a `#type => date_format_help` render element (`src/Element/DateFormatHelp.php`) that emits the tables and attaches a small two-column CSS layout library.

---

- Look up PHP `date()` format characters without leaving the "Add date format" admin page.
- See a live example of every format character rendered against the current server date/time.
- Remember whether `m` means month or minutes while building a custom format pattern.
- Distinguish `g`, `G`, `h`, `H` (12/24-hour, with/without leading zeros) at a glance.
- Recall the difference between `Y` (4-digit year), `y` (2-digit), `o` (ISO-8601 year).
- Find the right day token: `d`, `D`, `j`, `l`, `N`, `S`, `w`, `z`.
- Find the right month token: `F`, `m`, `M`, `n`, `t`.
- Build time patterns with `a`/`A` (am/pm), `i` (minutes), `s` (seconds), `u` (microseconds).
- Pick timezone tokens: `e`, `I`, `O`, `P`, `T`, `Z`.
- Use full-date shortcuts `c` (ISO 8601), `r` (RFC 2822), `U` (Unix timestamp).
- Follow the added link to the PHP `datetime.format` manual page for edge cases.
- Onboard new site builders who aren't fluent in PHP date syntax.
- Reduce trial-and-error when defining formats used by the Date, Views or field-display layers.
- Provide a consistent in-context reference across a team creating many custom formats.
- Confirm ISO-8601 week (`W`) and Swatch Internet time (`B`) tokens exist and what they output.
- Serve as a lightweight example of adding a custom render element (`#type`) via a `RenderElement` plugin.
- Serve as an example of using `hook_form_FORM_ID_alter()` to enrich a core admin form.
- Install on a documentation/authoring site so editors defining date formats have guidance inline.
- Keep the reference on the same page where the pattern is typed, avoiding tab-switching to php.net.
