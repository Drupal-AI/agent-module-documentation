<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# chatbot_api — agent orientation

- Framework/API for chatbot & assistant integrations; submodule `chatbot_api_entities` pushes entity data to remote chatbot APIs.
- Pluggable PushHandler/QueryHandler plugins; outbound HTTP via Drupal `http_client` (Guzzle, TLS defaults ON). Permission `administer chatbot api entities` (`restrict access: true`).
- Base module: no anonymous mutation routes. Credentials/keys live in concrete provider plugins, not here.
- Security review: no disabled TLS, no raw SQL, no anon endpoints in the base. Nothing to report.
