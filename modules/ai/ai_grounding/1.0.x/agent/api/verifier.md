<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Grounding — verifier API

```php
$verifier = \Drupal::service('ai_grounding.verifier');
$result = $verifier->verify($answerText, $sourceChunks, $citations);
// $result->overallScore   float 0.0-1.0
// $result->perSentence[]  SentenceScore{text, score, supported, bestSource}
// $result->action         allow | flag | abstain | hold
```

Pipeline:
1. Split answer into sentences.
2. Grounding scorer grades each sentence against every source chunk; keep the best match. Default `lexical_overlap`: lowercase + stop-word tokenization, unigram+bigram sets, blended containment (0.6 unigram + 0.4 bigram) — deterministic, offline, no provider cost.
3. Sentences below the per-sentence threshold → unsupported; overall = mean of per-sentence scores.
4. Citations matching no source apply a proportional penalty.
5. Overall vs overall threshold → action.

Swap the scorer by implementing a grounding-scorer plugin. Configure thresholds/enforcement at `/admin/config/ai/grounding`.
