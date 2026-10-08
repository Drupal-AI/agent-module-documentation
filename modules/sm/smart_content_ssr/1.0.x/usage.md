<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Smart Content SSR adds server-side rendering to Smart Content. Instead of rendering a placeholder that a client-side AJAX call later swaps, an SSR decision block and a decision-evaluator service resolve the winning segment on the server and render its content directly.

Use it when personalization must appear in the initial HTML - for SEO, no-JS clients, or to avoid content flash - accepting the caching trade-offs of server-side evaluation.

---

Install (requires `smart_content`). The module registers a `smart_content_ssr.decision_evaluator` service (`DecisionEvaluator`) and an `SSRDecisionBlock` that evaluates a decision's segments server-side and renders the matching reaction/block instance during page build.

No admin routes/permissions are added; you use the SSR decision block in place of (or alongside) the standard client-side decision block. Because evaluation happens server-side, ensure your caching/vary strategy accounts for per-segment output (see Smart Content CDN for edge Vary handling).

---

- Render Smart Content decisions server-side.
- Include personalized content in the initial HTML.
- Improve SEO for personalized variations.
- Support no-JS/limited-JS clients.
- Avoid client-side content flash on swap.
- Provide an SSR decision block.
- Evaluate segments via a decision-evaluator service.
- Render the matching block instance on the server.
- Integrate with Smart Content's decision model.
- Pair with CDN Vary handling for caching.
- Require no dedicated admin UI.
- Depend only on smart_content.
- Support Drupal 8 through 11.
- Complement the client-side reaction flow.
- Resolve reactions from the block collection.
- Keep authoring in Smart Content segment sets.
