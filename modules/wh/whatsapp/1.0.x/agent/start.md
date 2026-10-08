<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drupal WhatsApp (whatsapp) — agent index

**Embeds a hosted third-party WhatsApp chat widget; it does NOT use the WhatsApp Business API and
sends no messages server-side.** A single core Block plugin renders one tag —
`<script defer src="//widget.tochat.be/bundle.js?key=WIDGET_KEY"></script>` — that loads the
**ChatWith.io / tochat.be** SaaS widget in the visitor's browser. The `WIDGET_KEY` is a ChatWith.io
account identifier stored in a **Key entity** (`key` module is a hard dependency). Version **1.0.5**,
core `^10.2 || ^11`. Settings at `/admin/config/services/whatsapp` behind the restricted
`whatsapp configuration form` permission.

Do not confuse this with a messaging/notification integration. There is no API client sending
outbound WhatsApp messages, no webhook, no message templates, no phone-number field. The module only
injects a vendor `<script>` loader onto pages where the block is placed.

## Where to look

- **Place / configure the chat-widget block and how it renders** → [blocks/whatsapp-block.md](blocks/whatsapp-block.md)
- **Settings form, config object/schema, the local-JS-cache feature and cron** → [config/settings.md](config/settings.md)

## Key facts

- Block plugin id: `whatsapp_block` (admin_label "WhatsApp block"), class
  `Drupal\whatsapp\Plugin\Block\WhatsappBlock` (`src/Plugin/Block/WhatsappBlock.php`). No block form —
  it has no per-instance settings beyond `BlockBase` defaults.
- Config object: `whatsapp.settings` → keys `widget_key` (Key entity id), `external_library_cache`
  (bool), `langcode`. Schema `config/schema/whatsapp.schema.yml`.
- Settings form: `Drupal\whatsapp\Form\WhatsappSettingsForm`, route `whatsapp.settings_form` at
  `/admin/config/services/whatsapp`, permission `whatsapp configuration form` (`restrict access: true`).
- Service: `whatsapp.javascript_cache` → `Drupal\whatsapp\JavascriptLocalCache`
  (`src/JavascriptLocalCache.php`). Method `fetchWhatsappJavascript(string $key, bool $synchronize)`
  returns either the remote URL `//widget.tochat.be/bundle.js?key=$key` or a local file path;
  `clearWhatsappJsCache()` deletes the cache.
- Remote vendor endpoint: `//widget.tochat.be/bundle.js?key=<widget key value>` (protocol-relative).
- Local cache path: `public://whatsapp/bundle.js` (+ `.gz` when `system.performance:js.gzip`).
- `hook_cron` (`whatsapp.module`): when `external_library_cache` is on, re-fetches the bundle at most
  once per 24h; last-run stored in state `whatsapp.last_cache`.
- Dependencies: `key:key` (hard). No drush commands. No routes other than the settings form. No
  templates, no JS/CSS libraries shipped by the module (all JS is the remote vendor bundle).
- The caching code is adapted from the Google Analytics module's `JavascriptLocalCache`.
