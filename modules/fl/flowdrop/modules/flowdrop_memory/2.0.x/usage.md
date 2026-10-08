<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FlowDrop Memory gives workflows and agents somewhere to remember things, with pluggable backends — static, cached or entity-backed — and explicit scoping.

---

An agent that cannot remember is a function call. Memory is what turns a sequence of model calls into something that accumulates: what was already tried, what the user said earlier, what a previous run concluded. The engineering questions are where it is kept and how long it lives, and this submodule makes both explicit rather than implicit.

**Scoping** is the important half. Memory scoped to a session belongs to one conversation; memory scoped to a user follows them between sessions; memory scoped to a workflow is shared by every run of it. Getting that wrong is how one user's context leaks into another's answer, which is a correctness problem and, where the content is personal, a privacy one. Choosing the scope deliberately is the point of having it as a first-class concept.

**Pluggable storage** covers the lifetime question: static for within-run scratch, cached for cheap and expendable, entity-backed for anything that must survive, be queryable, or be deletable on request. That last property matters more than it sounds — an agent's memory of a person is personal data, and being able to delete it is a requirement, not a feature.

---

- Give an AI agent memory between steps.
- Remember what a user said earlier.
- Carry context across a conversation.
- Scope memory to a session.
- Scope memory to a user.
- Share memory across runs of a workflow.
- Keep scratch state within a single run.
- Use cache storage for expendable memory.
- Persist memory as entities.
- Query stored agent memory.
- Delete a person's agent memory on request.
- Avoid leaking one user's context into another's.
- Choose a memory backend per use case.
- Expire memory after a period.
- Audit what an agent has remembered.