<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# First Time Login — agent index

**Prompts a user to update their password on first login** (after admin-created/imported accounts; password
hygiene). Version **3.1.2**. Core `^8||^9||^10||^11`.

Security-adjacent onboarding — acts via `hook_user_login()` (post-auth), guides the logged-in user to change the
password (treat admin-set initial passwords as temporary; ensure the change is required). No access role.
