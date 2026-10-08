<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Regex Functions adds a Views field handler and a Views filter handler that let a site builder run PHP regular-expression operations against other fields' rendered output inside a view.

---

The **field** (`views_regex_functions_field`) takes a regex **pattern**, a **search subject** (built from other fields via `{{ field_id }}` replacement tokens), and a **replacement**; at render time it substitutes the referenced field's rendered value into the subject and returns `preg_replace($pattern, $replacement, $subject)`. Optional *strip tags* / *allowed tags* clean the source field first. The **filter** (`views_regex_functions_filter`) uses a pattern + a single `{{ field_id }}` subject and, in `hook_views_post_execute`, removes rows depending on whether the pattern matches (with a *Remove rows with pattern* toggle). The filter **cannot be exposed** (`canExpose()` returns FALSE), and its subject box is validated to contain only one replacement token — so the regex and inputs are admin configuration, not visitor input.

Operational/security notes: patterns are validated in the form with `@preg_match($pattern, '')` to reject invalid expressions, and are supplied only by users with *administer views*. There is no `/e` (eval) modifier support in modern PHP and no request-supplied regex, so there is no preg-injection or user-driven ReDoS surface; a careless admin could still write an expensive pattern (trusted-role concern). Typical setup: add the field/filter to a view, reference other fields with `{{ id }}` tokens, and set the pattern/replacement.

---

- Reformat a field's output with a regex replacement in Views
- Extract a substring from a field via a capture-group replacement
- Combine multiple fields into one via `{{ id }}` tokens then regex
- Strip or transform parts of rendered field text
- Mask/redact values matching a pattern in a view column
- Rewrite URLs or codes shown in a view
- Add a computed regex-derived column to a view
- Filter out rows whose field matches a regex
- Keep only rows whose field matches a regex (Remove rows off)
- Strip HTML tags from the source field before matching
- Allow specific HTML tags when stripping the source field
- Normalize phone numbers / IDs for display
- Reference an earlier field's value in the regex subject
- Validate the regex pattern in the Views UI before saving
- Build a derived label from concatenated field tokens
- Remove rows lacking a required text pattern
- Post-process view results without altering the SQL query
- Apply presentation-only regex transforms (no DB write)
