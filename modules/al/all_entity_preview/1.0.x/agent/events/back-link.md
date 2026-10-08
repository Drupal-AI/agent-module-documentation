# Event: preview.back_link (override the "Back to editing" link)

The only event the module dispatches. It lets another module change where the "Back to editing"
link on the preview page points.

- **Event name:** `PreviewEvents::PREVIEW_BACK_LINK` = `'preview.back_link'`
  (`Drupal\preview\Event\PreviewEvents`).
- **Event object:** `Drupal\preview\Event\PreviewBackLink`.
- **Dispatched from:** `PreviewForm::buildForm()` (`preview_form_select`), rendered by
  `hook_page_top` on the `preview.entity_preview` route.

## Default back link

Before dispatching, `PreviewForm` computes a default `Url`:

- new entity: the `<entity_type_id>.add` route (with the bundle key), if such a route exists;
- existing entity: the entity's `edit-form` link template, if it has one;
- otherwise `NULL` (no link is shown).

The event is dispatched with the previewed entity and this default. After dispatch, the form uses
`$event->getBackLink()` — so a subscriber can supply a link where there was none, or replace the
default. The link is only rendered if non-NULL.

## Event API

| Member | Signature | Notes |
| --- | --- | --- |
| `getEntity()` | `: EntityInterface` | The entity being previewed (unsaved). |
| `getBackLink()` | `: \Drupal\Core\Url|null` | Current back link (default before subscribers run). |
| `setBackLink(Url $backLink)` | `: void` | Replace the back link. |

## Example subscriber

```php
use Drupal\preview\Event\PreviewBackLink;
use Drupal\preview\Event\PreviewEvents;
use Drupal\Core\Url;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyBackLinkSubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return [PreviewEvents::PREVIEW_BACK_LINK => 'onBackLink'];
  }

  public function onBackLink(PreviewBackLink $event): void {
    if ($event->getEntity()->getEntityTypeId() === 'my_entity') {
      $event->setBackLink(Url::fromRoute('my_module.custom_edit'));
    }
  }

}
```
