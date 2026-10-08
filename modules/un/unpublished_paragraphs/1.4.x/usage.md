<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Unpublished Paragraphs adds a floating "Toggle visibility of unpublished items" button to the front end so a viewer who can see unpublished Paragraphs can show or hide them in place, with each unpublished paragraph clearly marked.

---

This is a tiny, front-end-only helper for the contrib **Paragraphs** module. It implements just two hooks and ships one asset library — there is **no configuration page, no settings, no config schema, and no permission of its own**. On every non-admin route, `hook_preprocess_paragraph()` checks each rendered paragraph with `$paragraph->isPublished()`; for any unpublished paragraph it adds the CSS classes `paragraph` and `unpublished` and attaches the `unpublished_paragraphs/unpublished-toggle` library. The library's CSS hides `.paragraph.unpublished` by default (`display:none`) and gives it a pink dotted border plus an "Unpublished" corner label, while the JS appends a fixed dark button in the bottom-right corner **only when the page actually contains an unpublished paragraph**; clicking it toggles all unpublished paragraphs on the page in and out of view. Because it acts purely at render time on paragraphs Drupal already decided to render, whether an unpublished paragraph is available to toggle at all is governed by core Paragraphs / entity access (the "proper permission" in the description) — the module itself grants nothing. It is a convenience for editors/reviewers previewing draft paragraph content on the live rendered page.

---

- Let a content reviewer preview unpublished paragraphs on the real rendered page, then hide them again.
- Give editors a quick front-end toggle to show/hide draft paragraphs without entering the edit form.
- Visually flag which paragraphs on a page are unpublished (pink dotted border + "Unpublished" label).
- Hide unpublished paragraphs from the default rendered view so a work-in-progress page looks clean.
- Show a "Toggle visibility of unpublished items" button only on pages that contain unpublished paragraphs.
- Review a page's draft and published paragraphs side by side by toggling visibility on demand.
- Keep unpublished paragraph content out of the way for privileged users until they choose to reveal it.
- Avoid building a custom preview mode just to see unpublished paragraph blocks.
- Mark up unpublished paragraphs with a stable CSS hook (`.paragraph.unpublished`) for further theming.
- Let a stakeholder with view access confirm draft paragraphs render correctly before publishing.
- Provide an in-context draft preview for landing pages built from Paragraphs.
- Restyle the toggle button or the unpublished marker by overriding the shipped CSS in a theme.
- Toggle several unpublished paragraphs across a long page all at once from a single button.
- Confirm the ordering/placement of a not-yet-published paragraph relative to published ones.
- Use it during editorial QA to spot paragraphs accidentally left unpublished.
- Reveal unpublished promotional or seasonal paragraph blocks for a final check before go-live.
- Keep the admin/edit screens untouched (the module only affects non-admin, front-end routes).
- Rely on core Paragraphs access to decide who can even see unpublished paragraphs, then toggle for those users.
- Pair with a draft/moderation workflow to eyeball unpublished paragraph content on the front end.
- Attach the toggle behavior automatically wherever paragraphs render, with zero setup.
- Demonstrate to a client which parts of a page are still in draft.
- Give designers a way to inspect hidden paragraph blocks without changing publish state.
