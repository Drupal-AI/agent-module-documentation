<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FlowDrop Memory (flowdrop_memory) — agent index

Submodule of **flowdrop**. **Scoped, pluggable memory** for workflows and AI agents — static,
cached, entity-backed. Version **2.0.0**. Core `^11.3`.

**Scoping is the half that matters.** Session scope = one conversation; user scope = follows them
between sessions; workflow scope = shared by every run. Getting it wrong leaks one user's context
into another's answer — a correctness bug and, where the content is personal, a privacy one.

**Storage choice = lifetime.** Static for within-run scratch; cached for cheap and expendable;
entity-backed for anything that must survive, be queryable, or be **deletable on request** — an
agent's memory of a person is personal data, so deletability is a requirement.