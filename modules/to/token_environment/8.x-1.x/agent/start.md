<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Token from Environment (token_environment) — agent index

Exposes **allowlisted environment variables as Drupal tokens**. Version **8.x-1.1**. Core `>=8`.
Config at `/admin/config/system/token-environment`.

**Allowlist by design (good):** admin picks exactly which env vars become tokens — the module does
not blanket-expose the environment (help text: "to ensure Drupal does not get access to any
sensitive data").

**The rule that follows: never allowlist a secret-bearing variable.** A token renders into content,
emails and logs — more exposed than the environment. Allowlist only non-sensitive operational values
(env name, build ID, region).