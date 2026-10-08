<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Status-indicator styling

The control renders as a small round dot in each component's Layout Paragraphs control bar. It is not a
labelled button — the accessible link text (`Publish` / `Unpublish`) is present but visually the dot is
the affordance. Styling comes entirely from one CSS file, attached via the library
`layout_paragraphs_toggle_publish/toggle_form` (defined in `layout_paragraphs_toggle_publish.libraries.yml`,
weight group `layout`).

`css/layout-paragraphs-toggle-publish.css`:

```css
.lpb-controls-publish-toggle {
  opacity: 1;
  width: 15px;
  height: 15px;
  border-radius: 100px;
  margin: 8px;
}
.lpb-controls-publish-toggle.is-published {
  background-image: radial-gradient(#00c000, #00d900);   /* green */
}
.lpb-controls-publish-toggle.not-published {
  background-image: radial-gradient(#de9201, #ffa500);   /* orange */
}
```

Classes to target when restyling in a theme:
- `.lpb-controls-publish-toggle` — the dot base (size, shape, spacing).
- `.is-published` — published state (green by default).
- `.not-published` — unpublished state (orange by default).

Notes:
- The link also carries the core `use-ajax` class — do not remove it; it drives the inline toggle.
- On toggle, the controller adds/removes `paragraph--unpublished` on the component wrapper
  (`[data-uuid="…"]`), so you can additionally style the whole hidden component (e.g. dim it) via that class.
- There is no light/dark or configurable palette; override the two `background-image` rules in your theme
  to change colors, and consider adding a visible label/tooltip if the color-only cue is an accessibility
  concern for your editors.
