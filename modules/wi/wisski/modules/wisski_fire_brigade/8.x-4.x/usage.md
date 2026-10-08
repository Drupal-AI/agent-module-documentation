<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WissKI Fire Brigade is a maintenance and repair module — its own description calls it an attempt to extinguish the ever-burning WissKI fire.

---

The name and description are candid, and that candour is the most useful thing to record. A system spanning Drupal, a triple store, a pathbuilder mapping and several external authority services has many ways to end up inconsistent, and this module exists to clean up after them.

Take it as a signal about operating WissKI rather than as a feature to plan around. A research infrastructure of this complexity needs someone who understands its internals available to it — the fire brigade is a set of tools for that person, not something a site builder configures and forgets.

**Before running any repair tool against a triple store, take a backup.** Repair operations by their nature modify data that is already in an unexpected state, and "fixing" a symptom can destroy the evidence needed to understand the cause. Work on a copy where possible, understand what a given repair does before invoking it, and record what was run — an undocumented repair is indistinguishable, later, from data corruption.

---

- Clean up an inconsistent WissKI installation.
- Repair data after a failed operation.
- Diagnose a system in an unexpected state.
- Back up before running a repair.
- Work on a copy where possible.
- Understand a repair before invoking it.
- Record what repairs were run.
- Preserve evidence of a root cause.
- Recognise the module's candid framing.
- Plan operational support for WissKI.
- Assess the expertise a project needs.
- Audit repairs performed on an installation.
- Avoid repeated symptomatic fixes.
- Escalate a recurring inconsistency.
- Document known inconsistency modes.
- Build a runbook for recovery.
