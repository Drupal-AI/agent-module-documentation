<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Version changes on workflow transitions

## Install & enable

```bash
drush en entity_version_workflows -y
```

Depends on `entity_version` and core `content_moderation`. Prerequisites: the bundle must (a) use a
Content Moderation workflow, (b) have an `entity_version` field, and (c) have that field selected as
the **main version field** at `/admin/config/entity-version/settings`. Without the settings mapping,
`hook_entity_presave` finds no target field and does nothing.

## Configure per-transition rules

`hook_form_alter` (`entity_version_workflows_form_alter` → `_entity_version_workflows_alter_transition_forms`)
adds a **"Version control"** fieldset to each transition's add/edit form
(*Configuration → Workflow → Workflows → (workflow) → (transition)*). For each category — **Major**,
**Minor**, **Patch** — you choose one action:

| Value | Effect on save |
|---|---|
| `` (Nothing) | leave the number unchanged |
| `increase` | `+1` (`EntityVersionItem::increase`) |
| `decrease` | `-1`, floored at 0 (`EntityVersionItem::decrease`) |
| `reset` | set to 0 (`EntityVersionItem::reset`) |

Plus **"Check values changed"** — apply the rules only if the entity's field values changed during
the transition.

The entity builder `entity_version_workflows_form_transition_add_form_builder()` collects the
non-empty values and stores them as a **third-party setting** on the workflow config entity, keyed by
transition id: `$workflow->setThirdPartySetting('entity_version_workflows', $transitionId, $values)`
(or `unsetThirdPartySetting` when all are empty). Schema:
`workflows.workflow.*.third_party.entity_version_workflows` — a sequence keyed by transition id, each
a mapping of `major`/`minor`/`patch` (string action) + `check_values_changed` (boolean).

Config example (from the shipped example workflow):

```yaml
third_party_settings:
  entity_version_workflows:
    create_new_draft:
      patch: increase
      check_values_changed: true
    validate:
      minor: increase
      patch: reset
    publish:
      major: increase
      minor: reset
```

## Runtime — `EntityVersionWorkflowManager::updateEntityVersion()`

Called from `hook_entity_presave` (`entity_version_workflows_entity_presave`) after the bundle's
main version field is resolved from `entity_version_settings`. Steps:

1. **Skip** if `$entity->isNew()`.
2. **Skip** if `$entity->entity_version_no_update` is set truthy (per-save opt-out).
3. Get the workflow via `content_moderation.moderation_information::getWorkflowForEntity()`; **skip**
   if none.
4. Determine the transition: load the revision to compare — the **latest revision** by default, or
   the **loaded revision** when `$entity->entity_version_use_current_revision` is set — and read its
   `moderation_state` as the *from* state, the entity's `moderation_state` as the *to* state.
   `getTransitionFromStateToState($from, $to)` yields the transition (a caught
   `\InvalidArgumentException` → return, i.e. no matching transition → no change).
5. Read the transition's configured actions from the workflow third-party settings; **skip** if none.
6. If `check_values_changed` is set, call `isEntityChanged()` and **skip** if unchanged.
7. For each configured `category => action`, for each delta of the field, call
   `$entity->get($field_name)->get($delta)->$action($category)` (i.e. `increase` / `decrease` /
   `reset`).

Because the manager runs inside a normal moderated save, the version change only happens as part of a
moderation transition the acting user was **already authorised** to perform (Content Moderation gates
who can use which transition; the per-transition version rules are configured by workflow admins).

### `isEntityChanged()`

Uses `EntityChangesDetectionTrait::getFieldsToSkipFromTranslationChangesCheck()` to build a field
blacklist, dispatches **`CheckEntityChangedEvent`** so other modules can extend the blacklist, then
compares each remaining field of the entity against the latest revision with
`hasAffectingChanges(...)`; returns `TRUE` on the first difference.

Extend the blacklist:

```php
use Drupal\entity_version_workflows\Event\CheckEntityChangedEvent;

public static function getSubscribedEvents() {
  return [CheckEntityChangedEvent::EVENT => 'skipField'];
}

public function skipField(CheckEntityChangedEvent $event): void {
  $list = $event->getFieldBlacklist();
  $list[] = 'my_field';
  $event->setFieldBlacklist($list);
}
```

(The `CheckEntityChangedEvent::EVENT` constant string is
`entity_version_worfklows.check_entity_changed_event` — note the upstream typo "worfklows".)

## Revision revert keeps the version

`RouteSubscriber::alterRoutes()` replaces the `_form` of `node.revision_revert_confirm` with
`Drupal\entity_version_workflows\Form\NodeRevisionRevertForm`, whose `prepareRevertedRevision()`
sets `$revision->entity_version_no_update = TRUE`. So reverting a node revision restores the old
content **without** bumping the version.

## Notes

- The opt-out is by a dynamic entity property (`entity_version_no_update` /
  `entity_version_use_current_revision`), set before `save()` — not a permission or config.
- Only the bundle's configured **main** field is acted on; other version fields on the same entity
  are untouched.
