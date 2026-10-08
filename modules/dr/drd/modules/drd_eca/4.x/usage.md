<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ECA for DRD exposes DRD's remote-action lifecycle as ECA events so fleet operations can be automated with the ECA rules engine.

---

This submodule of Drupal Remote Dashboard bridges DRD and the ECA (Event - Condition - Action) module. It registers a single ECA event plugin (id `drd`) with two derivatives — "DRD: Action started" and "DRD: Action finished" — that fire whenever the DRD `ActionManager` dispatches its `drd.action.started` / `drd.action.finished` events around a remote action. Each ECA event exposes the DRD action id and the target entity (host, core or domain) as tokens, so a modeller can build ECA models that react to remote operations across the managed fleet: logging, sending notifications, chaining follow-up actions, or enforcing conditions. It contributes no conditions or actions of its own beyond these events (despite the descriptive name); DRD's own Action plugins are the "actions" that ECA can invoke. Requires the DRD base module and ECA ^2.

---

- Trigger an ECA model whenever any DRD remote action starts (`drd_eca_action_started`).
- Trigger an ECA model whenever any DRD remote action finishes (`drd_eca_action_finished`).
- Read the running action's plugin id from the `drd_action_id` event token to branch per action type.
- Read the target `entity` (drd_host / drd_core / drd_domain) token to act on the specific site.
- Send an email or chat notification when an update or flush-cache action completes on a site.
- Write an audit-log entry each time a privileged remote action (PHP, DB dump, session) is run.
- Chain a follow-up DRD action after another completes, driven by ECA rather than code.
- Gate remote actions with ECA conditions (e.g. only continue during a maintenance window).
- Count or rate-limit remote actions across the fleet from an ECA model.
- Notify an operator when an action finishes with an error state.
- Build no-code automations for routine fleet maintenance without writing an event subscriber.
- Combine DRD action events with other ECA events (cron, entity, webform) in one model.
