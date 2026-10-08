<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How Sub-pathauto processes paths

## The service

```yaml
# subpathauto.services.yml
path_processor_subpathauto:
  class: Drupal\subpathauto\PathProcessor
  arguments: ['@path_alias.path_processor', '@language_manager', '@config.factory', '@module_handler']
  tags:
    - { name: path_processor_inbound, priority: 50 }
    - { name: path_processor_outbound, priority: 50 }
```

It **wraps** core's `path_alias.path_processor` rather than replacing it.
`Drupal\subpathauto\SubpathautoServiceProvider::alter()` strips both tags when the kernel is
an `UpdateKernel`, so `update.php` can generate URLs before the `path_alias` entity schema
exists.

## Inbound (`processInbound`)

1. Bail out if the incoming `$path` has already been altered by another processor, or if we
   are inside our own `isValidPath()` recursion (`$this->recursiveCall`).
2. Run the whole request path through `checkRedirectedPath()` first (see below).
3. Loop, up to `depth` times: pop the last segment onto `$subpath`, ask
   `path_alias.path_processor->processInbound()` about the shortened parent path.
   - If the parent did not change, try `checkRedirectedPath()` on it and re-process.
   - On a hit, rebuild `<internal parent>/<popped segments reversed>`.
4. Validate the rebuilt path with `path.validator`
   (`getUrlIfValidWithoutAccessCheck()`, no access check) while `recursiveCall` is TRUE.
5. Return the processed rebuilt path if valid, otherwise the original path untouched.

So `/about-us/edit` with `/node/1 => /about-us` yields `/node/1/edit`, and a nonsense
`/about-us/not-a-route` is left alone for other processors / a 404.

## Outbound (`processOutbound`)

The mirror image, without validation: pop segments, call
`path_alias.path_processor->processOutbound()` on the parent, and on the first change return
`<alias>/<popped segments reversed>`. This is what makes `Url::fromRoute()` emit
`/about-us/edit`.

## Language prefixes

`getPath()` reads `language.negotiation` → `url.prefixes` and, when the source is
`LanguageNegotiationUrl::CONFIG_PATH_PREFIX`, strips the current URL language's prefix from
`$request->getPathInfo()` before comparing it to `$path`. The path is also `urldecode()`d and
right-trimmed of `/`.

## Redirect integration

`checkRedirectedPath()` is a no-op unless **both** `redirect` is installed and
`subpathauto.settings:redirect_support` is TRUE (evaluated once per processor instance).
When active it calls `redirect.repository->findBySourcePath()`; if a redirect exists and its
target is internal and routed, the internal path (`$url->getInternalPath()`) is used for
alias lookup. External or unrouted targets are ignored.

## Testing it live

```php
use Symfony\Component\HttpFoundation\Request;
$request = Request::create('/about-us/edit');
print \Drupal::service('path_processor_manager')->processInbound('/about-us/edit', $request);
// -> /node/1/edit   (when depth is set and /node/1 is aliased to /about-us)
```

If that returns the input unchanged, check `subpathauto.settings:depth` actually exists —
a NULL `depth` silently disables the loop.

## Extending

`PathProcessor::setPathValidator()` exists purely to break a circular service dependency
(the validator is otherwise lazily fetched from `\Drupal::service('path.validator')`); it is
the only public seam. There is no plugin type, hook or event. To change behaviour, decorate
or replace the `path_processor_subpathauto` service.
