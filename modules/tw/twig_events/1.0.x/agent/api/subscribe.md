<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Subscribing to the template-render event

`twig_events` fires exactly one event, dispatched from the wrapper theme engine after core renders each
template:

```php
// theme_engine/twig_events_engine.engine
$output = twig_render_template($template_file, $variables);
$event  = \Drupal::service('event_dispatcher')
  ->dispatch(new TwigRenderTemplateEvent($template_file, $variables, $output));
return $event->getOutput();
```

Because dispatch passes only an object (no string event name), you subscribe to the **class name**.

## Event class
`Drupal\twig_events\Event\TwigRenderTemplateEvent`

| Accessor | Type | Meaning |
| --- | --- | --- |
| `getTemplateFile()` / `setTemplateFile($f)` | string | Absolute path of the compiled/loaded template file being rendered. |
| `getVariables()` / `setVariables(array $v)` | array | The keyed variables passed into the template. |
| `getOutput()` / `setOutput($o)` | string / MarkupInterface | The rendered markup. **The engine returns whatever this is after dispatch** — mutate it to rewrite output. |

## Event subscriber

`my_module.services.yml`:

```yaml
services:
  my_module.twig_render_subscriber:
    class: Drupal\my_module\EventSubscriber\TwigRenderSubscriber
    tags:
      - { name: event_subscriber }
```

`src/EventSubscriber/TwigRenderSubscriber.php`:

```php
namespace Drupal\my_module\EventSubscriber;

use Drupal\twig_events\Event\TwigRenderTemplateEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class TwigRenderSubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    // Key on the event CLASS NAME — the engine dispatches the object directly.
    return [TwigRenderTemplateEvent::class => 'onRender'];
  }

  public function onRender(TwigRenderTemplateEvent $event): void {
    $template = $event->getTemplateFile();

    // Observe: e.g. record which template rendered, or time it.
    // \Drupal::logger('my_module')->debug('Rendered @t', ['@t' => $template]);

    // Rewrite (optional): wrap output in a debug comment.
    // Only do this when the output is safe/trusted markup — you own what you emit.
    $output = $event->getOutput();
    $event->setOutput("<!-- template: $template -->\n" . $output);
  }

}
```

## Notes for agents
- **Fires per template, not per page.** A normal page renders hundreds of templates; keep `onRender`
  cheap. This is aimed at development-time profiling/debugging.
- **No priority ordering is defined by the module** — if multiple subscribers rewrite `output`, order
  follows normal Symfony subscriber priority; set a priority in `getSubscribedEvents()` if it matters,
  e.g. `[TwigRenderTemplateEvent::class => ['onRender', -100]]`.
- **Enabling the module is enough** to activate the engine swap — `hook_system_info_alter()` redirects
  every `twig`-engine theme to `twig_events_engine`. There is nothing to configure.
- If the event fires but your subscriber never runs, confirm the active theme's engine is `twig` (custom
  theme engines are left untouched) and rebuild caches after enabling.
