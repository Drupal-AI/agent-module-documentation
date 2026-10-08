<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite Layout Builder assembles the editing experience — contextual operations on blocks and sections, modal editing, and the section library.

---

Core's Layout Builder works and is not pleasant: operations are behind small contextual links, editing opens a sidebar that covers the thing you are editing, and there is no way to save a section you have built for reuse. This submodule addresses each of those for VLSuite.

`layout_builder_operation_link` puts operations where an editor expects them, `vlsuite_modal` moves editing into a modal so the page stays visible behind it, and `section_library` adds the missing verb: save this section, use it again elsewhere. Together they turn Layout Builder from something an editor tolerates into something they will use.

The section library is the piece with the largest effect on a real site, and the one that needs governance. A library anyone can add to accumulates near-duplicates within a few months, at which point editors stop using it and rebuild sections by hand. Decide who curates it before it fills up — the same point that applies to `lb_plus_section_library`.

---

- Edit a block in a modal rather than a sidebar.
- See block operations where you expect them.
- Save a built section to a library.
- Reuse a saved section on another page.
- Keep the page visible while editing.
- Give editors a workable Layout Builder.
- Apply utility classes from the editing UI.
- Reduce the clicks to edit a component.
- Build a library of approved sections.
- Curate the section library.
- Avoid near-duplicate saved sections.
- Speed up landing page assembly.
- Train editors on one consistent UI.
- Combine contextual operations with modals.
- Audit what is in the section library.
- Retire an unused saved section.