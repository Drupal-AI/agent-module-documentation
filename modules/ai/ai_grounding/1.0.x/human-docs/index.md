# AI Grounding — manual setup guide

**AI Grounding** (`ai_grounding`) is a runtime fact-checker for AI answers. When
your site generates a response from retrieved sources — the pattern behind most
retrieval-augmented (RAG) chatbots and assistants — Grounding checks whether the
answer is actually supported by those sources, sentence by sentence, and can
force the system to abstain or hold the answer for review when the support is
weak.

RAG systems retrieve and cite sources, but they don't verify that the words the
model produced are backed by what was retrieved. AI Grounding closes that gap at
answer time. It splits the answer into sentences and a pluggable **scorer**
grades each one against every source chunk, keeping the best match. Sentences
that fall below a per-sentence threshold are marked unsupported; the overall
score is the average, and citations that match no source apply a penalty. That
overall score maps to one of four actions — **allow**, **flag**, **abstain**, or
**hold**.

The default scorer, `lexical_overlap`, is deterministic and runs entirely
offline: it compares word and word-pair overlap between each sentence and the
sources. Because it makes no calls to an AI provider, it adds no provider cost
and no data leaves your site for the check itself. If you need something
smarter, the scorer is a plugin you can swap out.

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form (thresholds and
   enforcement) and the grounding report.

## Where it lives in the admin menu

- **Settings:** `/admin/config/ai/grounding` — requires the restricted
  **Administer AI Grounding** permission.
- **Report:** `/admin/config/ai/grounding/report` — requires the restricted
  **View AI Grounding reports** permission.

Both routes are permission-gated; there are no anonymous or content-changing
public endpoints.

## How to use it

AI Grounding is meant to be wired into a RAG or chat pipeline in code. The
integration point is a single service call:

```php
$result = \Drupal::service('ai_grounding.verifier')
  ->verify($answerText, $sourceChunks, $citations);
// $result->overallScore  — 0.0 to 1.0
// $result->perSentence[] — each sentence's score, support and best source
// $result->action        — allow | flag | abstain | hold
```

Your pipeline reads `$result->action` and decides what to do: pass the answer
through, flag it, replace it with an "I don't have enough information" abstain,
or hold it for a human. You tune the thresholds that produce those actions on
the [Configuration](configuration/index.md) page, and review outcomes in the
grounding report.
