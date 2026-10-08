<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How access is enforced

Once a role lacks `access language <langcode>`, the module blocks and hides that language
through several hooks and services. All logic keys off
`currentUser->hasPermission('access language ' . $langcode)`.

## Hard block — 403 on the current language

`LanguageAccessSubscriber` (service `language_access_event_subscriber`, listens on
`KernelEvents::REQUEST`) throws `AccessDeniedHttpException` (HTTP 403) when the current
user lacks the permission for the **current request's** language. It is skipped when:

- running under CLI (`PHP_SAPI === 'cli'`) — so Drush/cron are unaffected;
- it is not the main request (sub-requests pass);
- the route sets `_disable_route_normalizer`;
- the request URL contains `/user/`, the public files base path
  (`PublicStream::basePath()`), or `/s3/` — login and file downloads always work.

## Soft hiding (module file hooks)

- `hook_language_switch_links_alter()` — removes inaccessible languages from the language
  switcher block.
- `hook_page_attachments_alter()` — strips `rel="alternate"` `hreflang` `<link>` tags for
  languages the current user cannot access.
- `hook_simple_sitemap_links_alter()` — drops sitemap links and `alternate_urls` for
  languages the **anonymous** user cannot access (integration with `simple_sitemap`).
- `hook_form_user_form_alter()` + `LimitLanguageOptionsCallback::preRender()` — limits the
  *Preferred language* options on the user account form to accessible languages.
- `hook_field_widget_single_element_language_select_form_alter()` +
  `LimitLanguageOptionsCallback::afterBuild()` — limits `language_select` widget options.

## Plugin / controller swaps

- `hook_language_negotiation_info_alter()` — replaces core's `language-browser`
  negotiation class with `LanguageAccessNegotiationBrowser`, so Accept-Language
  negotiation won't route a user into a forbidden language.
- `hook_config_pages_contexts_info_alter()` — replaces the `config_pages` `language`
  context with an access-aware `Plugin\ConfigPagesContext\Language`.
- `RouteSubscriber` (service `language_access.route_subscriber`, priority -220 on
  `RoutingEvents::ALTER`) — rewrites every entity's
  `entity.<type>.content_translation_overview` `_controller` to
  `ContentTranslationController::overview`, or `ContentTranslationTmgmtContentController`
  when `tmgmt_content` is enabled, filtering the overview to accessible languages.

## Extending

There is no plugin type to implement. To exempt more paths, decorate or subclass
`LanguageAccessSubscriber` and override `pathIsAllowed()`. To reuse the same permission in
your own access checks, call
`AccountInterface::hasPermission('access language ' . $langcode)`.
