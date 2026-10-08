<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Tracer API: the tracer service, backends, decorated services

Tracer has **no configuration UI** (`configure: null`). It is a code-level instrumentation layer.

## The tracer service

Inject `tracer.tracer` (or the `Drupal\tracer\TracerInterface` type) and record spans:

```php
$span = $this->tracer->start('my_category', 'my_operation', ['id' => 42]);
$this->tracer->openSection($span);
// ... work ...
$this->tracer->closeSection($span);
$this->tracer->stop($span);
$events = $this->tracer->getEvents(); // array of recorded spans
```

`TracerInterface`:

| Method | Signature |
|---|---|
| `start` | `start(string $category, string $name, array $attributes = []): object` |
| `openSection` | `openSection(object $span): object` |
| `closeSection` | `closeSection(object $span): object` |
| `stop` | `stop(object $span): void` |
| `getEvents` | `getEvents(): array` |

## Activating a backend (settings.php)

`Drupal\tracer\TracerFactory::getTracer()` reads `Settings::get('tracer_plugin')`:

```php
// settings.php — activate a real tracer backend (a class implementing TracerInterface).
$settings['tracer_plugin'] = 'Drupal\\my_module\\MyTracer';
```

- If `tracer_plugin` is **unset** (the default), the factory returns `Drupal\tracer\NoopTracer`,
  whose methods do nothing and `getEvents()` returns `[]` — so tracing has zero overhead until you
  opt in. Webprofiler provides a ready-made backend.
- `\Drupal::service('tracer.tracer')` therefore resolves to `NoopTracer` on a stock site.

## Services Tracer decorates/replaces

From `tracer.services.yml` and `Drupal\tracer\TracerServiceProvider::alter()`:

- `event_dispatcher` is **decorated** by `Drupal\tracer\EventDispatcher\TraceableEventDispatcher`
  (so `\Drupal::service('event_dispatcher')` is that class when Tracer is enabled).
- HTTP kernel wrapped by `Drupal\tracer\StackMiddleware\TracesMiddleware`
  (tag `http_middleware`, priority 350) — opens a `root` span around each request.
- `Drupal\tracer\Http\HttpClientMiddleware` (tag `http_client_middleware`) traces Guzzle calls.
- `http_kernel.basic` controller resolver replaced by `Drupal\tracer\Controller\TraceableControllerResolver`.
- `Twig\Profiler\Profile` + `Drupal\tracer\Twig\Extension\TraceableProfilerExtension` (twig.extension, priority 100).

## Writing your own backend

Implement `Drupal\tracer\TracerInterface` in a class and point `tracer_plugin` at it. A minimal
working backend records spans and returns them from `getEvents()`:

```php
namespace Drupal\my_module;

use Drupal\tracer\TracerInterface;

class MyTracer implements TracerInterface {
  private array $events = [];
  public function start(string $category, string $name, array $attributes = []): object {
    $span = (object) ['category' => $category, 'name' => $name, 'attributes' => $attributes, 'start' => microtime(TRUE)];
    $this->events[] = $span;
    return $span;
  }
  public function openSection(object $span): object { return $span; }
  public function closeSection(object $span): object { return $span; }
  public function stop(object $span): void { $span->stop = microtime(TRUE); }
  public function getEvents(): array { return $this->events; }
}
```

The class must be autoloadable (ship it in a module) and referenced by its FQCN in
`$settings['tracer_plugin']`. `TracerFactory` instantiates it with `new $tracer_plugin()`
(no constructor args); on any exception it falls back to `NoopTracer`.
