<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Published and corrected dates adds two dates to nodes that core conflates: when the content was **first published**, and when it was last **corrected** — which is not the same as when it was last saved.

---

Core gives a node `created` and `changed`, and neither answers the editorial question. `created` is when the node was made, which may be weeks before it was published; `changed` moves on every save, including a typo fix, a taxonomy tweak or a bulk operation. A news site that displays "Published 3 March, updated 11 March" needs the first publication moment and a deliberate correction date, and journalistic standards frequently require that a substantive correction be dated and visible. This module supplies both as node properties with `node` as its only dependency, on core `^10 || ^11`. The distinction from the adjacent modules in this campaign is worth keeping clear: `preserve_changed_ui` (wave 58) stops `changed` moving on a trivial edit, which is the same problem approached by suppression; this adds separate, honest fields instead, so `changed` can move freely while the displayed dates stay meaningful. For a publisher the second approach is usually the right one, because a correction date is editorial information that ought to be set deliberately rather than inferred.

---

- Show a first-published date on an article.
- Record when a correction was made.
- Distinguish publication from creation.
- Meet a journalistic corrections standard.
- Show "published / updated" honestly.
- Avoid a typo fix changing the update date.
- Sort a news listing by publication date.
- Provide accurate dates to structured data.
- Support an editorial corrections policy.
- Show a correction notice with its date.
- Keep changed free for technical saves.
- Report on publication timelines.
- Feed accurate dates to an RSS feed.
- Improve news SEO with correct dates.
- Support an embargoed publishing workflow.
- Record backdated publication.
- Distinguish substantive from trivial edits.
- Give readers trustworthy dating.
