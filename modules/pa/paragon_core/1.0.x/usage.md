<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Base module for Paragon distribution projects that relabels and reorders node local tasks (admin tabs).

---

Paragon Core is a tiny shared-base module: its only behaviour is a `hook_local_tasks_alter()` implementation (delegated to `Drupal\paragon_core\LocalTasksAlter`) that renames and reweights admin local task tabs for a consistent editorial UX across Paragon sites. It renames the Layout Builder tab to "Layout Builder", relabels the Content Moderation "Workflows" tab to "Preview" (and moves it to the front), renames the node version-history tab to "Version History", moves the node Edit tab to weight 2, and removes the node Delete-form tab entirely.

It ships no routes, permissions, services, config, or entities; it is intended to be enabled as a dependency of Paragon front-end/admin packages (e.g. paragon_gin). Because the Delete tab is only hidden from the local-tasks bar, the underlying delete route and its access checks are unchanged — this is presentation only, not access control.

---
- Enable as a base dependency of a Paragon-based site or of `paragon_gin`.
- Present a consistently named "Layout Builder" tab across node types.
- Relabel the Content Moderation workflows tab to "Preview" for editors.
- Surface the moderation/preview tab first (weight 0) in the tab bar.
- Rename the node revisions tab to "Version History".
- Reorder the node Edit tab (weight 2) relative to other tabs.
- Hide the node Delete tab from the local-tasks bar for a cleaner editor UI.
- Standardise admin tab wording across multiple Paragon projects from one place.
- Use as a lightweight place to add further shared Paragon customisations.
- Ship a consistent editor tab order regardless of which modules are enabled.
- Discourage accidental node deletion by removing the Delete tab from the tab bar.
- Keep the "Preview" (moderation) tab as the first thing editors see on a node.
- Align Layout Builder tab naming with the Paragon editorial vocabulary.
- Provide a single dependency that carries Paragon's shared admin-UX tweaks.
- Combine with paragon_gin to deliver the full Paragon admin experience.
- Audit the local-task overrides in `LocalTasksAlter` before extending them.
- Confirm the delete route still works even though its tab is hidden.
- Adjust the node Edit tab position relative to View/Preview tabs.
- Serve as the base layer other Paragon feature modules depend on.
- Reuse across sites so admin-tab labels never drift between installs.
