<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Language Tokens adds Token API tokens for the current interface language — its code, uppercase code and human-readable name — filling a gap where core/Token provide no current-interface-language tokens.

---

The module implements `hook_token_info()` to register a `current-language` token type with three tokens: `[current-language:code]`, `[current-language:uppercase_code]` and `[current-language:name]`. `hook_tokens()` resolves them from `\Drupal::languageManager()->getCurrentLanguage()`, returning the langcode, its uppercase form, and the language name respectively. It depends on the contrib Token module.

A common use case is building language-prefixed links inside translatable text (for example a field help text or a message that must point to a page under the current interface language's URL prefix). The module has no configuration, routes, permissions, forms or request handling — it is a pure token provider, so it has no security-relevant surface. Note the info.yml core requirement is `^8 || ^9`; it is installed here on the Drupal 10 site.

---

- Insert the current interface language code into text via `[current-language:code]`
- Build a language-prefixed URL inside field help text
- Show the current language name with `[current-language:name]`
- Output an uppercase language code (e.g. EN) with `[current-language:uppercase_code]`
- Compose multilingual email/message strings that reference the active language
- Prefix internal links with the interface langcode in tokenised content
- Use in any module/config field that supports Token replacement
- Display the active language in a block or metatag via tokens
- Localise call-to-action links per interface language
- Feed the language code into other token-aware integrations
- Insert the active language name into a metatag
- Reference the current langcode in a Views token
- Add the language code to a pathauto or alias pattern
- Show EN/FR/DE style codes in UI labels via tokens
- Build hreflang-style references from the current language
- Populate language-aware placeholders in editorial content
