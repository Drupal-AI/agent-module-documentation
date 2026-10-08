<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Search API TruSearch integrates the TruSearch AI hybrid search engine over REST.

---

Search API TruSearch integrates TruSearch — an AI-powered hybrid (keyword + semantic) search engine — with Search API via its HTTP REST API, so a site can offload indexing/querying to TruSearch and get AI-enhanced relevance without running its own vector/semantic infrastructure.

TruSearch API credentials should be stored securely (env-backed); content is sent to the TruSearch service for indexing (privacy). Permissions cover administration (`administer trusearch`) and debug (`view trusearch debug`). Depends on `search_api`; supports Drupal 10.3+ and 11.

---

- Integrate the TruSearch engine.
- Provide AI-powered hybrid search.
- Combine keyword and semantic search.
- Offload indexing/querying to TruSearch.
- Use the HTTP REST API.
- Get AI-enhanced relevance.
- Store credentials securely (env-backed).
- Send content to TruSearch (privacy).
- Gate admin with `administer trusearch`.
- Gate debug with `view trusearch debug`.
- Depend on `search_api`.
- Support Drupal 10.3+ and 11.
- Avoid self-hosted vector infra.
- Configure the connection.
- Improve search relevance.
- Support semantic search
- Integrate an AI engine
- Handle search over REST
