<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User Reference filter is a text-format filter that lets content editors link to users by typing an `@` followed by a username (an @-mention).

---

The filter (`Drupal\userref\Plugin\Filter\UserRef`, id `userref`, type TRANSFORM_IRREVERSIBLE) scans text with a Unicode-aware regex, and for each `@name` match it first tries `user_load_by_name()`; if there is no exact match it runs a fallback lookup that strips spaces, dots, underscores and hyphens (`REGEXP_REPLACE` in a parameterized query on `users_field_data`). A match is rendered with `Link::fromTextAndUrl()` to the user's canonical page, so output is auto-escaped. Unmatched `@tokens` are left untouched.

Operationally: enable the filter on a text format and place it appropriately in the filter pipeline. The DB lookup uses a bound parameter (no SQL injection) and links render through the escaped Link API (no XSS). No routes, permissions, or external calls.
---
- Enable the User Reference filter on a text format
- Let editors mention users with @username
- Auto-link @mentions to user profile pages
- Match usernames containing accents/Unicode letters
- Fall back to a relaxed match ignoring spaces/dots/underscores/hyphens
- Reference users in comments (via the format)
- Reference users in node body fields
- Keep non-matching @tokens as plain text
- Show the user's display name in the generated link
- Order the filter after/before other filters as needed
- Provide social-style mentions without a heavy module
- Use in any long-text field using the enabled format
- Combine with a restricted HTML format
- Link to users by exact name first for accuracy
- Mention users in forum posts (via the format)
- Cross-reference authors within articles
- Add the filter to a custom text format
- Position the filter relative to Limit HTML/Convert URLs
