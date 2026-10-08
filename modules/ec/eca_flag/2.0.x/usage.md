<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ECA Flag connects the Flag module to ECA, so flagging and unflagging an entity become events that can start an automated workflow, whether an entity is flagged becomes a condition, and loading an entity's flaggings becomes an action.

---

Flag provides the "bookmark this", "report this", "mark as read" primitive; ECA (Event–Condition–Action) provides no-code automation on Drupal's event system. This module is the bridge. Its ECA event plugin `flag` derives four events — `flag:flag`, `flag:unflag`, `flag:insert`, `flag:delete` — the first pair wrapping Flag's own `ENTITY_FLAGGED`/`ENTITY_UNFLAGGED` events and the second pair fired from `hook_flagging_insert`/`hook_flagging_delete`; each pushes `flagging`, `flag` and `entity` tokens (or a `flaggings` list when a bulk unflag touches many entities). The condition `eca_flag_entity_is_flagged` tests `flag->isFlagged(entity)`, and the action `eca_flag_get_flagging` loads an entity's flagging(s) onto a token. Flagging and unflagging themselves are done with the Flag module's own ECA actions. There are no routes, permissions or settings — everything lives in the ECA model (trusted site config), typically a BPMN modeller. Watch for loops: a model that both listens for flag events and performs flag actions can trigger itself, so add a condition that breaks the cycle.

---

- Send an email when content is flagged.
- Notify a moderator when a post is reported.
- Flag content automatically when it is published.
- Unflag items when a workflow completes.
- Start an approval process from a flag.
- Track "read" state through automation.
- Add content to a queue when bookmarked.
- Escalate after a number of reports on the same entity.
- Flag stale content on a schedule.
- Clear flags when content is archived.
- Notify an author when their content is bookmarked.
- Drive a moderation workflow from flag events.
- Branch a model on whether an entity is already flagged (`eca_flag_entity_is_flagged`).
- Load an entity's flagging with `eca_flag_get_flagging` and read its fields in later steps.
- React to a bulk unflag by iterating the `flaggings` token list.
- Combine flag events with other ECA conditions.
- Build a no-code reporting workflow.
- Sync a flag to an external system.
- Log flag activity through ECA.
- Flag an entity from a form submission.
- Automate a "favourites" digest.
- Act on the flagged entity via the `entity` token when a flagging is inserted.
- Take a different path when unflagging removes the last flag on an item.
