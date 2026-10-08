# paragraphs_edit — setup, contextual links, routes, revisions

There is **no settings form and no configuration**. `data.json` `configure` is `null`.
Setup = enable the module and its deps:

```
drush en paragraphs_edit -y
```

Dependencies (info.yml): `drupal:contextual`, `paragraphs:paragraphs`. (Paragraphs itself
pulls in `entity_reference_revisions`.) `core_version_requirement: ^8 || ^9 || ^10 || ^11`.

## Contextual links on rendered paragraphs

`hook_ENTITY_TYPE_view_alter()` for `paragraph` (`paragraphs_edit_paragraph_view_alter()`)
attaches a `#contextual_links['paragraph']` group to every rendered paragraph, keyed by
route parameters `root_parent_type`, `root_parent`, `paragraph`. The **root parent** is
resolved by walking `getParentEntity()` up the chain until a non-paragraph host entity is
found (`paragraphs_edit.lineage.inspector::getRootParent()`). If the root parent implements
`EntityChangedInterface`, its changed time is added as contextual metadata (cache/lifetime).

Links are **suppressed** in two cases:
- the current route is `quickedit.field_form` (avoids QuickEdit JS conflicts);
- the current route is an admin route (`router.admin_context->isAdminRoute()`), e.g. a
  Paragraphs widget in "Edit mode: Preview".

`paragraphs_edit_preprocess_paragraph()` copies the contextual links from `title_suffix`
into `content` (weight `-100`) because paragraph templates don't print `title_suffix`.

The three links come from `paragraphs_edit.links.contextual.yml`, all `group: paragraph`:
**Edit paragraph**, **Clone paragraph**, **Delete paragraph**.

## Routes and forms (`paragraphs_edit.routing.yml`)

`hook_entity_type_build()` registers three paragraph entity form handlers:
`entity_edit` → `ParagraphEditForm`, `entity_clone` → `ParagraphCloneForm`,
`entity_delete` → `ParagraphDeleteForm`.

| Route | Path (under `/paragraphs_edit/{root_parent_type}/{root_parent}/paragraphs/{paragraph}/…`) | Form op | Access requirement |
|---|---|---|---|
| `paragraphs_edit.edit_form` | `/edit` | `paragraph.entity_edit` | `_entity_access: root_parent.update` |
| `paragraphs_edit.clone_form` | `/clone` | `paragraph.entity_clone` | `_entity_access: paragraph.update` |
| `paragraphs_edit.delete_form` | `/delete` | `paragraph.entity_delete` | `_entity_access: root_parent.update` |

All three set `options._admin_route: TRUE`, constrain `root_parent: \d+`, and type the
`root_parent` param as `entity:{root_parent_type}` and `paragraph` as `entity:paragraph`.
There is no reorder route — the module ships edit, clone, and delete only.

Behavior per form:
- **Edit** (`ParagraphEditForm` extends `ContentEntityForm`): renders the paragraph's own
  fields. Translation-aware `init()` — for a translatable paragraph it sets the form
  langcode to the current content language and, if that translation is missing, adds it
  (sourcing from the host's source language when available). Title = `Edit @lineage`.
- **Clone** (`ParagraphCloneForm`): duplicates the paragraph (`createDuplicate()`, resets
  `created`/owner/revision author), then a "Clone to" fieldset lets you pick destination
  **Type → Bundle → Parent (autocomplete) → Field**. Destinations are computed from all
  `entity_reference_revisions` fields whose target bundles accept this paragraph type
  (`getPotentialCloneDestinations()`). On save it appends the clone to the chosen field and
  saves that destination entity; validates `update` access on the destination entity and
  `edit` access on the destination field.
- **Delete** (`ParagraphDeleteForm` extends `ContentEntityDeleteForm`): confirm form;
  `submitForm()` removes the paragraph's field item from its parent field and re-saves the
  parent. Question/message use the lineage string.

## Revision handling

Saving is revision-aware via `paragraphs_edit.lineage.revisioner`
(`ParagraphLineageRevisioner`):
- `shouldCreateNewRevision($entity)` returns TRUE when the entity's bundle entity
  implements `RevisionableEntityBundleInterface` and is configured to create new revisions
  by default (e.g. a node type with "Create new revision" on).
- When true, `saveNewRevision()` saves the target and then walks up the parent chain,
  saving **each ancestor** as a new revision and updating each parent field item's
  `target_revision_id` so references stay consistent. When false, a plain `save()` is used.
- Edit uses the **root parent's** revision setting; delete/clone use the **parent /
  destination** entity's setting.
