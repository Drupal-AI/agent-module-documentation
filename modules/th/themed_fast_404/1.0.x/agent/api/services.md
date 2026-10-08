<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services and extension points

## `themed_fast_404.manager` — `ThemedFast404Manager`

`lazy: true`, injects `file.repository`, `config.factory`, `language_manager`. Interface
`ThemedFast404ManagerInterface` with two constants:

```php
const DRUPAL_404_ROUTE_NAME    = 'themed_fast_404.page_not_found';
const PAGE_NOT_FOUND_FILE_PATH = 'public://';
```

| Method | Returns | Behaviour |
|---|---|---|
| `buildStatic404()` | void | For each enabled language: build the URL, `@file_get_contents()` it, write `public://page-not-found-{lang}.html` with `FileExists::Replace` |
| `getStatic404url()` | `string\|false` | URL of the current language's static file, or FALSE when the file does not exist |
| `get404Url(LanguageInterface $language)` | `string` | The URL that will be scraped for that language |

```php
$manager = \Drupal::service('themed_fast_404.manager');
$manager->buildStatic404();                       // regenerate all languages
$url = $manager->getStatic404url();               // false until cron has run
$src = $manager->get404Url(\Drupal::languageManager()->getCurrentLanguage());
```

`get404Url()` logic, in order:

1. Start from `Url::fromRoute('themed_fast_404.page_not_found')`.
2. If `use_system_404` is on **and** `system.site:page.404` is non-empty, use
   `Url::fromUserInput($system_404_url)` instead.
3. Apply the language option.
4. If `base_url` is set, return `$base_url . $url->toString()`; otherwise
   `$url->setAbsolute()->toString()`.

Because step 4 falls back to an absolute URL derived from the current request, a cron run without
a usable host (drush without `--uri`, some hosting cron wrappers) produces a wrong URL — that is
exactly what `base_url` exists to fix.

## `themed_fast_404.config_overrider` — `ConfigOverrider`

Tagged `config.factory.override`; injects `file_system`, `file_url_generator`, and the manager.
`loadOverrides()` short-circuits unless `system.performance` is among the requested names, then
returns the three keys documented in
[../configure/setup.md](../configure/setup.md).

`getCacheSuffix()` returns the constant string `'ConfigOverrider'` and `getCacheableMetadata()`
returns empty metadata — i.e. the override is **not** varied by language in the cache key even
though `getStatic404url()` picks a file by current language. On a multilingual site with config
caching this can serve one language's 404 HTML to another; if that matters, decorate the service
and add a `languages:language_interface` cache context.

## Regenerating from your own code

```php
// After a deploy that changes the theme:
\Drupal::service('themed_fast_404.manager')->buildStatic404();

// After changing the body text programmatically:
\Drupal::configFactory()->getEditable('themed_fast_404.settings')
  ->set('404_body', '<h1>Gone</h1>')
  ->save();
\Drupal::service('themed_fast_404.manager')->buildStatic404();
```

Hook it into your deployment step rather than waiting for cron, and check the file is non-empty
afterwards — `buildStatic404()` silences fetch errors.

## Customising the 404 markup

The page cron scrapes is a normal Drupal route, so all the usual tools apply:

- `hook_preprocess_page()` / a `page--page-not-found.html.twig` template suggestion (the route is
  `themed_fast_404.page_not_found`, path `/page-not-found`).
- Block layout: blocks placed on that path appear in the static file.
- Or switch `use_system_404` on and let core's `system.site:page.404` target (a node, a view, a
  custom route) be the source instead.

Whatever renders there is captured **once**, so avoid per-user or per-request content — the same
bytes are served to everyone, including anonymous visitors.
