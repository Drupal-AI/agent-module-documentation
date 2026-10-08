<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DRD ECA events

## Install

```bash
drush en drd_eca -y
```

Requires `drd` and `eca` (^2). No configuration of its own.

## The event plugin

`src/Plugin/ECA/Event/DrdEvent.php` — `@EcaEvent(id = "drd", deriver =
"…\DrdEventDeriver", eca_version_introduced = "4.1.0")`, extends `eca`'s `EventBase`. The deriver
(`DrdEventDeriver`, extends `EventDeriverBase`) simply returns `DrdEvent::definitions()`, producing
two selectable ECA events:

| ECA event id | Label | DRD event name | Event class |
|---|---|---|---|
| `drd_eca_action_started` | DRD: Action started | `drd.action.started` | `Drupal\drd\Event\DrdActionStart` |
| `drd_eca_action_finished` | DRD: Action finished | `drd.action.finished` | `Drupal\drd\Event\DrdActionFinish` |

These names come from `Drupal\drd\Event\DrdEvents` (base module). Both are dispatched by
`Drupal\drd\ActionManager::executeAction()` — `ACTION_STARTED` before the action runs and
`ACTION_FINISHED` after — wrapping every DRD remote action, whether triggered from the UI, Drush,
cron or the Advanced Queue processor.

## Tokens exposed

`DrdEvent::buildEventData()` (annotated with `#[Token]`) publishes, when the dispatched event is a
`Drupal\drd\Event\DrdBase`:

- `drd_action_id` — the action plugin id (e.g. `drd_action_php`, `drd_action_flush_cache`), from
  `$event->getAction()->getPluginId()`.
- `entity` — the DRD entity the action targets (a `drd_host`, `drd_core` or `drd_domain`), from
  `$event->getEntity()` (present only when the action is entity-bound).

Both are exposed under the `event` token and are usable in ECA conditions/actions downstream.

## Modelling notes

- Build an ECA model, choose event **DRD: Action started** or **finished**, then branch on
  `[event:drd_action_id]` and operate on `[event:entity]`.
- Because the events fire around *every* DRD action, add an ECA condition on `drd_action_id` if you
  only care about specific operations.
- The submodule contributes no ECA *actions*; to act on the fleet, call DRD's own Action plugins
  (they are core Action plugins and thus invokable from ECA) or standard ECA actions.
