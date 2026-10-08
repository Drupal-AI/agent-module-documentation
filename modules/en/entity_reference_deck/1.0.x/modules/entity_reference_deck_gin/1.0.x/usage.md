<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Reference Deck Gin is a skin submodule that remaps the deck's --erdeck-* CSS tokens so cards match the Gin admin theme.

---

This optional skin submodule makes Entity Reference Deck cards visually align with the Gin admin theme. Because Drupal core only honours libraries-extend declared by the active theme (not by modules), the module uses LibraryHooks::libraryInfoAlter() to add its 'gin_skin' library as a dependency of the deck card, dialog, EB widget and Paragraphs widget libraries; its CSS then remaps the --erdeck-* custom properties, scoped to body.gin--edit-form. It ships no routes, permissions, services or plugins — purely a token remap. Enable it only when the Gin admin theme is in use.

---

- Match deck card colours and spacing to the Gin admin theme.
- Remap --erdeck-* CSS custom properties when Gin is active.
- Skin the deck card library for Gin edit forms.
- Skin the shared deck dialog chrome for Gin.
- Skin the Entity Browser deck widget for Gin.
- Skin the Paragraphs deck widget for Gin.
- Scope skin overrides to body.gin--edit-form only.
- Avoid theme-level libraries-extend workarounds for module CSS.
- Keep a consistent editor look across all deck host widgets under Gin.
- Enable a polished admin experience without custom theme CSS.
- Leave the default (non-Gin) styling untouched when disabled.
- Pair with any deck host submodule for a unified skin.
- Provide design-token overrides without patching core deck CSS.
- Support sites standardised on the Gin admin theme.
- Add zero PHP logic beyond a single library alter.
- Ship no configuration to manage.
- Layer cleanly on top of core deck styles via dependency ordering.
- Keep card status tags and badges on-brand under Gin.
- Improve contrast/legibility of deck cards in Gin edit forms.
- Turn the skin on or off simply by enabling/disabling the module.
