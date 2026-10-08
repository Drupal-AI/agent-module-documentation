<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Front-end stylesheet attachment

The module's only active runtime behaviour. All code lives in `development_assistant.module`.

## `development_assistant_page_attachments_alter(array &$attachments)`
Runs on every page build. It attaches the Browser Development compiled stylesheet only when the page is rendered with the site's front-end theme:

```php
$active = \Drupal::theme()->getActiveTheme()->getName();
$current_theme = \Drupal::config('system.theme')->get('default');
if ($active === $current_theme) {
  $attachments['#attached']['html_head'][] = [
    [
      '#type' => 'html_tag',
      '#tag' => 'link',
      '#attributes' => [
        'rel' => 'stylesheet',
        'media' => 'all',
        'href' => _development_assistant_create_link_url(),
      ],
    ],
    'development_assistant',
  ];
}
```

- Condition: `active theme === system.theme:default`. Admin pages rendered with a separate admin theme are therefore skipped.
- The `<link>` is added to `html_head` (rendered in the document `<head>`), keyed `development_assistant`.

## `_development_assistant_create_link_url()`
Returns a **fixed, hard-coded path** — no dynamic/user input is interpolated:

```php
return "/sites/default/files/browser-development/css/browser-development.css";
```

The commented-out block in the source shows an earlier absolute-URL variant driven by `development_assistant.settings` `form_input['uri']`; it is disabled, so the relative path above is always used. The referenced CSS file is produced by the Browser Development module and written under the public files directory; this module does not create it.

## `development_assistant_module_implements_alter(&$implementations, $hook)`
For `$hook == 'preprocess_html'`, it removes and re-adds this module's implementation so it sorts **last** among `preprocess_html` implementations. (The module ships no `preprocess_html` hook itself in this release; the alter simply guarantees ordering if one is added.)

## `development_assistant_help($route_name, RouteMatchInterface $route_match)`
Provides the text on `help.page.development_assistant` describing the "uninstall on production, keep the render" purpose.

## Operating notes
- Enable: `composer require drupal/development_assistant` then `drush en development_assistant` (or the Extend UI). No configuration step follows.
- To change the emitted CSS URL you must edit `_development_assistant_create_link_url()`; there is no admin setting for it in this release.
- The link is emitted unconditionally (aside from the theme check) — there is no cache context on the theme comparison beyond Drupal's default page/theme handling.
