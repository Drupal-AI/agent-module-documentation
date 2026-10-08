<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Wingsuit Layout Builder makes Wingsuit components placeable in Layout Builder, using Layout Builder Browser for the picker.

---

A component library is only as useful as the places editors can put its components. This submodule connects Wingsuit's components to Layout Builder so they appear as things an editor can drop into a section, with Layout Builder Browser supplying a categorised, visual picker rather than the default flat list.

The picker matters more than it sounds on a site with a real component library. Layout Builder's stock block list is a long alphabetical dropdown; once a site has thirty components, that list is where editors give up. Layout Builder Browser groups and illustrates them, which is what turns a library into something people actually use.

It is a thin bridge — the components come from the Wingsuit project, the placement mechanics come from Layout Builder, and this connects the two. Its only declared dependency is `layout_builder_browser (>=1.7)`, so on a site already running Wingsuit and Layout Builder it is a small addition.

---

- Place Wingsuit components in Layout Builder.
- Give editors a visual component picker.
- Group components by category in the picker.
- Avoid a flat alphabetical block list.
- Make a large component library usable.
- Build landing pages from front-end components.
- Combine Layout Builder sections with Wingsuit cards.
- Keep component source in the front-end project.
- Add a new component and have it appear for editors.
- Reduce the time editors spend hunting for a block.
- Illustrate components in the picker.
- Restrict which components are placeable.
- Support a design system inside Layout Builder.
- Audit which components editors actually place.
- Plan editor training around the component library.