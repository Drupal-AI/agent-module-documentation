<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Usage Delete Stop builds on the Entity Usage module: per content type, you can forbid deleting a node while other content still references it, so editors cannot remove a page that is linked from elsewhere.

---

Entity Usage tracks which entities reference which, and can display a warning on the node delete form. This addon turns that warning into a stop. It adds an *Entity Usage Node Delete Settings* group to the content type edit form containing one checkbox — *Do not allow deletion of used nodes of this type* — stored as the third-party setting `prohibit_deletion` on the node type. On the node delete confirm form, if that setting is on and Entity Usage has rendered its delete warning, the module appends an error message (*"Deletion is disabled until all usages are removed"*) and sets `#disabled` on the submit button, unless the current user holds `skip node delete stop`. Two conditions gate the whole feature: `node` must be listed in `entity_usage.settings:delete_warning_message_entity_types`, and Entity Usage must actually have produced its warning element — so the stop only applies where a usage warning would have shown. That also defines its boundary: this is a **confirm-form** guard, not entity-level access, so programmatic deletions (Drush, VBO, migrations, API calls) are unaffected.

---

- Stop editors deleting a page that is linked from other content.
- Protect landing pages referenced by menus and blocks.
- Prevent broken references caused by accidental deletion.
- Apply the rule only to content types where it matters.
- Let administrators override the block with a permission.
- Keep an explanatory error on the delete form rather than a silent failure.
- Enforce a "remove usages first" editorial workflow.
- Reduce broken links reported after content clean-up.
- Protect media-heavy pages referenced by paragraphs.
- Complement Entity Usage's warning with an actual stop.
- Configure the rule as part of a content type's settings.
- Export the setting with the content type's config.
- Give trusted editors the skip permission for exceptional cases.
- Avoid writing custom delete-access code.
- Encourage editors to check the usage tab before deleting.
- Protect reference data used by many nodes.
- Keep referential integrity on a large editorial site.
- Prevent deletion of pages embedded in other pages.
- Apply the rule to only one content type during a trial.
- Turn the protection off again by unchecking one box.
