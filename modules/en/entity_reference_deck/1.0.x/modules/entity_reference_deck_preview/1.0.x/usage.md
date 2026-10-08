<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Deck Preview renders a live, sandboxed front-end preview of a referenced entity inside its deck card.

---

This optional soft-dep submodule adds live preview to Entity Reference Deck cards using a sandboxed iframe and a Lit web-component shell. It owns the PreviewProvider plugin manager, whose plugins build per-entity-type preview content (hosts ship default providers). Two routes serve the iframe document: a persisted-entity route gated by permission plus entity view access plus a custom access check plus provider access, and a draft-token route that redeems a high-entropy bearer token bound to the creating user and entity from an expirable key-value store. Preview always renders as the current authenticated user (no account switching), draft responses are uncacheable, and documents set Referrer-Policy: no-referrer. It adds preview_refresh and preview_toggle card actions, a preview toolbar group, and a settings form for draft TTL and the responsive/device toolbar. It does NOT ship iframe-resizer (v5) — install it on the site under /libraries. Requires the permission 'use entity reference deck preview'.

---

- Show a live front-end preview of a referenced entity inside its card.
- Preview unsaved draft edits via a short-lived draft token.
- Preview a saved entity via its persisted preview route.
- Refresh a card's preview with the preview_refresh action.
- Show or hide a card's preview with the preview_toggle action.
- Restrict previews to editors with the preview permission.
- Render previews inside a sandboxed iframe.
- Resize the preview iframe to content via site-provided iframe-resizer.
- Offer a responsive device toolbar for previewing breakpoints.
- Use Responsive Preview device presets when that module is installed.
- Configure the draft token TTL on the settings form.
- Keep draft preview responses uncacheable for freshness.
- Set Referrer-Policy no-referrer on preview documents.
- Render previews as the current user without account switching.
- Extend preview to a new entity type with a PreviewProvider plugin.
- Provide default providers via host submodules (e.g. Paragraphs).
- Preview referenced paragraphs from the Paragraphs deck widget.
- Preview selections from the Entity Browser deck widget.
- Bind a draft token to its creating user and target entity.
- Give editors a WYSIWYG-style sense of referenced content before saving.
- Skin the preview toolbar for the admin theme.
- Configure a full-preview width for the toolbar.
