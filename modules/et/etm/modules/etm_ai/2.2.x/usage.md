ETM AI is the optional AI engine for Enhanced Taxonomy Manager; it drives taxonomy-specific LLM operations (generate, place, deduplicate, describe, restructure, chat, auto-tag) through the Drupal AI module's provider abstraction, rendered directly into the ETM tree view.

---

ETM AI depends on both `enhanced_taxonomy_manager` and the `ai` module and is enabled separately. It never talks to an LLM directly — all model calls go through `EtmAiService`, which uses the AI module's `AiProviderPluginManager` (`ai.provider`) and a configured chat provider/model (or the site default). A settings form at `/admin/config/content/etm-ai` picks the provider/model, a power level (conservative/balanced/aggressive, which shapes the system preamble), a temperature, a per-vocabulary daily request limit, and whether to cache responses for an hour. Two permissions gate the features: `use etm ai features` for the everyday operations and the access-restricted `use etm ai advanced features` for the token-heavy ones (deep analysis, auto-tag, relationship mapping). All AI endpoints also require the parent's `_etm_access` (so the caller must already be able to manage that vocabulary) and validate the ETM CSRF token.

The service builds a taxonomy-expert prompt, sends the vocabulary's structure/terms as context, and parses a strict-JSON reply (with markdown-fence stripping and truncated-JSON repair). Beyond single operations it ships seven "power features": a restructure planner that returns move/rename/merge/create/delete operations for review, an industry-template library (Schema.org, IAB, UNSPSC, GS1 GPC, Google product, education OER, restaurant) with gap analysis and mapping, a chat commander that answers or returns operations, taxonomy extraction from a pasted document or a fetched URL, a multi-pass deep-analysis report, smart auto-tagging of content against the vocabulary, and SKOS-style relationship mapping. Suggestions are always presented for a human to apply through the parent module's normal (access-checked, CSRF-checked) mutation endpoints — the AI layer proposes, it does not silently rewrite the tree.

---

- Generate a batch of suggested child terms for a selected parent term.
- Suggest the best parent placement for a new term name.
- Find semantic duplicates (TV vs Television, Color vs Colour) beyond exact string matches.
- Auto-generate concise scope-note descriptions for terms that lack them.
- Run an AI taxonomy health audit with severity-ranked issues and fixes.
- Propose a full restructure plan (move/rename/merge/create/delete) from a natural-language instruction.
- Map an existing vocabulary onto a bundled industry-standard template with a gap analysis.
- Chat with a taxonomy assistant that returns either an answer or a set of operations.
- Extract a hierarchical taxonomy from pasted text.
- Extract a taxonomy from a public URL's content.
- Run a natural-language semantic search over the vocabulary.
- Auto-tag a piece of content against the vocabulary's terms.
- Map synonym / broader / narrower / related relationships between terms.
- Run a comprehensive multi-pass deep-analysis report with prioritized actions.
- Choose which AI provider and model ETM uses, or fall back to the site default.
- Cap AI spend with a per-vocabulary daily request limit.
- Cache AI responses for an hour to reduce provider cost.
- Tune suggestion boldness with a conservative / balanced / aggressive power level.
- Restrict token-heavy features to trusted roles via a separate advanced permission.
