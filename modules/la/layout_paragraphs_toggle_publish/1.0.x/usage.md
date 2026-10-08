<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Paragraphs Toggle Publish adds a publish/unpublish control to every component in the Layout Paragraphs builder, so an editor can hide a section without deleting it. A small colored dot in each component's control bar shows the state and flips it on click: green when published, orange when unpublished.

---

Layout Paragraphs gives editors a drag-and-drop page builder made of paragraph components, and its built-in controls cover add, edit, move, and delete — but not the verb editors reach for constantly: *hide this for now*. This module fills that gap by exposing the published flag that every Paragraph entity already carries. It hooks `hook_preprocess_layout_paragraphs_builder_controls` to inject a `Publish`/`Unpublish` link (rendered as a `.lpb-controls-publish-toggle` dot, green `is-published` / orange `not-published`) into each component's controls; the link is an `use-ajax` GET to the route `/layout-paragraphs-toggle-publish/{layout_paragraphs_layout}/toggle-publish/{component_uuid}`, handled by `TogglePublish::toggle`. The controller flips `isPublished()`, creates a new revision, and saves the paragraph immediately, then updates the Layout Paragraphs tempstore and returns an AJAX response that swaps the dot and toggles the `paragraph--unpublished` class on the component in place. The route is gated by the parent module's own `_layout_paragraphs_builder_access: 'TRUE'` requirement rather than a flat permission, so it checks paragraph-field edit access, host-entity update access, and update access on the specific paragraph — the toggle is therefore available to exactly the people who may already edit that layout. Requires `paragraphs` and `layout_paragraphs (^2)`; installed version is 1.0.2 on core `^8.8` through `^11`. There is no configuration UI, no settings, and no permission of its own — the display of the control itself is additionally guarded by core's `view unpublished paragraphs` permission. Two operational notes: an unpublished paragraph is hidden but still present, so it keeps its delta, still exports, and still reaches anything reading the field directly; and confirm your view modes and any API/decoupled consumers actually respect the paragraph's published flag, because not all rendering paths do.

---

- Hide a page section temporarily without deleting it.
- Unpublish a seasonal promotion after a campaign ends.
- Hold a section back pending legal or editorial sign-off.
- Keep a component in place but not shown on the live page.
- Toggle a hero banner off once an event is over.
- Avoid the delete-and-rebuild cycle for a section you may need again.
- Stage a section in advance and publish it at launch.
- Hide a component during a maintenance window.
- Prepare next month's content inside the current layout.
- A/B compare two versions of a section by unpublishing one.
- Temporarily remove an out-of-date announcement.
- Preserve a draft component's content and settings while hidden.
- Support a lightweight editorial review step in the builder.
- Retire a component gradually rather than deleting it outright.
- Give editors a quick per-section on/off without touching content moderation.
- Let a marketer hide underperforming sections themselves.
- Turn a promotional block off and on across a sale window.
- Manage which of a page's many sections are live at any time.
- Show reviewers the full page including hidden sections (with `view unpublished paragraphs`).
- Keep an approved-but-not-yet-live layout ready to flip on.
