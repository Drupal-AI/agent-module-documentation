<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# chat_livehelperchat — agent orientation

- Embeds a self-hosted Live Helper Chat widget/FAQ into Drupal with visibility rules. Config `/admin/config/chat_livehelperchat/livehelperchatformsettings` (`administer chat_livehelperchat`).
- Permissions (all `restrict access: TRUE`): administer, `use php for livehelperchat visibility` (PHP-eval visibility — admin-only, like core PHP filter), `use injectjs server config`.
- `.module` `file_get_contents` reads the module's own README.md for help (static local file, not user input) — no SSRF.
- No anonymous/callback endpoints. External chat traffic goes to the admin-configured LHC server. No code-level vuln.
