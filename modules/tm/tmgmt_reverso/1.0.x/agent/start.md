<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Reverso Translator (tmgmt_reverso) — agent index
**TMGMT translator plugin that sends job content to the Reverso machine-translation API.**

- **Version:** 1.0.x (1.0.0-beta2)
- **Core:** ^10 || ^11 (PHP 8.1+)
- **Depends on:** tmgmt
- **Configure:** `/admin/tmgmt/translators` (add translator, plugin = Reverso) — `entity.tmgmt_translator.collection`.
- **Plugin:** `ReversoTranslator` (id `reverso`, continuous). Endpoints `/v1/TranslateText` and `/v1/TranslateStream` (HTML, base64 response).
- **Auth:** headers `Username`/`Created`/`Signature`, signature = `hmac_sha1(username+date, password)`.

**Security:** credentials stored on the translator entity (config), not hardcoded; outbound calls use Guzzle default TLS verification (no `verify=>false`). The endpoint URL is admin-set — README recommends HTTPS so the signed request isn't exposed on the wire. No inbound callbacks or public routes.

See [configure/translator.md](configure/translator.md)
