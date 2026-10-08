# Paragraphs Role Visibility — agent index

A Paragraphs **behavior plugin** that restricts viewing of an individual paragraph to selected roles,
enforced via real entity access (`hook_paragraph_access`), not CSS. No config page (`configure` null), no
permissions of its own, no Drush, no config schema. Depends on `paragraphs`.

- **The behavior plugin, its form/storage, and the access-control logic** →
  [plugins/role-visibility.md](plugins/role-visibility.md)

Key facts:
- Behavior plugin `paragraphs_role_visibility` ("Paragraph visibility"),
  `src/Plugin/paragraphs/Behavior/ParagraphsRoleVisibility.php` (extends `ParagraphsBehaviorBase`).
- Settings stored in the paragraph's behavior settings: `wrapper.roles` (checkboxes) + `wrapper.operand`
  (`or` = Any / `and` = All).
- Enforcement: `hook_paragraph_access` (`src/Hook/ParagraphsRoleVisibilityHooks::paragraphAccess`) returns
  `AccessResult::forbidden()` for the `view` operation when the user's roles don't satisfy the configured
  roles+operand; else neutral. Adds `user.roles` cache context + paragraph cacheable dependency.
- This is genuine entity-access control (gates rendering/data), not display-only hiding.
- `hook_update_9201` migrates legacy flat role lists into `wrapper.roles`/`operand`.
