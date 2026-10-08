<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Create and translate puts an extra "Save and translate" button on node and taxonomy-term forms that saves the entity and lands the editor on its Translate tab instead of the saved entity.

---

On a multilingual site the step after creating a piece of content is almost always translating it, and the default path there is: save, read the confirmation, find the Translate tab, click it. That is several interactions and a page the editor did not want to look at, repeated for every node or term. This module removes them with a second submit button, **Save and translate**, added by a `hook_form_alter()` to the node add/edit forms, the content-translation add form, and the taxonomy-term add/edit forms — but only when the form's entity is translatable. After core saves the entity the module's submit callback redirects to `internal:/node/{nid}/translations` or `internal:/taxonomy/term/{tid}/translations`, and a small outbound path processor (`create_and_translate.path_processor`) strips the `destination=admin/content` query argument so core's usual "return to content list" does not win over that redirect. There is nothing to configure: install it and the button appears; editors who are not translating keep using the normal **Save** button.

It is a small ergonomic change with a real effect on throughput when a team produces content in several languages daily — invisible when it works and immediately missed when removed. Note the dependency list is broader than the feature suggests (`content_translation`, `language`, `node`, `taxonomy`), so it pulls `taxonomy` onto a site that does not otherwise use it, and the `^8 || ^9 || ^10 || ^11` core range spans four majors, so verify the button on your target core — the surface is small enough that checking it is a five-minute job.

---

- Save a node and go straight to its Translate tab.
- Save a taxonomy term and go straight to its Translate tab.
- Cut several clicks out of a bilingual publishing routine.
- Create content in the source language and translate immediately.
- Speed up a daily multilingual publishing workflow.
- Keep the normal Save button for editors who are not translating.
- Reduce the chance an editor forgets to translate new content.
- Support a team producing content in several languages at once.
- Land on the translation overview rather than the saved entity.
- Give translators a shorter path from creation to translation.
- Pair with machine translation for a fast first pass.
- Apply the same routine across all translatable content types and vocabularies.
- Remove a bespoke redirect hack from a custom module.
- Improve editor experience without changing the content model.
- Shorten a translator's route into new content.
- Install with zero configuration — the button appears automatically.
- Verify the button on the target core version.
- Audit whether the taxonomy dependency is wanted on your site.
