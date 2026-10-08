<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Custom Token (custom_token) — agent index

**Environment-specific `[custom_token:*]` tokens: keys in config (exported), values in State (never exported); resolved in Webform email handlers and any tokenized text.**

- **Version:** 1.0.x (1.0.0)
- **Core:** ^9 || ^10 || ^11
- **Requires:** webform
- **Route:** `custom_token.settings` → `/admin/config/system/custom_token` (form `WebformEmailSettingsForm`)
- **Permission:** `administer custom token` (`restrict access: true`)
- **Hooks:** `hook_token_info()`, `hook_tokens()` (reads `\Drupal::state()->get('custom_token.tokens')`), `hook_webform_handler_invoke_alter()` (rewrites `to_mail`/`to_options`).
- **Storage:** keys → `custom_token.settings:keys`; values → State `custom_token.tokens`.

**Security:** Single admin config route gated by a restricted permission; no anonymous or mutating public endpoints. Token values are admin-set. See [configure/tokens.md](configure/tokens.md).
