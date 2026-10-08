<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pantheon SI Tokens (pantheon_si_tokens) — agent index

**Publishes admin-allowlisted Pantheon Secure Integration PHP constants as `pantheon_si_tunnel` Drupal tokens.**

- **Version:** 1.0.x (1.0.0-beta3)
- **Core:** ^10.1 || ^11
- **Dependency:** token
- **Configure:** `/admin/config/system/pantheon-si-tokens` (`administer site configuration`) — sets the `constants` allowlist.
- **Mechanism:** `hook_token_info()` + `hook_tokens()`; returns `constant($NAME)` for allowlisted, defined constants under token type `pantheon_si_tunnel`.

**Security:** Only constants explicitly allowlisted by an admin are exposed, and only their runtime values are returned. Risk is contextual — a token for a sensitive constant used in content shown to unprivileged users would disclose that value; the admin allowlist is the control. Settings route is permission-gated. See [configure/tokens.md](configure/tokens.md)
