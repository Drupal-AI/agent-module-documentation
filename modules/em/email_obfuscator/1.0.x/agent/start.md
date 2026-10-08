<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Email Obfuscator (email_obfuscator) — agent index

A response-body filter that obfuscates email addresses in rendered front-end HTML so simple
harvesting bots cannot read them. Package `Custom`. Core `^10 || ^11`. License GPL-2.0-or-later.
Version-dir 1.0.x (installed 1.0.1). **No dependencies, no config entities, no permissions, no
routes, no settings form.**

- **How it hooks in (event subscriber + service) and the exact obfuscation mechanism** →
  [architecture/response-filter.md](architecture/response-filter.md)
- **Install/enable and the two optional `settings.php` keys (`ignored_routes`, `use_datanosnippet`)** →
  [config/settings.md](config/settings.md)

## What it actually is

- One event subscriber: `EmailObfuscatorResponseFilter` (service `email_obfuscator.response_filter`),
  in `src/EventSubscriber/EmailObfuscatorResponseFilter.php`, subscribing to
  `KernelEvents::RESPONSE` (`onKernelResponse()`). It is `final`, constructor-injected with
  `email_obfuscator.service`, `@router.admin_context` and `@logger.channel.email_obfuscator`.
- One plain service: `EmailObfuscatorService` (service `email_obfuscator.service`), in
  `src/EmailObfuscatorService.php`, with the public entry point `obfuscateEmails(string $content,
  bool $useDataNoSnippet = TRUE)`.
- One exception class: `EmailObfuscatorException` (extends `\Exception`), in
  `src/EmailObfuscatorException.php`.
- Config lives in `settings.php` under `$settings['email_obfuscator']` — read at runtime via
  `\Drupal\Core\Site\Settings::get()`. There is **no config object, no config/schema, no
  config/install** in the module.

## Skip rules (from `onKernelResponse()`)

Obfuscation is skipped when: there is no `_route_object`/`_route`/content; the route is an admin
route (`AdminContext::isAdminRoute()`); the route is in `Settings::get('email_obfuscator')['ignored_routes']`;
or the request is an Ajax request whose `form_id` starts with `webform`. Otherwise the whole
response body is passed through `obfuscateEmails()` and set back on the response.

## Not present

No `.module`/`.install`, no `*.routing.yml`/`*.permissions.yml`/`*.links.*.yml` at project level,
no plugins, no Drush, no field type/formatter/widget, no external libraries. The `tests/modules/`
tree ships only a functional-test fixture (`email_obfuscator_test_controller`), not a real submodule.
