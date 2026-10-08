# Events (`Drupal\entity_print\Event\PrintEvents`)

Subscribe (tag `event_subscriber`) to customize output. Constants:

| Constant | Event name | Event object | Use for |
|---|---|---|---|
| `PrintEvents::CONFIGURATION_ALTER` | `entity_print.print_engine.configuration_alter` | `GenericEvent` | change engine config (DPI, paper, HTTP auth) just before the plugin is instantiated |
| `PrintEvents::CSS_ALTER` | `entity_print.print.css_alter` | `PrintCssAlterEvent` | add CSS libraries to the print build |
| `PrintEvents::POST_RENDER` | `entity_print.print.html_alter` | `PrintHtmlAlterEvent` | manipulate the final HTML string (last resort — prefer templates) |
| `PrintEvents::FILENAME_ALTER` | `entity_print.print.filename_alter` | `FilenameAlterEvent` | set the download filename (array of parts, imploded) |
| `PrintEvents::PRE_SEND` | `entity_print.print_engine.pre_send` | `PreSendPrintEvent` | act right before the document is streamed |

```php
public static function getSubscribedEvents() {
  return [PrintEvents::CSS_ALTER => 'onCss'];
}

public function onCss(PrintCssAlterEvent $event) {
  $build = $event->getBuild();
  $build['#attached']['library'][] = 'mymodule/print';
}
```

Recommended: manage print CSS from your **theme** (a `entity_print` library), not the CSS event,
so styling lives with your theme. See [../theming/templates.md](../theming/templates.md).
