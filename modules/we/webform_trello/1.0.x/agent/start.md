<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Trello — agent index

Webform **handler** that creates a **Trello card** from each submission via the Trello REST API. Deps `webform`, `token`. Config under Webform admin settings (`administer webform`). Version **1.0.2**, core `^8||^9||^10`. Outbound HTTPS only (Guzzle default TLS) — no public routes.