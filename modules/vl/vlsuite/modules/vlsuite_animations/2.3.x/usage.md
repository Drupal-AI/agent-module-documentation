<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite Animations adds configurable entrance and scroll animations to the suite's blocks, sections and layouts.

---

Motion is one of the things editors ask for and one of the easiest to do badly. Offering it as a per-instance setting on components — fade in, slide up, on scroll into view — gives the editor the control they want inside a vocabulary the design defines, rather than each project inventing its own scroll library.

`vlsuite_block` and `vlsuite_layout` both depend on this, so animation is available wherever a component or section is placed.

**Accessibility is not optional here.** A visitor who has set `prefers-reduced-motion` has told the browser that motion causes them problems — for some people vestibular disorders make it genuinely disabling, not merely annoying. Check what the shipped CSS does with that media query and, if it does nothing, add it in the theme. This is the single most important thing to verify about any animation module.

The second thing to watch is accumulation. Animation on one hero is a design decision; animation on every block on a page is a page that fights the reader. Whether that is controlled by convention or by restricting the setting is a decision worth making before editors discover it.

---

- Fade a section in on scroll.
- Animate a component's entrance.
- Give editors controlled motion options.
- Apply animation per instance.
- Animate a hero band.
- Keep motion within a defined vocabulary.
- Respect prefers-reduced-motion.
- Add a reduced-motion override in the theme.
- Avoid animating every block on a page.
- Restrict who may add animation.
- Replace a per-project scroll library.
- Standardise transitions across a site.
- Test animation with reduced motion enabled.
- Audit pages with excessive motion.
- Document motion guidelines for editors.