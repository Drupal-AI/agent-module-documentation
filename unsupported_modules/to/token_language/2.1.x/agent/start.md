<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Language Tokens (token_language) — agent index

**Provides Token API tokens for the current interface language: `[current-language:code]`, `[:uppercase_code]`, `[:name]`.**

- **Version:** 2.1.x (info.yml `2.1.1`)
- **Core:** ^8 || ^9 (info.yml; installed on the Drupal 10 site here).
- **Dependencies:** `token`.
- **Hooks:** `hook_token_info()` registers the `current-language` type + 3 tokens; `hook_tokens()` resolves them from `languageManager()->getCurrentLanguage()` (`token_language.module`).

**Security:** pure token provider — no routes, permissions, config, forms, or request handling; no security-relevant surface.
