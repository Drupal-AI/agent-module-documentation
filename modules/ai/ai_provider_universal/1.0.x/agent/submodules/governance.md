<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Submodule: Content Governance (ai_provider_universal_governance)

Source: `web/modules/contrib/ai_provider_universal/modules/ai_provider_universal_governance/`. Human name
"AI Provider: Universal — Content Governance". Depends on the parent `ai_provider_universal` only
(the two LLM-backed guardrails additionally need the factcheck submodule at runtime). Package
AI Providers. Version 1.0.0-beta3. Configure route `ai_provider_universal_governance.settings`.

## Purpose

EU AI Act Art. 50 transparency helpers on top of the provider: attach a default AI-core Guardrail set,
append disclosure/marker text to responses, and emit AI-origin provenance facts. Everything defaults to
off; the module states facts and adds hooks — *policy* (what to do with a provenance fact, exemptions,
banners) lives in ECA/Workflow subscribers.

## Guardrail plugins — `src/Plugin/AiGuardrail/`

AI-core `AiGuardrail` plugins (added to a Guardrail set's pre-/post-generate steps):

- `universal_disclosure_suffix` (`DisclosureSuffix`) — appends a configurable visible disclosure text to
  non-streamed chat responses (`RewriteOutputResult`); skips already-suffixed and streamed output.
- `universal_ai_origin_marker` (`AiOriginMarker`, extends `DisclosureSuffix`) — appends an invisible
  machine-readable HTML-comment marker (`<!-- ai-origin: generated; digitalSourceType=trainedAlgorithmicMedia -->`,
  IPTC vocabulary) that survives copy-paste into a body field.
- `universal_ai_likelihood` (`AiLikelihoodGuardrail`) — scores the last user message (pre) or the
  response (post) with the factcheck `AiDetector`; stops when the AI-likelihood crosses a threshold
  (default 80). Advisory heuristic; available only when factcheck is enabled and a detector model is set.
- `universal_factcheck` (`FactcheckGuardrail`) — runs the factcheck `FactChecker` on the response and
  stops when the claim-support score falls below `min_score` (default 0.6). Costly; opt-in.

Plugin settings live on `ai.ai_guardrail.*` via schema `ai.guardrail.settings.universal_*`.

## Settings — `ai_provider_universal_governance.settings`

- `default_guardrail_set` (string, empty = off) — the AI-core Guardrail set attached when a caller
  provides none.
- `emit_provenance` (bool, default false) — dispatch an `AiContentProvenanceEvent` after each successful
  generation.

Config form `GovernanceSettingsForm` (`ConfigFormBase`).

## Route & permission

One route, `ai_provider_universal_governance.settings` →
`/admin/config/ai/providers/universal/governance`, gated by `_permission: 'administer ai providers'`.
Menu link under `ai.admin_providers`. No permissions of its own.

## Services / subscribers / hooks / events

- `GuardrailDefaultsSubscriber` (event_subscriber, priority 150 on `PreGenerateResponseEvent`) — attaches
  the route's or the module-wide default Guardrail set **only when the caller attached none** (never
  overwrites); a route's own set beats the module default; internal tool calls (factcheck, classifier,
  route verifier — see `InternalChatTags`) are skipped so tool JSON is not mangled.
- `ProvenanceRecorder` (service + subscriber, alias `ai_provider_universal_governance.provenance`) — on
  `ModelPostCallEvent` re-emits successful generations as `AiContentProvenanceEvent` (source
  `generation`) when `emit_provenance` is on; `recordAssociation()` lets ECA/Workflow assert AI output
  landed in an entity (source `association`). The event payload deliberately excludes prompt/response
  text.
- `AiProviderUniversalGovernanceHooks::nodeView` (`hook_node_view`) — on the canonical `full` view mode,
  renders a machine-readable `<meta name="ai-origin">` and/or a visible disclosure label from the
  `field_ai_origin` / `field_ai_disclosure_req` / `field_ai_exemption*` fields shipped by the
  `ai_content_disclosure` recipe, honoring exemptions.
- Event `AiContentProvenanceEvent` (name `ai_provider_universal.content_provenance`; sources
  `generation` / `association`).

## Recipes (shipped by the parent project)

`ai_content_disclosure` (the disclosure fields on Article) and `ai_content_governance_starter` (enables
governance + factcheck, applies the fields, installs a light scan profile).
