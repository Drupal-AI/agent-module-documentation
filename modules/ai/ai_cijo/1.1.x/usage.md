<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI-CIJO detects a visitor's intent and journey stage from anonymous request signals and, per admin-defined journey mappings, orchestrates block visibility, view filters, layout variant, and CTA — with an admin explainability and URL-simulation tool.

---

AI Content Intent & Journey Orchestrator (AI-CIJO) adds a request-time orchestration layer over front-end pages. A kernel request subscriber (`RequestSubscriber`, priority 30) evaluates each main HTML request that matches configured targeting rules — node pages (optionally by content type), URL wildcard patterns, or a custom-controller fallback — and skips admin, AJAX, asset, and non-HTML requests, plus AI-CIJO's own admin pages. For a matched request it collects anonymous signals (path, referrer, roles, language, timestamp) via `VisitorSignalCollector`, runs the configured **IntentDetector** plugin to produce an intent + journey stage + confidence + explanation, and asks the `OrchestrationEngine` to aggregate all matching `JourneyMapping` config entities into an `OrchestrationState`. That state (blocks to hide/show, per-view field filters, layout variant, CTA) is stashed on the request attributes as `ai_cijo_state`; `hook_block_view_alter()` blanks hidden blocks and `hook_views_pre_view()` injects the field filters into matching views via `addWhere()`. Intent detectors are pluggable (`@IntentDetector` annotation, `IntentDetectorManager`): the module ships a heuristic **Fallback** detector (path/referrer/role rules) and an **OpenAI** detector that is currently a stub returning fixed values. When explainability is enabled, the detection result and orchestration outcome are written to the current user's private tempstore and rendered on an admin explain page (`/admin/ai-cijo/explain`) that also offers an "Explain by URL" form to simulate the full pipeline for any internal path without rendering it. Configuration lives in `ai_cijo.settings` (enable flag, chosen detector, explain flag, targeting rules) and in `ai_cijo.mapping.*` journey-mapping config entities. Everything — settings form, journey-mapping CRUD, and the explain tool — is gated by the single `administer ai cijo` permission. The module is disabled by default and depends on core `block` and `views`.

Use it to make block and view content adapt to inferred visitor intent/stage in a transparent, cache-safe, privacy-conscious way, without hard-coding personalization logic, and to inspect or simulate exactly why a given decision was made.

---

- Adapt front-end pages to inferred visitor intent (browse, compare, return) and journey stage (awareness, consideration, retention).
- Hide specific block plugin IDs for a detected intent + stage.
- Force specific blocks to show for a detected intent + stage.
- Inject field-level filters into any view using the `view_id.field_name=value` format.
- Pass a CTA identifier to themes or custom render logic per intent/stage.
- Set a semantic layout-variant name for theme-level layout decisions.
- Restrict evaluation to node pages, optionally limited to selected content types.
- Restrict evaluation to URL wildcard patterns such as `/blog/*` or `/products/*`.
- Optionally run on all custom controllers (non-node routes) as a fallback.
- Keep evaluation off admin pages, asset requests, AJAX, and non-HTML responses by design.
- Use the built-in heuristic Fallback detector with no external service.
- Swap in a custom `@IntentDetector` plugin to derive intent from your own logic or an AI model.
- Aggregate multiple matching journey mappings into one orchestration outcome.
- Manage journey mappings as exportable configuration at `/admin/config/ai-cijo/journey-mappings`.
- Enable per-user explainability logging of each live decision.
- Inspect the last real request's intent, stage, confidence, signals, and full outcome at `/admin/ai-cijo/explain`.
- Simulate the detection and orchestration pipeline for any internal path without rendering the page.
- See which live signals (cookies, session, non-referer headers) are excluded from a simulation.
- Export the explain payload as JSON via the copy panel for debugging or auditing.
- Keep personalization decisions transparent and reviewable rather than a black box.
- Collapse layout sections naturally by hiding blocks, staying compatible with Layout Builder.
- Turn the whole feature on or off with a single settings checkbox (disabled by default).
- Gate all administration behind the `administer ai cijo` permission.
