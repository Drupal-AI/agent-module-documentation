<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Yext Search integrates the Yext search engine with Search API.

---

Yext Search **integrates the Yext search engine** — providing a Search API integration so content can be
searched via Yext (a hosted search/answers platform). It stores credentials via the **Key** module and depends on
Search API.

Use it to back search with Yext. It is a search/integration feature. Security/data handling: it **sends content and
queries to the Yext API** (external egress — confirm acceptable) and authenticates with **credentials stored via
the Key module** (secret handling, a positive) over HTTPS. Respect Search API access so indexed content isn't
exposed. It has no access-control role. Configure the Yext credentials (via Key).

---

- Integrate the Yext search engine.
- Search content via Yext.
- Provide a Search API integration.
- Store credentials via the Key module.
- Depend on Search API.
- Serve search integration.
- Send content/queries to the Yext API (egress).
- Store credentials via Key (positive), HTTPS.
- Respect Search API access.
- Have no access-control role.
- Configure the Yext credentials via Key.
- Handle Yext search.
- Search content.
- Configure the client.
- Query Yext.
- Handle the integration.
- Serve results.
- Index to Yext.
- Secure the credentials via Key.
- Provide Yext search.
