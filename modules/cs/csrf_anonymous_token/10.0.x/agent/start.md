<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# csrf_anonymous_token — agent orientation

Tiny module (only `.module`) that tries to add CSRF tokens to anonymous forms via `hook_form_alter`.

- Adds `anon_token` element + prepends validator `anonymous_token_validate_anon_token`.
- CAVEAT: the validator's `!== null` check can error on valid submissions.
- No config, no routes, no permissions. Global effect on all tokenless forms.
- Can break legitimate anon submissions.
- File: `csrf_anonymous_token.module`.
