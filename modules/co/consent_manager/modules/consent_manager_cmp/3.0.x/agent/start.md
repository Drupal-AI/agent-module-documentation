# consentmanager Cookie Banner (consent_manager_cmp) — agent index

Main consent_manager submodule. Injects the consentmanager.net cookie-banner / auto-blocking
`<script>` into every non-admin page. Plugin `cmp` (`has_block: FALSE`). Depends on `consent_manager`.
Config `consent_manager_cmp.settings` at `/admin/config/consent-manager/cmp` (permission `administer
consent manager settings`, restrict access).

- **Settings keys, blocking modes, the two code templates, and how/where the code is injected** →
  [configure/settings.md](configure/settings.md)

Key facts:
- Plugin `src/Plugin/ConsentManager/Cmp.php`; `getCode()` = optional `custom_code` + AUTOMATIC_CODE
  (autoblocking) or SEMI_AUTOMATIC_CODE (semiautomatic.min.js) with escaped `@codeid/@host/@cdn`.
- Config keys: `blocking` (automatic|semi-automatic), `codeid` (required), `host`, `cdn`,
  `custom_code`.
- Injection: `hook_page_attachments` → `html_head` when automatic; `hook_preprocess_html` →
  `page_top` otherwise. Both skip admin routes; cache tag `consent_manager_cmp`.
- `custom_code` is emitted **unescaped** by design (trusted-admin config; see parent
  plugins/plugin.md "Rendering & hardening").
