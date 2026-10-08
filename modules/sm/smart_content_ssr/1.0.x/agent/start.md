<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Smart Content SSR - agent index

Server-side rendering for Smart Content decisions. Version **1.0.1** (1.0.x), core `^8..^11`. Depends on `smart_content`.

- Service `smart_content_ssr.decision_evaluator` (`DecisionEvaluator`).
- `SSRDecisionBlock` evaluates a decision's segments server-side and renders the matching block instance (`$blocks_collection->get($instance_id)`) at build time instead of the client-side AJAX swap.
- No routes/permissions of its own.

Security: renders the same block/reaction content Smart Content would render, now server-side; content selection is authored config. Note caching implications (per-segment output). No verified finding.
