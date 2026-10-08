<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Builder Instant Preview re-renders a custom block or layout section in place as you edit it in Layout Builder, instead of only after you save.

---

In stock Layout Builder, editing a block means filling a form in the off-canvas sidebar, clicking Save, and only then seeing the result on the page — and if it is wrong, reopening the form and doing it again. For anything visual that loop is slow enough to change how people work: editors stop iterating and accept the first version that is not obviously broken.

This module closes the loop for **custom (inline) blocks** and for **layout-section configuration**. It replaces three core Layout Builder routes (`layout_builder.add_block`, `layout_builder.update_block`, `layout_builder.configure_section`) with enhanced forms that add a **Preview** button, a **Cancel** button, and an **Automatic preview** checkbox. A JavaScript behavior listens for core's `formUpdated` event (and CKEditor 5 `change:data`, and Media Library reloads) and, while the checkbox is ticked, re-submits the form in preview mode on a short debounce. Preview mode runs the block/section through its **real render path** and rebuilds the layout, but deliberately does **not** write the change to the Layout Builder tempstore — so a preview is discarded, and only Save persists it. Cancel (also fired when the tray is closed with the X or Esc) restores the last saved section state. It explicitly skips reusable `block_content` blocks, which core already previews.

Two things to weigh before rolling it out on a busy editorial site. First, live preview is a request per keystroke-ish change; core debounces `formUpdated` by 300ms and this module adds 200ms more (500ms for CKEditor 5), but an unthrottled-feeling preview on a heavy block still means many extra render round-trips. Second, because preview runs the block's real render path, anything expensive there — an external API call, an uncached view, an image derivative — happens repeatedly during editing rather than once on save. Neither is a reason to avoid it; both are reasons to try it on the site's heaviest block first. The per-user **Automatic preview** toggle (remembered in `localStorage`) and the site-wide `show_enable_preview_checkbox` config setting let you turn it down when needed.

---

- Preview a custom inline block live as its fields are edited.
- Preview layout-section settings live while configuring an existing section.
- Stop the fill-save-look-repeat loop for visual blocks.
- Encourage editors to iterate on wording and layout.
- See CKEditor 5 rich-text changes reflected as you type.
- See Media Library image/media selections reflected immediately.
- Keep the familiar off-canvas sidebar (no modal dialog) while previewing.
- Let each editor turn Automatic preview on or off for themselves (remembered per browser).
- Hide the Automatic preview checkbox site-wide via `show_enable_preview_checkbox` config.
- Discard a trial edit by clicking Cancel, closing the tray, or pressing Esc.
- Save only when the preview looks right — previews are never persisted.
- Preview partially-filled blocks without validation errors blocking the render.
- Migrate from Panopoly Magic to a Layout-Builder-focused, sidebar-based equivalent.
- Provide a Drupal 10/11 + CKEditor 5 compatible live-preview experience.
- Reduce abandoned or half-finished block edits.
- Improve editor confidence in what a block will look like when published.
- Test preview cost on the site's heaviest block before a wide rollout.
- Audit which blocks make expensive calls in their render path during editing.
- Avoid repeated image-derivative generation by watching preview volume.
- Combine with the rest of the Layout Builder editing toolset.
- Measure editing-time request volume when tuning debounce expectations.
- Document the route-override behavior for the team before upgrades.
- Re-verify its assumptions after a core Layout Builder or CKEditor update.
