<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twiggy (twiggy) — agent index

A text filter that runs field content through Twig. No dependencies, no config, no permissions.
Core requirement `^10.6 || ^11 || ^12`.

The entire module:

```php
public function process($text, $langcode) {
  $twig_service = \Drupal::service('twig');
  return new FilterProcessResult((string) $twig_service->renderInline($text, ['langcode' => $langcode]));
}
```

Attaching "Twiggy Filter" to a text format means every author who can use that format supplies
Twig template source that is rendered by the server. Attach it only to a format whose users you would
trust with template code (typically an admin-only format).
