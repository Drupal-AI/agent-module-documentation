<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides a simple block that outputs a random caption title from the animated TV show Futurama.

---

Futurama is a small, novelty module. It defines one block plugin, `FuturamaBlock` (admin label "Futurama quote of the day", category "Futurama"), whose `build()` method picks a random entry from a hard-coded list of ~110 Futurama caption gag titles (returned by `futurama_title_captions()` in the `.module`) and renders it as markup. The captions are wrapped in `t()` and some contain small inline HTML (e.g. `<i>`, `<br />`), which is emitted via `#markup`.

There is no configuration, route, permission or service — you enable the module and place the block in any region via Block layout. A `futurama_generate` directory exists with some Form/Controller classes but ships no `.info.yml` or routing, so it is not an installable submodule in this release. The module is useful as a lighthearted site touch or as a minimal reference example of a Drupal block plugin.

---

- Place a "Futurama quote of the day" block in a region.
- Show a random Futurama caption on each page load.
- Add a fun element to a site footer or sidebar.
- Use as a minimal example of a Block plugin.
- Demonstrate `futurama_title_captions()` returning a caption list.
- Render random markup via a block's `build()`.
- Teach new developers how block plugins work.
- Add whimsy to a demo or personal site.
- Show a rotating quote without any configuration.
- Combine with block visibility conditions to scope where it appears.
- Restrict the block to certain pages via block config.
- Cache-bust to see a different caption (dynamic content).
- Use in a Layout Builder section as a decorative block.
- Provide a conversation-starter block on an about page.
- Enable/disable purely for fun with no side effects.
- Reference for wrapping strings in `t()` within a module.
- Style the block output with theme CSS.
- Place multiple instances in different regions.
- Use as filler content during theme development.
- Show a Futurama gag title on the maintenance/landing area.