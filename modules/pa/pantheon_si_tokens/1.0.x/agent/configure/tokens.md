<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring exposed constants

`/admin/config/system/pantheon-si-tokens` (`administer site configuration`) stores a `constants` allowlist.

- `hook_token_info()` publishes each allowlisted constant under token type `pantheon_si_tunnel`; token name is the lowercased constant name.
- `hook_tokens()` returns `constant(strtoupper($name))` only when the name is in the allowlist **and** `defined()`; otherwise empty string.
- Use as `[pantheon_si_tunnel:<name>]` wherever tokens are processed.
- **Caution:** whatever the constant holds is returned verbatim — do not allowlist secrets and then place their tokens in output visible to unprivileged users.
