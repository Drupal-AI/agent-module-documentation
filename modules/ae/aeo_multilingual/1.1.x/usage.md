<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AEO Multilingual audits each language version of your nodes independently and scores them (0-100) for Answer Engine Optimization across seven checks, shown on an admin dashboard and a per-node tab.

---

AEO Multilingual is an auditing/reporting tool for multilingual sites. For every translation of a node it runs a set of pluggable "audit check" plugins — hreflang coverage, JSON-LD schema markup (via Schema.org Metatag), meta description length/presence (via Metatag), header hierarchy, image alt text, content length, and translation completeness — and combines their per-check scores into an overall 0-100 score with a pass/warning/fail status per language. Results are presented two ways: an admin **dashboard** (`/admin/reports/aeo-multilingual`) listing published nodes with a score column per language plus per-language averages, and a per-node **"AEO Multilingual" tab** (`/node/{node}/aeo-multilingual`) showing every check's score, status and actionable suggestions for each translation. A settings form (`/admin/config/search/aeo-multilingual`) selects which content types to audit and the flagging threshold. It is read-only reporting: it does not modify content or emit meta tags itself. Depends on core Language, Content Translation and Node; Metatag and Schema.org Metatag are recommended companions. PHP 8.1+.

---

- Score each language version of a node independently (0-100).
- Show a dashboard of AEO scores per language for all published nodes.
- See per-language average scores and node counts.
- Open a per-node "AEO Multilingual" tab with detailed check results.
- Get actionable suggestions per check, per translation.
- Audit hreflang coverage across a node's translations.
- Check for JSON-LD schema markup with the correct `inLanguage`.
- Validate meta description presence and length per language.
- Analyze header (H1-H6) hierarchy in the body.
- Verify images have alt text in each language.
- Measure content length (word count) for AEO.
- Detect untranslated key fields (translation completeness).
- Limit auditing to selected content types.
- Set a minimum score threshold to flag weak content.
- Prioritize which translations need SEO/AEO work.
- Combine seven weighted checks into one overall score.
- Extend the audit with a custom `AuditCheck` plugin.
- Grant SEO staff a dedicated reports permission.
- Recommend Metatag / Schema.org Metatag for fuller auditing.
- Support multilingual sites targeting AI answer engines.
