<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WissKI Text Analysis provides an API for analysing text and an editor UI that proposes annotations for a cataloguer to accept.

---

A catalogue entry's prose mentions people, places, dates and materials that are not in any structured field. Named entity recognition can find them; the question is what to do with what it finds.

This submodule's answer is the right one: **propose, do not apply.** The analysis produces annotation proposals surfaced in the editor, and a cataloguer accepts or rejects them. That keeps the human judgement where it belongs — an algorithm that decides "Turner" is the painter rather than the place will be wrong often enough to matter, and a collection that absorbs those decisions silently loses the reliability that justifies it existing.

The workflow is also the efficient one. Reading a paragraph and clicking to confirm four entities is much faster than typing them, and the cataloguer stays in control of what is asserted.

**Ships under the project's `legacy/` directory**, so check the current recommended path before adopting it — but the propose-don't-apply pattern is worth carrying into whatever replaces it.

---

- Find entities mentioned in catalogue prose.
- Propose annotations to a cataloguer.
- Accept or reject a proposed annotation.
- Keep human judgement in the loop.
- Speed up entity tagging.
- Avoid silently absorbing algorithmic decisions.
- Disambiguate a name in context.
- Extract dates from description text.
- Extract places from prose.
- Build an analysis pipeline.
- Check its legacy directory status.
- Find the current recommended path.
- Carry the propose-don't-apply pattern forward.
- Audit accepted versus rejected proposals.
- Measure extraction accuracy.
