<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DeepL Provider adds DeepL as a provider for Drupal's AI module, specifically for translation.

---

Machine translation used as a **first draft** is a different proposition from machine translation used as the published output, and the distinction is the whole of how to think about this. A translator working from a good machine draft is substantially faster than one starting from nothing, and the draft is reviewed before anyone reads it — which is a genuine and defensible workflow. A site that publishes the raw output has committed to whatever the model produced, in a language nobody on the team reads, permanently and under the organisation's name. DeepL is generally regarded as the strongest of the general-purpose engines for European language pairs, which is why translation teams choose it, and it is a **German** company processing in the EU, which matters for the same reasons `ai_provider_mistral` does. Version **1.0.0-alpha3** — an **alpha** — requiring `ai` and **`key`**, on core `^10.2 || ^11`. Three things worth attaching. **The content being translated leaves the site**, so unpublished material, personal data in examples and anything under embargo is a disclosure to a processor and belongs in the assessment. **Terminology is where machine translation fails an organisation** — an institution's own terms, product names and legal phrasing are exactly what a general engine gets wrong, and DeepL supports glossaries for precisely this, so a translation programme should use them rather than accepting the default vocabulary. And **translated content is content**: it needs the same review, revision history and ownership as anything else, so a workflow that writes machine output straight into a translation without a moderation step has skipped the part that makes it acceptable.

---

- Produce a first-draft translation.
- Speed up a human translation workflow.
- Translate content into European languages.
- Add machine translation to a multilingual site.
- Use an EU-based translation provider.
- Draft translations for editor review.
- Support a translation team's throughput.
- Translate a large content backlog.
- Add a glossary of organisational terms.
- Support a multilingual publication programme.
- Translate interface strings.
- Provide draft translations for review.
- Meet a data-residency requirement for translation.
- Reduce translation costs.
- Translate a news archive.
- Support a bilingual organisation.
- Add AI-assisted translation to Drupal.
- Draft translations before professional review.
