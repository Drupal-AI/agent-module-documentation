<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Revision Graph (revision_graph) — agent index

Adds a tab showing an entity's **revision history as a graph** rather than a list.
Version **3.1.1**. Core `^10 || ^11`. No dependencies or permissions of its own — access follows
whatever governs the entity's revision tab.

**Why a list is not enough:** with workspaces, moderation drafts alongside a published version, or
independently revised translations, history stops being linear. Two revisions from the same
afternoon may be on different branches, and a list shows them as neighbours.

**Where it earns its place:** "my change disappeared" — reverted, superseded by a draft made from
an earlier revision, or lost in a translation workflow. The list makes that archaeology; the graph
usually makes it obvious.

Confirm revision-tab access on sites where **history itself** is sensitive — a graph makes it much
easier to read.