<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Vanta Modifier adds an animated WebGL/Three.js background (via the Vanta.js library) to page elements through the Modifiers framework.

---


It ships a Paragraph bundle that plugs into a `field_modifiers` field on a block, paragraph, or Look. The Modifiers module reads the paragraph's values and, through this module's `VantaModifier` plugin, emits the CSS selector plus Vanta effect settings (effect type, colors, media queries) as drupalSettings that a JS behavior turns into a live animated background. No routes, permissions, or services are added; it is purely a rendering-time Modifier plugin. The Vanta.js library (and its Three.js/p5 dependency) must be installed in the site `libraries/` folder or via composer — the module only attaches it.

Setup: install Modifiers + Paragraphs, download the Vanta library, add the Vanta Modifier paragraph to a `field_modifiers` field, pick an effect and colors, and save the host entity.
---
- Add an animated Vanta background to a hero block.
- Attach the Vanta Modifier paragraph to a `field_modifiers` field.
- Choose a Vanta effect (waves, birds, net, fog, etc.).
- Set the background base color for the effect.
- Set the highlight/secondary color of the effect.
- Restrict the animation to a CSS selector on the host element.
- Apply the effect only within a media query breakpoint.
- Decorate a paragraph component with a moving background.
- Add motion to a Look/landing page section.
- Install the Vanta.js library via the documented composer package repo.
- Install the Vanta.js library manually into `libraries/vanta`.
- Layer readable content over an animated backdrop.
- Reuse the same effect config across multiple components.
- Tune effect parameters exposed by the paragraph fields.
- Disable the effect on small screens with media queries.
- Combine with other Modifiers plugins on the same field.
- Preview the effect on a paragraph before publishing.
- Remove the modifier to drop the animation without deleting the host.
