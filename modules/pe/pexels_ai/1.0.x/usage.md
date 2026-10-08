<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Pexels AI adds functionality for Pexels via AI agents.

---

Pexels AI **adds AI-agent functionality for Pexels stock media** — letting an AI agent search Pexels and
import matching stock photos/videos into Drupal media (e.g. auto-illustrate content). It depends on the AI, AI
Agents, Key and core Media modules, provides its own permissions, in the AI Tools package.

Use it to fetch Pexels media via AI. It is an AI/media/integration feature. Security/data handling: it calls the
**Pexels API** with an **API key** stored via the **Key** module (correct — secret provider), and AI-agent
actions (searching/importing media) should be **scoped** so untrusted input can't drive unwanted API usage/cost;
imported media is third-party stock (mind licensing). It has no access-control role beyond its permission.
Configure the Pexels key and agent.

---

- Search/fetch Pexels media via AI.
- Import stock photos/videos as media.
- Auto-illustrate content.
- Depend on AI/AI Agents/Key/Media.
- Provide its own permissions.
- Use an AI agent.
- Call the Pexels API (key via Key module - correct).
- Scope agent actions (usage/cost).
- Mind stock-media licensing.
- Have no access-control role beyond permission.
- Configure the Pexels key and agent.
- Handle Pexels AI.
- Fetch stock media.
- Configure the agent.
- Import media.
- Handle the integration.
- Search Pexels.
- Add stock media.
- Secure the key (Key module).
- Provide Pexels AI.
