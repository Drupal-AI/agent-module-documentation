<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VAIS provides an AI search block on a Views page.

---

VAIS (Views AI Search) provides a **block that adds AI-powered search over a Views page** — letting users
query a view's content in natural language, backed by the AI module, and surfacing matching results. It depends
on core Views and the AI module, provides its own permissions, in the Views package.

Use it to add AI/natural-language search to a view. It is an AI/search feature. Security/data handling: queries
(and possibly content) are **sent to the configured AI provider** (external egress — confirm acceptable, key via
AI/Key secret), and results are drawn from the view (which respects access) — but ensure the AI layer doesn't
surface content the user shouldn't see (rely on the view's access; validate what the AI is given/returns). It has
no access-control role beyond its permission. Configure the AI search block.

---

- Add AI search over a Views page.
- Support natural-language queries.
- Back it with the AI module.
- Depend on core Views and AI.
- Provide its own permissions.
- Surface matching results.
- Send queries/content to the AI provider (egress).
- Keep the key via AI/Key (secret).
- Draw results from the access-respecting view.
- Not surface content the user shouldn't see.
- Have no access-control role beyond permission.
- Configure the AI search block.
- Handle AI search.
- Search with AI.
- Configure the block.
- Query content.
- Handle the integration.
- Search views.
- Rely on the view's access.
- Provide AI Views search.
