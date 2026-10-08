# Internals (redirect flow, routes, services, block, theme)

## The redirect flow

1. **Negotiation plugin never decides.**
   `Plugin/LanguageNegotiation/LanguageNegotiationLanguageSelectionPage::getLangcode()` returns
   `FALSE` unconditionally. Its only job is to occupy a slot in the interface-language negotiation
   chain (id `language-selection-page`, weight `-4`, `config_route_name`
   `language_selection_page.negotiation_selection_page`).

2. **The subscriber redirects.**
   `EventSubscriber/LanguageSelectionPageSubscriber::redirectToLanguageSelectionPage()` is a
   `KernelEvents::RESPONSE` listener at priority **-50** (service
   `language_selection_page.language_selection_page_subscriber`). It:
   - runs **every** condition plugin (`$manager->getDefinitions()` → `createInstance(id, $config)` →
     `execute()` = `evaluate()`); if any returns `block()` (FALSE) it bails and does nothing;
   - otherwise calls `getLanguage()`, which walks the enabled interface-language negotiation methods
     *above* this one (skipping `LanguageNegotiationSelected`) and returns the first non-empty
     langcode, or the default language; only when that yields nothing (i.e. this method is reached as
     the fallback) does it build the redirect:
     `sprintf('%s?destination=%s', basePath . $config['path'], $currentPath->getPath($request))` and
     `$event->setResponse(new RedirectResponse($url))`.
   The `destination` here is the **current internal request path**, so the user is bounced to the
   splash page carrying where they were going.

3. **The splash page renders language links.**
   Dynamic route `language_selection_page` (path = config `path`) →
   `Controller/LanguageSelectionPageController::main()`:
   - `getDestination()` loops the condition plugins' `getDestination()` to resolve the target path
     (the `type` plugin reads it back from the request — see below);
   - if the destination is empty or equals the LSP path, it redirects to `<front>` (loop guard);
   - otherwise `getPageContent($destination)` lets each condition plugin `alterPageContent()` build
     the render array, then `getPageResponse()` lets each `alterPageResponse()` post-process it.
   `LanguageSelectionPageConditionLanguagePrefixes::alterPageContent()` produces the actual links:
   one `Url::fromUserInput($destination, ['language' => $language])` per native language, themed via
   `language_selection_page_content`.

## Routes

| Route name | Path | Handler | Access |
|---|---|---|---|
| `language_selection_page.negotiation_selection_page` | `/admin/config/regional/language/detection/language_selection_page` | `_form` `NegotiationLanguageSelectionPageForm` | `administer languages` |
| `language_selection_page.negotiation_language_selection_page_legacy_d7_redirect` | `/admin/config/regional/language/configure/selection_page` | `LegacyDrupal7Redirect::doRedirect` | `administer languages` |
| `language_selection_page` (dynamic) | config `path` (default `/language_selection_page`) | `LanguageSelectionPageController::main` | `access content` |

The dynamic route is emitted by `Routing/LanguageSelectionPageRouteController::routes()`, referenced
from `language_selection_page.routing.yml`'s `route_callbacks`. Because the path comes from config,
changing `path` requires a route rebuild (the `path` condition's `postConfigSave()` does this via
`router.builder`).

## Services

| Service id | Class | Notes |
|---|---|---|
| `plugin.manager.language_selection_page_condition` | `LanguageSelectionPageConditionManager` | Plugin manager for the condition plugin type; also an `ExecutableManagerInterface` (`execute()` = `evaluate()`). Sorts definitions by weight. See [../plugins/condition.md](../plugins/condition.md). |
| `language_selection_page.language_selection_page_subscriber` | `LanguageSelectionPageSubscriber` | The response listener described above. |
| `language_selection_page_controller` | `LanguageSelectionPageController` | Page/block content builder; injected into the block. |

`LanguageSelectionPageController` methods you may call from code:
`getDestination($destination = NULL)`, `getPageContent($destination = '<front>')`,
`getPageResponse(array $response)`, `main()`.

## The `type` condition owns the destination

`Plugin/LanguageSelectionPageCondition/LanguageSelectionPageConditionType::getDestination()` is what
turns the request back into a destination string:

```php
if ($config->get('type') !== 'block') {
  if (!empty($request->getQueryString())) {
    list(, $destination) = explode('=', $request->getQueryString(), 2);
    $destination = urldecode($destination);
  }
}
else {
  $destination = $request->getPathInfo();
}
```

So in page modes the destination is read from the request's `?destination=` value; in block mode it
is the current path. The value then flows only into `Url::fromUserInput()` (used to build the
per-language links) and into the auto-escaped Twig variable `{{ destination }}`. `Url::fromUserInput()`
rejects external/scheme inputs (the caller catches `\InvalidArgumentException` and falls back to
`<front>`) and strips any host from protocol-relative input, so the links stay on-site.

## Block

`Plugin/Block/LanguageSelectionPageBlock` (id `language-selection-page`). `build()` renders content
only when `type === 'block'` (delegating to `LanguageSelectionPageController::getDestination()` /
`getPageContent()`). `blockAccess()` evaluates only the condition plugins whose definition has
`runInBlock=TRUE` and forbids the block if any blocks.

## Theme

`hook_theme` registers `language_selection_page_content` (template
`templates/language-selection-page-content.html.twig`) with variables `destination`,
`configure_url` (defaults to `Url::fromRoute('language.negotiation')`) and `language_links`. Override
the template in your theme to control the splash-page markup (the default is intentionally bare and
tells the user it should be themed).

## Hooks implemented

`hook_theme`, `hook_help` (`help.page.language_selection_page`), `hook_requirements` (warns about
languages without a URL prefix), `hook_uninstall` (clears the `language-selection-page` method from
each language type's negotiation config).
