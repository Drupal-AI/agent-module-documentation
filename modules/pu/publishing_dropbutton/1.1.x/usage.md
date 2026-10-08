<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Publishing Dropbutton restores the split "Save and publish / Save as unpublished" button to the node form, replacing the separate checkbox-and-save arrangement that later Drupal versions adopted.

---

Drupal 8 originally shipped a dropbutton on the node form: the primary action was the most likely one and the alternatives sat in a dropdown, so publishing state was chosen as part of saving rather than as a separate step. Core later moved to a Published checkbox plus a single Save button, which is simpler to implement and, for many editorial teams, a step backwards — the state change becomes easy to miss, and with Content Moderation the moderation state select adds another control to notice. This module puts the dropbutton back for both node and `content_moderation` workflows: `src/NodePublishingDropbutton.php` builds the control and `src/Plugin` integrates it. It depends only on core `system (>=8.4)`, has no routes, permissions or configuration, and spans `^9.1 || ^10 || ^11`. Its `test_dependencies` mention `workbench_moderation`, a hint at its lineage from the era when that was the moderation module. It changes presentation only — the same permissions decide what an editor may publish, and the same states exist.

---

- Restore the save-and-publish dropbutton.
- Make publishing state explicit at save time.
- Reduce accidental publishing.
- Give editors a familiar Drupal 8 control.
- Combine save and moderation state in one action.
- Reduce missed state changes.
- Improve the node form for a moderation workflow.
- Show alternative save actions in a dropdown.
- Match an editorial team's expectations.
- Reduce training on publishing state.
- Make the primary action obvious.
- Avoid a separate published checkbox.
- Support a content moderation workflow.
- Improve editorial confidence at save.
- Speed up publish-and-return workflows.
- Restore behaviour after a core upgrade.
- Make unpublishing a deliberate choice.
- Reduce support questions about publishing.
