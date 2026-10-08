<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Link Formatter Query Fix provides a patched LinkFormatter for the link field type, correcting query-string handling in link output.

---

Link Formatter Query Fix provides a patched version of core's Link field formatter that corrects
query-string handling — addressing a case where the default LinkFormatter mishandles query parameters in
link field output. It depends on core Link. It is essentially a bug-fix formatter for link fields until/
unless the fix lands in core.

Use it where link fields with query strings don't render correctly with the default formatter. It is a
content-display/formatter feature affecting link output; the stored value is unchanged and it has no
access-control role. Select the patched formatter on the link field's display.

---

- Fix query-string handling in link output.
- Patch the core Link formatter.
- Render link query params correctly.
- Depend on core Link.
- Provide a bug-fix formatter.
- Handle links with query strings.
- Not change stored values.
- Have no access-control role.
- Select the patched formatter.
- Correct link rendering.
- Apply to link fields.
- Fix formatter query handling.
- Improve link output.
- Use until the core fix lands.
- Configure on the field display.
- Render query strings.
- Patch link formatting.
- Handle link fields.
- Fix the LinkFormatter.
- Correct query output.
