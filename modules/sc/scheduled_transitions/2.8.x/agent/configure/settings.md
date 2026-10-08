<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration

Settings form: **Configuration → Workflow → Scheduled transitions settings**
(`/admin/config/workflow/scheduled-transitions`, route `scheduled_transitions.settings`,
permission `administer scheduled transitions`). Everything is stored in the config object
`scheduled_transitions.settings`.

## Enabling an entity type / bundle (required)

Scheduled Transitions only appears on entities that are **both** moderated by a
content_moderation workflow **and** enabled here. Enabled bundles are stored under `bundles` as
a sequence of `{entity_type, bundle}` maps:

```yaml
bundles:
  - entity_type: node
    bundle: article
```

Read back the enabled set with the utility service (which intersects `bundles` with
moderated bundles): `\Drupal::service('scheduled_transitions.utility')->getBundles()`. The
result is cached (cache id `scheduled_transitions_enabled_bundles`); saving the settings form
clears it.

## Config keys (`scheduled_transitions.settings`)

| Key | Default | Meaning |
|---|---|---|
| `bundles` | `[]` | Enabled `{entity_type, bundle}` pairs. |
| `automation.cron_create_queue_items` | `true` | If true, cron fills the `scheduled_transition_job` queue with due transitions. |
| `message_transition_latest` | (template) | Revision-log message when transitioning the latest revision. |
| `message_transition_historical` | (template) | Revision-log message when transitioning a non-latest revision. |
| `message_transition_copy_latest_draft` | (template) | Message when a former unpublished revision is shifted back on top. |
| `message_override` | `false` | Whether editors may override the message templates on the add form. |
| `mirror_operations.view scheduled transition` | `update` | Entity operation whose access is reused for viewing transitions. |
| `mirror_operations.add scheduled transition` | `update` | Entity operation reused for adding transitions. |
| `mirror_operations.reschedule scheduled transitions` | `update` | Entity operation reused for rescheduling. |
| `retain_processed.enabled` | `false` | Keep transitions after processing (else delete them). |
| `retain_processed.duration` | `2419200` | Seconds to retain processed transitions (28 days). `-1` = forever. |
| `retain_processed.link_template` | `revision` | Link template used for a processed revision. |

Message templates support tokens like `[scheduled-transitions:from-state]`,
`[scheduled-transitions:to-state]`, `[scheduled-transitions:from-revision-id]`,
`[scheduled-transitions:latest-state]`, `[scheduled-transitions:latest-revision-id]`.

## Drush / config examples

```bash
drush config:get scheduled_transitions.settings
drush config:set scheduled_transitions.settings automation.cron_create_queue_items 0 -y
```
