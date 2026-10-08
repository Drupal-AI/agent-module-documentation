<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The toggle route & controller

## Route
`layout_paragraphs_toggle_publish.routing.yml`:

```yaml
layout_paragraphs_toggle_publish.toggle_publish_item:
  path: '/layout-paragraphs-toggle-publish/{layout_paragraphs_layout}/toggle-publish/{component_uuid}'
  defaults:
    _title: 'Toggle Publish'
    _controller: '\Drupal\layout_paragraphs_toggle_publish\Controller\TogglePublish::toggle'
    operation: 'update'
  options:
    parameters:
      layout_paragraphs_layout:
        layout_paragraphs_layout_tempstore: TRUE
  requirements:
    _layout_paragraphs_builder_access: 'TRUE'
```

- `{layout_paragraphs_layout}` is upcast by the `layout_paragraphs_layout_tempstore` param converter,
  i.e. the `LayoutParagraphsLayout` object is pulled from the **current user's tempstore** (the same
  builder session), not from a stored config/content entity by id.
- `{component_uuid}` is the target paragraph component's UUID within that layout.
- `operation: 'update'` is a route default that is passed by name into the access checker.
- It is invoked through a `use-ajax` **GET** link.

## Access checker
`_layout_paragraphs_builder_access` resolves to `Drupal\layout_paragraphs\Access\LayoutParagraphsBuilderAccess::access()`
(registered in `layout_paragraphs.services.yml`). For this route it receives `$operation = 'update'` and
`$component_uuid`, and ANDs together three access results:

1. `edit` access on the layout's paragraphs reference field.
2. `update` (or `create`, if the host is new) access on the **host entity**.
3. `update` access on the **specific paragraph** loaded by `$component_uuid` from the layout.

All three must pass. Because the paragraph is fetched from the tempstore-loaded layout and its own
`update` access is checked, a user cannot toggle a paragraph they may not edit, and there is no
request-supplied entity id loaded without an access check (no IDOR).

## Controller — `TogglePublish::toggle()`
`src/Controller/TogglePublish.php`. Depends only on `layout_paragraphs.tempstore_repository`
(injected via `create()`); uses `LayoutParagraphsLayoutRefreshTrait` and `AjaxHelperTrait`.

Flow:
1. `setLayoutParagraphsLayout($layout)`; `getComponentByUuid($component_uuid)`; `$component->getEntity()`.
2. `$paragraph->isPublished() ? setUnpublished() : setPublished()`.
3. `$paragraph->setNewRevision(TRUE); $paragraph->save();` — **persists to storage immediately** and
   creates a revision on every flip (does not defer to a host-entity save).
4. `$this->layoutParagraphsLayout->setComponent($paragraph)` then `tempstore->set(...)` — keeps the
   builder session in sync.
5. If AJAX (always, in practice) returns an `AjaxResponse` with:
   - `ReplaceCommand` on `[data-uuid="…"] .lpb-controls-publish-toggle` with a freshly rendered link,
   - `InvokeCommand` `toggleClass` `['paragraph--unpublished']` on `[data-uuid="…"]`,
   - `LayoutParagraphsEventCommand($layout, $paragraph->uuid(), 'component:update')` so LP updates its state.
   (For a non-AJAX request the method returns nothing — the route is only ever reached via the AJAX link.)

## Static builder — `TogglePublish::getPublishStatusLink(string $layout_id, Paragraph $entity)`
Called both from the module's preprocess hook (initial render) and from `toggle()` (AJAX replacement).
Builds a `Link` to the route above with text `Publish`/`Unpublish` depending on `$entity->isPublished()`,
then merges attributes:
- classes `is-published` | `not-published`, `lpb-controls-publish-toggle`, `use-ajax`;
- `#attached` library `layout_paragraphs_toggle_publish/toggle_form`;
- `#access` = `\Drupal::currentUser()->hasPermission('view unpublished paragraphs')` — this only controls
  whether the **link is rendered**, not route access; the real boundary is the access checker above;
- `#weight` 55 (position within the controls).
