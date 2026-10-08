<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Metabase Integration provides a block for embedding Metabase dashboards.

---

Metabase Integration **embeds Metabase dashboards in a block** — displaying charts/dashboards from a Metabase
(business-intelligence) instance inside Drupal via signed embed URLs. It works across core 9.5–11.

Use it to surface Metabase analytics on the site. It is an integration/analytics feature. Security/data handling:
it embeds content from your **Metabase server** and typically uses a **signed embedding secret/token** to authorize
the embed — store that secret securely (env/Key), keep embeds scoped to non-sensitive dashboards (or gate the block
to appropriate roles), and serve over HTTPS. It has no access-control role. Configure the Metabase URL and embedding
secret.

---

- Embed Metabase dashboards.
- Show BI charts in a block.
- Use signed embed URLs.
- Serve analytics integration.
- Display Metabase content.
- Surface analytics.
- Use a signed embedding secret/token (store securely).
- Scope embeds to non-sensitive dashboards / gate the block.
- Serve over HTTPS.
- Have no access-control role.
- Configure the Metabase URL + secret.
- Handle Metabase embeds.
- Embed dashboards.
- Configure the block.
- Show dashboards.
- Handle the integration.
- Display analytics.
- Embed charts.
- Secure the secret.
- Provide Metabase embedding.
