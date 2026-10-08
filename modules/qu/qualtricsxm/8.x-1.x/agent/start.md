<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# QualtricsXM — agent orientation

Qualtrics survey integration: API list/fetch + iframe-embed survey page. Submodules qualtricsxm_embed, qualtricsxm_insights.

- Version 8.x-1.x, core `^8.8||^9||^10`. Settings `/admin/config/content/qualtricsxm` (`administer qualtricsxm settings`, restricted); survey page `/qualtricsxm/survey/{id}` (`access qualtricsxm survey`).
- `Qualtricsxm::httpRequest` uses Guzzle with DEFAULT TLS verification (not disabled), token in `X-API-TOKEN` header, base URL from admin config (no SSRF). iframe src via Twig-autoescaped inline_template.
- No verify=>false, no leaked key in markup. Hardening: Key entity for token. Nothing exploitable found.