# Configuration

There are three things to set up: an AI provider to do the scoring, per-content-type
enablement, and (optionally) your own security vectors. Every screen below requires the
Analyze permission **Administer analyze settings**.

## 1. Configure a chat AI provider

Go to **Configuration → AI → Providers** (`/admin/config/ai/providers`) and make sure a
chat provider/model is configured and set as the default. The analyzer calls your
default chat provider at a low temperature (0.2) for consistent scoring. If no chat
provider is configured, no scores are generated.

> **Privacy note:** this module sends your rendered content to the external AI provider
> you configure. Only enable it on content where sending text off-site is acceptable.

## 2. Enable the analyzer per content type

Go to **Configuration → Content → Analyze settings**
(`/admin/config/content/analyze-settings`) and turn on the Content Security Audit
analyzer for each content type (bundle) you want scored. You can also toggle individual
vectors per content type here.

## 3. Manage security vectors

Go to **Configuration → Analyze → Content security audit**
(`/admin/config/analyze/content-security-audit`). This is where you review, add, edit,
and delete the vectors that define what "risk" means:

- **Settings / list** — the main screen listing your current vectors.
- **Add vector** — give the new vector an id, label, description, and weight. The
  description feeds into the AI prompt, so describe clearly what should be flagged.
- **Delete vector** — removes the vector and purges all of its stored analysis results.

Two vectors are seeded on install: `pii_disclosure` and `credentials_disclosure`.
Built-in prompt criteria exist for those two; a custom vector you add falls back to a
generic "general security risks" instruction guided by the description you write.

## How scoring and caching work

Each result is cached per entity, revision, language, a hash of the content, and a hash
of the vector configuration. Content is only re-scored when the content changes or when
you change a vector's configuration — so changing a vector automatically invalidates the
affected cached scores. Scores are clamped to 0–100 and displayed as gauges: the summary
shows the highest score, and the full report shows one gauge per enabled vector.

## Reviewing results

Beyond the per-entity Analyze report, a Views dashboard
(`ai_content_security_audit_results`) lists audited content with color-scaled gauges so
you can sort and filter to find the highest-risk items quickly. Multilingual content is
scored per translation.
