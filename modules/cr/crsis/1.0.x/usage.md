CRSIS scores the readability of published nodes with the Flesch-Kincaid Reading Ease formula and surfaces the results, grades, and improvement tips on an admin dashboard.

---

CRSIS (Content Readability Score & Improvement Suggestions) is a small, self-contained Drupal module that analyzes the body field of published nodes and reports how easy each one is to read. It computes a Flesch-Kincaid Reading Ease score from word, sentence, and syllable counts in pure PHP (no external services or libraries), maps that score to a seven-level grade label, and generates actionable suggestions when content falls below a configurable minimum threshold. Results are presented on a dedicated dashboard at `/admin/content/crsis-dashboard` that lists up to 50 of the most recently changed published nodes, with summary cards (total analyzed, average score, good vs. needs-improvement counts), color-coded score badges, a legend, and per-node suggestions. A settings form lets administrators enable/disable analysis and set the minimum acceptable score. The module depends only on the core Node module and provides two permissions: one to view the dashboard and one (restricted) to administer settings.

---

- Give content editors a readability score for every published node without leaving the admin UI.
- Enforce a plain-language standard by flagging content below a minimum Flesch-Kincaid score.
- Show a dashboard of the 50 most recently changed published nodes ranked by change date.
- Translate raw Flesch-Kincaid numbers into human-readable grades (Very Easy through Very Difficult).
- Surface per-node improvement tips such as "break up long sentences" or "use simpler words".
- Configure the minimum acceptable readability score (0-100) for your editorial team.
- Enable or disable readability analysis site-wide from a single settings form.
- Give the accessibility team a quick view of which pages are hardest to read.
- Support content-quality and SEO audits where reading ease matters for engagement.
- Highlight nodes whose average sentence length exceeds 20 words for editorial review.
- Flag content using too many multi-syllable words (over 1.6 syllables per word on average).
- Warn editors when a node is too short (under 50 words) for a reliable score.
- Display a color-coded badge (high / mid / low) so problem content stands out at a glance.
- Show summary KPIs: total content analyzed, average readability score, good count, needs-improvement count.
- Link each dashboard row directly to the node's canonical page for quick editing.
- Restrict dashboard access to specific roles via the "Access CRSIS dashboard" permission.
- Restrict settings management to administrators via the restricted "Administer CRSIS" permission.
- Reuse the `crsis.readability` service in custom code to score arbitrary text strings.
- Provide a multilingual-ready readability tool, since all strings are translatable.
- Benchmark content readability across content types shown in the dashboard's Type column.
- Support editorial workflows that require content to meet a readability floor before publishing.
- Add a lightweight, dependency-free readability check to a site without third-party APIs.
