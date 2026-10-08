<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure per-state access

## Where grants are stored

Config object **`workflow_access.role`** — a flat map keyed by **state id** (`sid`):

```yaml
# workflow_access.role
my_wf_draft:              # one key per non-creation state
  editor:                 # role id
    grant_view: true
    grant_update: true
    grant_delete: false
  anonymous:
    grant_view: false
    grant_update: false
    grant_delete: false
```

The creation state gets no access row. If a state has **no** grants configured yet, the module
defaults to allowing **view** for `anonymous` and `authenticated`.

## UI

- Per-workflow **Access** tab: `/admin/config/workflow/workflow/{workflow_type}/access`
  (route `entity.workflow_type.access_form`) — a table of states × roles with view/update/delete
  checkboxes. Requires `administer workflow`. Saving flags a node-access rebuild.
- Global settings: `/admin/config/workflow/workflow/access` (route `workflow.access.settings`) —
  sets `workflow_access_priority` (config `workflow_access.settings`), the node-grant priority
  used to win/lose against other node-access modules.

## Scriptable

```php
use Drupal\workflow_access\Entity\WorkflowAccessState;

$access = new WorkflowAccessState(['id' => 'my_wf_draft']);   // id = the state sid
$data = [
  'editor' => ['grant_view' => 1, 'grant_update' => 1, 'grant_delete' => 0],
];
$access->insertAccess($data);          // writes workflow_access.role[my_wf_draft]
\Drupal::service('node.grant_storage'); // (grants apply after a node_access rebuild)
node_access_needs_rebuild(TRUE);
```

Read it back:

```bash
drush cget workflow_access.role
drush cget workflow_access.settings workflow_access_priority
```

Or `(new WorkflowAccessState(['id' => 'my_wf_draft']))->readAccess()`.

## Limitations

- **Node only** — relies on the core node_access system; other entity types are unaffected.
- **One workflow per entity type** is supported for access purposes.
- Core "Edit any"/"Edit own"/"View published content" node permissions can override these grants;
  use the priority setting or tighten those permissions (see the Access tab help text).
