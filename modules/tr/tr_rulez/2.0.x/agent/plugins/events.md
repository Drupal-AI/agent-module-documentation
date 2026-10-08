<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events added by tr_rulez

Declared in `tr_rulez.rules.events.yml` and backed by event classes in `src/Event/`. Dispatched from hooks in `tr_rulez.module`. These become "React on event" triggers in reaction rules.

## `tr_rulez.user_was_blocked` — "After a user was blocked" (category: User)
- Context: `account` (`entity:user`) — the user after being blocked.
- Dispatched from `tr_rulez_user_update()` (`hook_user_update`) when `!$original->isBlocked() && $account->isBlocked()`.
- Class: `src/Event/UserWasBlockedEvent.php` (`EVENT_NAME = 'tr_rulez.user_was_blocked'`, public `$account`).

## `tr_rulez.user_was_unblocked` — "After a user was unblocked" (category: User)
- Context: `account` (`entity:user`).
- Dispatched from `tr_rulez_user_update()` on the reverse transition (`$original->isBlocked() && !$account->isBlocked()`).
- Class: `src/Event/UserWasUnblockedEvent.php`.

## `tr_rulez.entity_bundle_create` — "After creating a new entity bundle" (category: Entity)
- Context: `entity_type` (string), `bundle_name` (string).
- Dispatched from `tr_rulez_entity_bundle_create()` (`hook_entity_bundle_create`).
- Class: `src/Event/BundleCreatedEvent.php` (public `$entity_type`, `$bundle_name`).

## `tr_rulez.entity_bundle_delete` — "After deleting an entity bundle" (category: Entity)
- Context: `entity_type` (string), `bundle_name` (string).
- Dispatched from `tr_rulez_entity_bundle_delete()` (`hook_entity_bundle_delete`).
- Class: `src/Event/BundleDeletedEvent.php`.

## Notes for agents
- These four events were renamed in the 2.0 line: update hooks `tr_rulez_update_8101()` / `8102()` (`tr_rulez.install`) migrate stored reaction-rule config and `state('rules.registered_events')` from the old `tr_rulez_user_was_blocked` / `tr_rulez_entity_bundle_create` (etc.) names to the dotted `tr_rulez.*` names, and invalidate the corresponding cache tags. Exported YAML on disk is NOT auto-updated — re-export after running updates.
- `rules_examples` includes configs demonstrating these (e.g. `rules.reaction.user_has_been_blocked.yml`, `bundle_create_event.yml`, `bundle_delete_event.yml`).
