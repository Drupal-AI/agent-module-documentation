<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `FastErrorPage` plugin type

One plugin per HTTP status code the module should handle. Ships handlers for **404** and **403**;
add your own for 410, 500, etc.

| Piece | Value |
|-------|-------|
| Attribute | `Drupal\fast_error_pages\Plugin\FastErrorPage` — single arg `id` (the status code) |
| Base class | `Drupal\fast_error_pages\Plugin\FastError\FastErrorPagePluginBase` |
| Interface | `Drupal\fast_error_pages\Plugin\FastError\FastErrorPagePluginInterface` |
| Manager service | `fast_error_pages.error_page_manager` (`FastErrorPageManager extends DefaultPluginManager`) |
| Discovery dir | `<module>/src/FastErrorPage/`, namespace `Drupal\<module>\FastErrorPage` |
| Plugin id | the **status-code integer** — the manager is queried with `hasDefinition($status_code)` / `createInstance($status_code)` |

The base class injects `config.factory` and implements
`applies(Request $request): bool` as `$this->getUrl() === $request->getUri()` — the store subscriber
uses it to recognise when the current loopback request is rendering this error page. You only need
to implement `getUrl()`.

## Contract

```php
public function getUrl(): ?string;   // absolute URL of the page to serve, or NULL to skip
public function applies(Request $request): bool;  // provided by base; override only if URL matching differs
```

## Built-in 404 handler (verbatim shape)

```php
namespace Drupal\fast_error_pages\FastErrorPage;

use Drupal\Core\Url;
use Drupal\fast_error_pages\Plugin\FastErrorPage;
use Drupal\fast_error_pages\Plugin\FastError\FastErrorPagePluginBase;

#[FastErrorPage(404)]
class FastErrorPage404 extends FastErrorPagePluginBase {
  public function getUrl(): ?string {
    $page_404 = $this->configFactory->get('system.site')->get('page')['404'] ?? '';
    return empty($page_404) ? NULL : Url::fromUserInput($page_404)->setAbsolute()->toString();
  }
}
```

## Adding a status code (e.g. 500)

Create `mymodule/src/FastErrorPage/FastErrorPage500.php`:

```php
namespace Drupal\mymodule\FastErrorPage;

use Drupal\Core\Url;
use Drupal\fast_error_pages\Plugin\FastErrorPage;
use Drupal\fast_error_pages\Plugin\FastError\FastErrorPagePluginBase;

#[FastErrorPage(500)]
class FastErrorPage500 extends FastErrorPagePluginBase {
  public function getUrl(): ?string {
    // No core config for 500 — point at your own themed page.
    return Url::fromUserInput('/error/500')->setAbsolute()->toString();
  }
}
```

Notes:
- `getUrl()` must return an **absolute, internal** URL (`Url::fromUserInput()` requires a leading
  `/`, `#`, or `?`; `setAbsolute()` makes it fully-qualified). Returning `NULL` disables handling
  for that code.
- The exception subscriber only maps `getStatusCode()` for `HttpExceptionInterface` html responses;
  anything else is treated as 500, so a 500 plugin is what catches unhandled exceptions.
- The target path should render as a cacheable page (so its tags/contexts can be captured) and be
  viewable anonymously.
