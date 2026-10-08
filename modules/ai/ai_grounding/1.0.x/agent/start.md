<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Grounding (ai_grounding) — agent index

**Runtime output-side faithfulness verifier: scores per-sentence support of a RAG/AI answer against retrieved sources and can force abstain / hold-for-review.**

- **Version:** 1.0.x  •  **Core:** ^10.3 || ^11 || ^12  •  **Package:** AI  •  **Depends on:** `ai`
- **Configure:** `/admin/config/ai/grounding` (`administer ai_grounding`, restricted).
- **Report:** `/admin/config/ai/grounding/report` (`view ai_grounding reports`, restricted).
- **Service:** `ai_grounding.verifier` → `verify($answer, $sources, $citations)` returns `GroundingResult`. Default scorer `lexical_overlap` is deterministic/offline (no provider cost). Scorer is a plugin.
- **Actions:** `allow` / `flag` / `abstain` / `hold`.
- **Security:** Both routes permission-gated (restricted); no anonymous or mutating endpoints; default scorer makes no network calls. No security findings.

See [api/verifier.md](api/verifier.md).
