<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Node AI Assistant adds an AI chatbot tab to node edit forms to query field data.

---

Node AI Assistant **adds an AI chatbot to node edit forms** — an assistant tab where editors can ask questions
about the node's field data, answered by an AI provider (via the AI module). It depends on core Node and the AI
module, and provides its own permissions.

Use it to give editors an AI helper on node forms. It is an AI/content-editing feature. Security/data handling: it
**sends the node's field data (and editor prompts) to the configured AI provider** (external egress — the content
can be unpublished/sensitive; confirm acceptable and disclose per policy) and relies on the AI module for provider
credentials (store as secrets). It has no access-control role beyond its permission (gate it to editors). Configure
the AI provider and assistant.

---

- Add an AI assistant to node forms.
- Query the node's field data.
- Answer editor questions via AI.
- Depend on core Node + the AI module.
- Provide its own permissions.
- Serve AI/content editing.
- Send node field data + prompts to the AI provider (egress; can be sensitive).
- Confirm acceptable + disclose per policy.
- Store the AI provider credentials as secrets (AI module).
- Gate it to editors (its permission).
- Configure the AI provider + assistant.
- Handle the AI assistant.
- Query fields.
- Configure the AI.
- Assist editors.
- Handle the integration.
- Answer questions.
- Chat on nodes.
- Secure the credentials.
- Provide a node AI assistant.
