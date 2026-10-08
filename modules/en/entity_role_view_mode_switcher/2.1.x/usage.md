<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Role View Mode Switcher renders an entity in a different view mode depending on the current user's role, using reusable "Rule" config entities referenced from the entity.

---

Entity Role View Mode Switcher lets you show the same entity in a different view mode to different roles. You build one or more **View Mode Switcher Rules** (config entities) in the admin UI; each rule holds an ordered list of conditions, and every condition maps a role plus an original entity/view-mode to a replacement entity/view-mode (optionally negated). You then add an **entity reference field targeting the `rule` entity type** to a bundle (e.g. a content type) and pick a rule when editing an entity. At view time the module's `hook_entity_view_mode_alter()` finds that reference field, walks the referenced rules' conditions in order, and swaps the view mode for the first condition whose role and original view mode match the current request. It ships no dependencies and works on Drupal 8 through 11. It is a presentation feature: it changes which display renders, not what a user is permitted to reach, so genuinely sensitive fields should still be protected with real field/entity access.

---

- Show a fuller display of a node to editors and a trimmed one to anonymous visitors, from the same URL.
- Build a lightweight paywall where a "premium" role sees the full article and others see a teaser.
- Give members and non-members different displays of the same content.
- Swap the default view mode to a role-specific one per individual entity.
- Attach an entity-reference-to-`rule` field to a content type to enable switching on its nodes.
- Reuse one rule across many entities by referencing the same rule config entity.
- Apply several rules to one entity and have their conditions evaluated in order (first match wins).
- Negate a condition so it fires for every role except the selected one.
- Map an entity type's `teaser` view mode to its `full` view mode for a specific role.
- Show a "call to action" view mode to anonymous users while authenticated users see the standard one.
- Present a compact card display to one role and a detailed display to another.
- Vary the display of media, taxonomy terms, or any fieldable entity that carries the reference field.
- Keep display logic in exportable configuration (rules are config entities, so they deploy with your config sync).
- Manage rules from Structure → View Mode Switcher Rule (add, edit, delete via the admin list).
- Add or remove conditions on a rule dynamically with the form's AJAX "Add Condition" / "Remove" buttons.
- Switch a node between two custom view modes you defined for a particular role.
- Offer role-specific layouts without cloning the entity or writing a custom formatter.
- Combine with membership/subscription modules that assign a role to gate which display members receive.
- Fall back to the requested view mode automatically when no condition matches (no switch occurs).
- Target a single entity type per condition (keep original and new view modes on the same entity type).
- Roll out different presentations per role during a phased content redesign.
