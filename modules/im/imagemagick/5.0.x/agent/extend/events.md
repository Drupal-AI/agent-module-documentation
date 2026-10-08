# Customize the command line via events

The toolkit dispatches `Drupal\imagemagick\Event\ImagemagickExecutionEvent` at key points so
you can inspect/modify the arguments before the binary runs. This replaces the old
`hook_imagemagick_arguments_alter()`.

## Event constants (subscribe to these)
| Constant | When |
|---|---|
| `ImagemagickExecutionEvent::PRE_CONVERT_EXECUTE` | Before a `convert` (image derivative) runs. |
| `ImagemagickExecutionEvent::PRE_IDENTIFY_EXECUTE` | Before an `identify` (metadata read) runs. |
| `ImagemagickExecutionEvent::ENSURE_SOURCE_LOCAL_PATH` | Ensure the source is on a local path (for remote/stream wrappers). |
| `ImagemagickExecutionEvent::POST_SAVE` | After the derivative is saved. |

## Subscriber skeleton
```php
use Drupal\imagemagick\Event\ImagemagickExecutionEvent;
use Drupal\imagemagick\ArgumentMode;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MySharpen implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [ImagemagickExecutionEvent::PRE_CONVERT_EXECUTE => 'onConvert'];
  }
  public function onConvert(ImagemagickExecutionEvent $event): void {
    $args = $event->getExecArguments();          // ImagemagickExecArguments
    $args->add(['-sharpen', '0x0.5'], ArgumentMode::PostSource);
  }
}
```
Register it as a normal `event_subscriber`-tagged service. The module's own
`ImagemagickEventSubscriber` uses these same hooks to set defaults (colorspace, density,
coalesce, source frames, local-path handling) — read it as the reference implementation.
See [../api/services.md](../api/services.md) for the `ImagemagickExecArguments` API.
