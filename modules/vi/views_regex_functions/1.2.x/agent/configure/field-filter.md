<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using the regex field and filter

Both are added in the Views UI (permission *administer views*). Neither can be exposed to visitors — configuration is admin-only.

## Regex field (`views_regex_functions_field`)
Add it under **Fields**. Options:
- **Pattern** — a full PCRE regex (delimiters + flags), e.g. `/^.*?(\d+).*$/`. Validated on save with `@preg_match($pattern, '')`.
- **Search Subject** — the text to operate on. Use `{{ field_id }}` tokens to inject earlier fields' rendered values (only fields defined *before* this one are offered).
- **Replacement** — replacement string / backreferences (e.g. `$1`). Empty = remove matches.
- **Strip HTML Tags** + **Allowed Tags** — optionally `strip_tags()` the source field first (allowed-tags list is validated to contain only HTML tags).

At render (`render()`): each `{{ id }}` in the subject is replaced by that field's cleaned rendered value, then `preg_replace(pattern, replacement, subject)` is returned. The field runs no SQL (`query()` only sets a field alias).

## Regex filter (`views_regex_functions_filter`)
Add it under **Filter criteria**. Options: **Pattern**, **Search Subject** (exactly one `{{ field_id }}` token — validated), **Remove Rows with Pattern** toggle, plus strip/allowed-tags.

Execution is post-query in `hook_views_post_execute()`: for each result row the pattern is matched against the referenced field's rendered value; with *Remove rows* on, matching rows are removed; off, non-matching rows are removed. It then recomputes `total_rows` and updates the pager. `query()` is intentionally empty so the view SQL is unchanged.

## Tips
- Because tokens reference *rendered* field output, place source fields above the regex field/filter (they may be marked *Exclude from display*).
- Validate patterns carefully — an expensive/backtracking pattern runs per row.
