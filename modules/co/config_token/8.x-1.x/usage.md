<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Token lets administrators define their own tokens whose values are stored in configuration, exposing each one as `[config_token:machine_name]` for reuse anywhere Drupal tokens are supported.

---

Drupal's token system is everywhere — in text, in other modules' settings, in patterns — but the set of tokens is fixed by what modules provide. Sites often repeat a handful of values: a support phone number, a company name, a current campaign tag, a legal entity. Hard-coding those in content means editing every occurrence when they change. Config Token turns each into a defined token instead. It works in two halves, on two tabs of `/admin/config/system/config_tokens`: the *Allowed Config tokens* tab defines a token (machine name, label, description, and the text format its value is rendered through), and the *Config tokens* tab gives each defined token its value. Definitions live in `config_token.settings` (`allowed_tokens`) and values in `config_token.tokens` (`replacements`), so the two can be deployed independently. Under the hood it is pure Token API — `hook_token_info()` advertises each allowed token and `hook_tokens()` resolves it, running the stored value through the token's chosen text format via a `processed_text` render element (or returning it verbatim when the format is "None (raw value)", for values you compare rather than print). Both config objects are added as cache dependencies of every replacement, so editing a definition or a value invalidates the render/page caches that embedded the token. Because values are ordinary configuration they export to `config/sync` and commit like anything else (the design goal was Domain Access-friendly, per-domain token overrides via `domain.config.*` files) — but they are readable wherever the token renders and in exports, so they are not a place for secrets. Everything is gated by the single `administer config_tokens` permission; there is no runtime API, no plugin type, and no Drush command.

---

- Define a custom `[config_token:*]` token stored in configuration.
- Reuse a support phone number as `[config_token:support_phone]`.
- Store a company name as a token and reference it site-wide.
- Create a single source of truth for a repeated constant.
- Avoid hard-coding a value in dozens of content items.
- Use a token for a seasonal campaign tag.
- Change a repeated value in one place and update every page.
- Define a legal-entity or copyright-notice token.
- Render a token as a real link by assigning it the Basic HTML format.
- Keep a token as a raw value by choosing "None (raw value)".
- Export token definitions and values to `config/sync` and commit them.
- Deploy the same tokens to another environment via config import.
- Override a token's value per environment in `settings.php`.
- Override token values per domain with the Domain module (`domain.config.*.config_token.tokens.yml`).
- Render config tokens in body text using the Token Filter module.
- Reference a config token in another module's token-enabled setting.
- List all custom tokens alongside core tokens at `/admin/help/token`.
- Manage token definitions and values independently (two tabs).
- Restrict token administration to trusted roles via `administer config_tokens`.
- Keep secrets out of tokens (values are plain, exportable config).
- Standardise repeated marketing or contact values across a site.
- Provide editorial constants that non-developers can reference but not define.
- Seed a new site with example tokens (created automatically on install).
- Bulk-create many tokens by editing `config_token.settings`/`config_token.tokens` directly.
- Use a raw-value token somewhere the value is compared rather than displayed.
