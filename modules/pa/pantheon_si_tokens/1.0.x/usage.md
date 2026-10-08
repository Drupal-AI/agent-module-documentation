<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Pantheon SI Tokens exposes Pantheon Secure Integration (SI) PHP constants as Drupal tokens.

---

Pantheon's Secure Integration injects connection details (e.g. tunnel host/port constants) into the PHP runtime as constants. This module lets an admin list which constant names should be surfaced (settings form at `/admin/config/system/pantheon-si-tokens`, `administer site configuration`), then implements `hook_token_info()` and `hook_tokens()` to publish each allowlisted constant under the `pantheon_si_tunnel` token type. When a token is evaluated, the module returns `constant(NAME)` for names that are both allowlisted and defined, or an empty string otherwise.

It solves the problem of referencing SI tunnel connection values from configuration that supports tokens (for example when configuring an integration's host/port) without hardcoding them. Security-relevant note for operators: the token replacement returns whatever the named constant contains, so the surface is only as safe as (a) which constants an admin allowlists and (b) where those tokens are then used — placing a token for a sensitive constant into content rendered to unprivileged users would disclose it. The allowlist is the control; by design it is meant for Pantheon SI tunnel constants. Typical setup: enable Token, add the SI constant names on the settings page, then use `[pantheon_si_tunnel:<name>]` where tokens are accepted.

---
- Surface a Pantheon SI tunnel host as a token
- Reference an SI tunnel port without hardcoding it
- Allowlist which PHP constants become tokens
- Use SI connection details in token-aware config
- Configure an external integration's endpoint via tokens
- Avoid committing environment-specific constants to config
- Publish constants under the `pantheon_si_tunnel` token type
- Restrict exposed constants to a curated allowlist
- Keep SI values out of exported configuration
- Wire Pantheon SI tunnels into contrib modules that accept tokens
- Provide environment-portable connection tokens
- Add or remove exposed constants on the settings page
- Document available SI tokens for site builders
- Map a constant to a lowercased token name automatically
- Return an empty value when a constant is undefined
- Audit which SI constants are surfaced to editors
- Keep tunnel values consistent across environments
