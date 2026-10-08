<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Critique And Review Content adds a structured peer-review workflow to node content, letting reviewers write templated critiques that come back to the author on the node edit form.

---

Critique And Review Content lets one user review or critique another user's node content. An administrator picks which content types are reviewable and defines a template of **Review Items** (titled sections, each with basic_html instructions), plus optional help text and whether reviewers may add their own items. A **Critique And Review Block** placed on node pages shows the templated review form to any authenticated user who is not the node's author; the author instead sees a status message and a link to their edit form. Reviewers save drafts and can later **finalise** a review, after which it becomes read-only and is shown to the author, grouped by reviewer under vertical tabs on the node edit form. Reviews are keyed by user, node id, and node revision id and stored in the module's own `critique_and_review_reviews` table. Who may leave reviews is controlled by block visibility (role / page / content type), so it works on Drupal core 9, 10, and 11.

---

- Add a peer-review / critique workflow to node content.
- Let editors, sub-editors, or supervisors review work before publication.
- Proofread and fact-check drafts with structured feedback.
- Sign off educational content before it is used.
- Have senior staff review property or product descriptions.
- Collect feedback on early drafts from collaborators.
- Give reviewers a fixed template of Review Items (Intro, Body, Conclusion, etc.).
- Let an admin define the default Review Item titles and per-item instructions.
- Optionally allow reviewers to add their own ad hoc Review Items on the fly.
- Optionally allow reviewers to delete Review Items from their review.
- Show reviewers an intro/help text block at the top of the review form.
- Save a review as a draft and return to edit it later.
- Finalise a review so it becomes read-only and visible to the author.
- Show finished reviews back to the content author on the node edit form.
- Group multiple reviewers' feedback under vertical tabs per reviewer.
- Restrict reviewing to specific roles via the block's role visibility.
- Restrict reviewing to node pages via the block's page (`/node/*`) visibility.
- Restrict reviewing to specific content types via block or module settings.
- Enable review only on chosen content types (default: Article).
- Attach the module's CSS to widen a sidebar-placed review form.
- Track reviews per node revision so each revision has its own review set.
- Let an administrator edit or bypass the finalised state of a review.
