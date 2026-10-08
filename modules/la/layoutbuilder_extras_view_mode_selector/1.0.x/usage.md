<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Builder View Mode Selector improves the view-mode picker an editor sees when placing a block in Layout Builder: it lets a site builder choose which view modes are offered, and attach icons so the choice is visual rather than a list of machine-ish labels.

---

Layout Builder exposes every view mode configured for a block type, which for a mature site means a dropdown containing `Default`, `Teaser`, `Card`, `Card wide`, `Card no image`, `Full` and half a dozen internal modes that were never meant for editors. The result is a picker where the right answer is hard to find and the wrong answers are indistinguishable. This module narrows and illustrates it: `BlockContentTypeEditForm` extends the block content type form so a site builder marks which view modes are exposed and assigns icons, `ViewModeSelectorHelper` and `src/Plugin` apply that to the Layout Builder UI. It depends on core `layout_builder` only, with core `^10 || ^11`. Note the unconventional directory layout — configuration schema lives in `install/schema` rather than `config/schema` — and that the project description's "on steriods" typo is upstream. There are no routes or permissions of its own; the settings live on the block content type form, so they are governed by whoever may administer block types.

---

- Hide internal view modes from editors in Layout Builder.
- Show icons instead of view mode labels.
- Make the block placement picker visual.
- Expose only the card variants editors should use.
- Reduce mistakes when placing blocks.
- Give a design system's variants clear names.
- Configure exposed view modes per block type.
- Improve Layout Builder usability on a mature site.
- Prevent editors selecting an internal display.
- Speed up page building.
- Match the picker to a component library.
- Reduce training needed for Layout Builder.
- Illustrate layout choices with thumbnails.
- Keep view modes available to code but hidden from editors.
- Improve consistency of component usage.
- Support a large block type catalogue.
- Give editors confidence choosing a display.
- Curate the editorial experience.
