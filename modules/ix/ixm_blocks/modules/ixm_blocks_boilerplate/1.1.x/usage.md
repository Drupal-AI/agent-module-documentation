<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
IXM Blocks Boilerplate is the reference component — a complete block type with nothing in it, to copy when adding a new one.

---

Every component in this family follows the same shape: a `block_content` bundle, its fields, a form display, a view display, a template and the module wiring that holds them together. Getting that shape right by hand is fiddly and getting it subtly wrong is the usual outcome — a field that works but is not translatable, a display configured for one view mode and forgotten for another, a template that bypasses the field formatter.

The boilerplate exists so nobody has to remember. Copy it, rename, add the fields the component needs, and the surrounding structure is already correct.

**This is the submodule to read first when evaluating the family from outside**, whether or not you adopt the rest. It documents, by being one, what a properly packaged block type looks like — which is useful to any team building a component library, including one not using IXM Blocks at all.

Do not enable it on a production site. It contributes an empty component that would appear in the block list for editors, which is confusing rather than harmful.

---

- Copy a correctly structured block type.
- Add a new component to the family.
- Learn how to package a block type.
- Avoid a subtly wrong field configuration.
- Get form and view displays right.
- See how a component template is wired.
- Study the pattern without adopting the family.
- Teach a team component packaging.
- Start a project-specific component set.
- Keep new components consistent with existing ones.
- Avoid enabling it in production.
- Remove the empty component from the block list.
- Review the structure during a code review.
- Scaffold faster than writing from scratch.
- Document this component's conventions for the team.
- Review it during a component audit.
- Verify its behaviour after a theme change.
