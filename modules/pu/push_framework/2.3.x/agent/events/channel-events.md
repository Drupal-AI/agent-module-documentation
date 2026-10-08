# Channel events — alter templates & rendered output

While a channel builds a notification, `ChannelBase::prepareContent()` dispatches four events so other
modules can rewrite the display mode, subject/body templates, or the rendered output before/after
rendering. Constants live in `Drupal\push_framework\ChannelEvents`; event classes are under
`Drupal\push_framework\Event\`. All extend `ChannelEventBase`, which exposes `getChannelPlugin()`,
`getUser()`, `getEntity()`, `getDisplayMode()` (the display mode and later fields are passed **by
reference**, so setters mutate the in-flight build).

| Event constant | Value | Class | Dispatched | You can change |
|---|---|---|---|---|
| `ChannelEvents::PREPARE_TEMPLATES` | `push_framework.channel.prepare_templates` | `ChannelPrepareTemplates` | once, before the per-language loop | display mode, subject, body, text format, isHtml |
| `ChannelEvents::PRE_BUILD` | `push_framework.channel.pre_build` | `ChannelPreBuild` | per language, before `viewBuilder->view()` | display mode (per language key) |
| `ChannelEvents::PRE_RENDER` | `push_framework.channel.pre_render` | `ChannelPreRender` | per language, after build, before render | the render `$elements` array |
| `ChannelEvents::POST_RENDER` | `push_framework.channel.post_render` | `ChannelPostRender` | per language, after `renderInIsolation()` | the rendered `$output` |

## `ChannelPrepareTemplates` — the rich one

Getters: `getSubject()`, `getBody()`, `getTextFormat()`, `isHtml()` (plus the base getters). Fluent
setters (each returns the event): `setDisplayMode()`, `setSubject()`, `setBody()`, `setTextFormat()`,
`setIsHtml()`. Because the underlying strings are held by reference, a subscriber here rewrites the
templates the rest of `prepareContent()` will use.

```php
use Drupal\Core\Entity\EntityInterface; // illustrative
use Drupal\push_framework\ChannelEvents;
use Drupal\push_framework\Event\ChannelPrepareTemplates;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MySubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return [ChannelEvents::PREPARE_TEMPLATES => 'onPrepare'];
  }

  public function onPrepare(ChannelPrepareTemplates $event): void {
    if ($event->getChannelPlugin()->getPluginId() === 'sms') {
      // Short, plain subject line for SMS.
      $event->setBody('[push-object:label]')->setIsHtml(FALSE)->setTextFormat('plain_text');
    }
  }
}
```

`ChannelPreRender` carries the render array (alter it to inject/strip elements); `ChannelPostRender`
carries the rendered markup string (alter it for last-mile transport tweaks). `ChannelPreBuild` lets
you swap the display mode for a specific language just before the view builder runs.
