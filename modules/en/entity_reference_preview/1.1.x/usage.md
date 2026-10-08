<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Preview renders embedded entity references at their latest (draft) revision while you preview the parent entity, so a moderated composition shows its full draft state.

---

On a moderated site, viewing the latest (draft) revision of an entity still renders its referenced
entities from their *published* revision, so coordinated draft changes across referenced content are
invisible in preview. Entity Reference Preview closes that gap: it ships a "Rendered entity (with
preview)" entity-reference field formatter that, when preview mode is active, swaps each referenced
entity for its latest revision (respecting translation and language fallback) before rendering. Preview
mode turns on automatically when you view an entity on its latest-revision route (the `.../latest`
tab), or manually via a toolbar tab / block button that flips a session flag (a "detector" plugin).
Views can opt in per display so listings also show the latest revisions during preview. Outside preview,
an optional blue "draft available" indicator marks references that have an unpublished pending revision.
It is a pure editorial/preview feature: it changes *which revision* renders, and every swapped revision
still passes the normal `view` access check, so what a user is allowed to see is unchanged. Two
permissions gate the manual controls and the indicator, and a settings form toggles the indicator and
toolbar integration.

---

- Preview referenced nodes/paragraphs/media at their latest draft revision.
- See a full moderated composition (parent + references) in its draft state.
- Fix the default preview gap where references render the published revision.
- Show latest embedded drafts on an entity's `.../latest` route automatically.
- Add a "Rendered entity (with preview)" formatter to an entity-reference field.
- Manually start/stop preview from a toolbar tab across any page.
- Manually start/stop preview from the "Preview Detector" block.
- Preview the latest revisions of entities rendered by a view.
- Opt a specific view display into preview via its display extender.
- Mark references that have an unpublished draft with a blue-dot indicator.
- Give reviewers an accurate preview before publishing coordinated changes.
- Preview draft references inside a Layout Builder or block-composed page.
- Avoid Entity Reference Revisions' extra storage when you only need preview.
- Respect each viewer's access while swapping to the latest revision.
- Preview translated content using language-fallback-aware revision negotiation.
- Restrict who can trigger manual preview with a dedicated permission.
- Restrict who sees the draft indicator with a dedicated permission.
- Toggle the draft indicator and toolbar integration from a settings form.
- Extend detection with custom preview_detector plugins.
- Use the cookie/session detector to keep preview on while browsing.
- Show editors which pages contain unpublished referenced drafts.
- Support content-moderation editorial workflows.
- Keep normal (published) rendering when not previewing.
- Preview a listing/view of entities in their latest form.
- Verify draft references render correctly before pushing content live.
