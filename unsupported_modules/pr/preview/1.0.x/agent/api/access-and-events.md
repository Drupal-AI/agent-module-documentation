<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Access model, param converter & events

## Route & services

- Route `preview.entity_preview` → `/preview/{entity_preview}/{view_mode_id}`,
  `_controller: PreviewController::view`, requirement `_entity_preview_access: '{preview}'`.
- Services (`preview.services.yml`):
  - `access_check.entity.preview` (`EntityPreviewAccessCheck`) — tagged `access_check`,
    `applies_to: _entity_preview_access`.
  - `entity_preview` (`PreviewConverter`) — tagged `paramconverter`, injects `tempstore.private`.
  - `Drupal\preview\Hook\PreviewHooks` — autowired hook implementations.

## Param converter (`PreviewConverter`)

`convert()` reads the **private** tempstore collection `entity_preview` (`PrivateTempStoreFactory`)
by the URL value (the entity UUID) and returns the staged **unsaved** entity from the stored
`$form_state->getFormObject()->getEntity()`. Because the tempstore is private, it is scoped to the
**current user** — a UUID from another user's session resolves to nothing.

## Access check (`EntityPreviewAccessCheck::access`)

```php
if ($entity_preview->isNew()) {
  return $accessControlHandler->createAccess($bundle, $account, [], TRUE);   // new entity
}
return $entity_preview->access('update', $account, TRUE);                    // existing entity
```

So viewing a preview requires the viewer's **create** access (new) or **update** access (existing) on
that entity/bundle. This is also re-checked in `PreviewHooks::formAlter` before the Preview button is
added.

### Security reasoning (why there is no security.md)

- The previewed entity comes only from the **per-user private tempstore**, so a low-privilege user
  cannot load an arbitrary or another user's unsaved/draft entity.
- Rendering requires `update`/`create` access to the entity — i.e. the user can already edit/create
  it — matching core node preview's model. Showing an editable entity to its editor crosses no trust
  boundary, even if the entity is unpublished.
- `view_mode_id` from the URL only selects a display of an entity the user is already authorized for.

## Controller (`PreviewController`)

Extends core `EntityViewController`. `view()` sets `$entity->preview_view_mode`, renders via the
parent, and **unsets `#cache`** so previews are never cached. `title()` returns the entity label in
the current translation.

## View-mode switch form (`PreviewForm`)

Rendered into `page_top` on the preview route. Lets the editor pick another view mode (redirects to
the same route with the new `view_mode_id`) and builds the "Back to content editing" link.

## Events

- `PreviewEvents::PREVIEW_BACK_LINK` = `'preview.back_link'`.
- Event object `Drupal\preview\Event\PreviewBackLink` — carries the previewed `EntityInterface`
  (`getEntity()`) and a nullable `Url` (`getBackLink()` / `setBackLink()`). Subscribe to override
  where the "Back to content editing" link points:

```php
public static function getSubscribedEvents(): array {
  return [PreviewEvents::PREVIEW_BACK_LINK => 'onBackLink'];
}
public function onBackLink(PreviewBackLink $event): void {
  $event->setBackLink(Url::fromRoute('my_module.custom_edit', [...]));
}
```
