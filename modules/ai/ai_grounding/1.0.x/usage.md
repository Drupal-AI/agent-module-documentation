<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Grounding is a runtime, output-side faithfulness verifier: given an answer and the retrieved source chunks, it scores how well each sentence is supported and can force an abstain or hold-for-review when grounding is weak.
---
RAG modules retrieve and cite sources but do not check whether the generated answer is actually supported by them. AI Grounding closes that gap at answer time. It splits the answer into sentences, and a pluggable **grounding scorer** grades each sentence against every source chunk, keeping the best match. The default `lexical_overlap` scorer is deterministic and offline: it tokenizes (lowercase, stop-word filtered), builds unigram/bigram sets, and computes a blended containment score (0.6 unigram + 0.4 bigram). Sentences below a per-sentence threshold are marked unsupported; the overall score is their mean. Supplied citations that match no source apply a proportional penalty. The overall score maps to an action — `allow`, `flag`, `abstain`, or `hold`. The result is a `GroundingResult` value object with per-sentence detail.

Operationally, code calls `\Drupal::service('ai_grounding.verifier')->verify($answer, $sources, $citations)`. The default scorer makes no network calls, so it adds no provider cost. Access is permission-gated: the settings form (`/admin/config/ai/grounding`) and the report (`/admin/config/ai/grounding/report`) both require restricted permissions (`administer ai_grounding`, `view ai_grounding reports`). There are no anonymous or mutating public endpoints.
---
- Verify at answer time whether a RAG/AI answer is supported by its sources.
- Score each sentence's grounding against retrieved chunks.
- Detect and flag unsupported (hallucinated) statements.
- Penalize citations that match no supplied source.
- Force an `abstain` ("not enough information") when grounding is weak.
- Hold an answer for human review below the overall threshold.
- Allow answers that clear the threshold to pass through.
- Use the deterministic, offline `lexical_overlap` scorer (no provider cost).
- Swap in a custom grounding scorer plugin.
- Tune the per-sentence and overall thresholds.
- Consume the `GroundingResult` value object in code.
- Inspect per-sentence scores and best-matching source.
- Review grounding outcomes in the admin report.
- Guard against fabricated references in generated answers.
- Distinguish input topic-restriction guardrails from output faithfulness checks.
- Add a faithfulness gate to an existing RAG pipeline.
- Restrict configuration to admins via restricted permissions.
- Score reproduced phrasing higher than scattered keyword reuse.
- Integrate grounding enforcement into a chat processor.
