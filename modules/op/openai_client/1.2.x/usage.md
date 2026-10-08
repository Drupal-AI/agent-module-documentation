<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
OpenAI Client provides OpenAI API integration and basic user interfaces.

---

OpenAI Client provides **OpenAI API integration** for Drupal — a client service plus basic user interfaces
to call OpenAI (chat/completions, etc.) from the site. It provides its own permissions, in the AI package.

Use it as an OpenAI integration layer. It is an AI/integration feature. Security/data handling: it **sends
prompts/content to OpenAI** (external data egress — confirm acceptable), authenticates with an **OpenAI API
key** (store as a **secret** — env/Key, not committed config — over HTTPS), and any UI that lets users invoke
OpenAI should be **gated by its permission** to trusted users (to control API usage/cost and what's sent). It
has no access-control role beyond its permission. Configure the OpenAI credentials.

---

- Integrate the OpenAI API.
- Call chat/completions from Drupal.
- Provide basic UIs.
- Provide its own permissions.
- Send prompts/content to OpenAI (egress).
- Confirm the egress is acceptable.
- Store the OpenAI API key as a secret.
- Use HTTPS.
- Gate invocation UIs to trusted users.
- Control API usage/cost.
- Have no access-control role beyond permission.
- Configure the OpenAI credentials.
- Handle OpenAI.
- Call OpenAI.
- Configure the client.
- Send prompts.
- Handle the integration.
- Query OpenAI.
- Secure the key.
- Provide OpenAI integration.
