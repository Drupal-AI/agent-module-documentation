# scheduler_rules_integration — agent start

Scheduler sub-module. Exposes Scheduler publishing/unpublishing to the **Rules** module.
Requires `scheduler` + `rules`. No config UI, no permissions, no Drush — all use is via the
Rules reaction-rule interface. Nothing to configure here beyond building rules.

Provides (derived per supported entity type: node, media, taxonomy_term, commerce_product):

- **Events** (`src/Event/Rules{Type}Event.php`) — fire when Scheduler has published or
  unpublished an entity; use them as the trigger of a reaction rule.
- **Conditions** (`src/Plugin/Condition/`) — `PublishingIsEnabled`, `UnpublishingIsEnabled`,
  `ScheduledForPublishing`, `ScheduledForUnpublishing` (plus `Legacy/*` variants).
- **Actions** (`src/Plugin/RulesAction/`) — `SetPublishingDate`, `SetUnpublishingDate`,
  `RemovePublishingDate`, `RemoveUnpublishingDate`, `PublishNow`, `UnpublishNow`
  (plus `Legacy/*` variants).

To automate anything, add a Rules reaction rule that reacts to a Scheduler event and/or uses
these conditions and actions. For the underlying publish/unpublish engine and its own events see
the parent module docs (`modules/scheduler/2.3.x/`).
