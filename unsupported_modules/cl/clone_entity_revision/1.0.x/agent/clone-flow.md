<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Clone flow — route, controller override, and duplication

## How the Clone link appears

`RouteSubscriber::alterRoutes()` (`src/Routing/RouteSubscriber.php`) rewrites the core route
`entity.node.version_history` so its `_controller` points at
`\Drupal\clone_entity_revision\Controller\NodeController::revisionOverview`.

`NodeController` extends core's `\Drupal\node\Controller\NodeController`. `revisionOverview()`
calls `parent::revisionOverview($node)` to get the normal revisions table, then walks each row's
operation `#links` and adds a `clone` link **only if**:

- `$this->currentUser()->hasPermission('clone_entity_revision.clone')`, and
- the revision `hasTranslation($langcode)` and `isRevisionTranslationAffected()` for the active
  node's language.

The link targets route `clone_entity_revision.revision_clone_confirm` with `node` = node id and
`node_revision` = the revision's vid.

## The clone route

```
clone_entity_revision.revision_clone_confirm:
  path: '/node/{node}/revisions/{node_revision}/clone'
  defaults:
    _form: '\Drupal\clone_entity_revision\Form\NodeRevisionCloneForm'
  requirements:
    _permission: 'clone_entity_revision.clone'
    node: \d+
  options:
    _node_operation_route: TRUE
    parameters:
      node: { type: entity:node }
      node_revision: { type: entity_revision:node }
```

Access requirement is the permission `clone_entity_revision.clone`. The `{node}` param loads a
node (`entity:node`) and `{node_revision}` loads a node revision (`entity_revision:node`) resolved
by its vid; the confirm form uses the resolved `{node_revision}` for the clone.

## The confirm form (`NodeRevisionCloneForm`)

Extends `ConfirmFormBase`. `buildForm(..., ?NodeInterface $node_revision = NULL)` stores the
revision in `$this->revision`; the question/cancel/confirm text come from the standard confirm-form
methods. Submitting (POST, CSRF-protected by Form API) runs `submitForm()`:

1. `$duplicate = $this->handleCloneParagraph($this->revision);`
2. Shows a message linking to `entity.node.edit_form` of the new node.
3. Redirects to `entity.node.version_history` of the source.

### `handleCloneParagraph(ContentEntityInterface $entity)`

Recursive deep-clone (name is historical — it handles the whole entity, not only paragraphs):

1. `$duplicate = $entity->createDuplicate();` — copies **all** field values, including `uid`
   (author) and `status`; unsets ids so save creates a new entity.
2. Iterate `getFieldDefinitions()`; skip empty fields.
3. If field is `entity_reference_revisions` targeting `paragraph` **and** `paragraphs` is enabled:
   recursively clone each referenced paragraph and rebuild the field with new
   `target_id`/`target_revision_id`.
4. If field type is `file` or `image` **and** `file` is enabled: for each referenced `File`,
   byte-copy the file on disk with `FileSystem::copy($uri, $uri, FileExists::Rename)`, create and
   save a new `File` entity, and rebuild the item preserving `alt`/`title`/`width`/`height`/
   `description`/`display`.
5. Reset `created` and `changed` to `time->getRequestTime()` (if those fields exist).
6. `$duplicate->save()` and return it.

Not handled specially: any other reference type (plain `entity_reference`, media, layout builder
sections, etc.) is left as `createDuplicate()` produced it — i.e. the new node references the
**same** target entities as the source revision. Moderation state is not touched.
