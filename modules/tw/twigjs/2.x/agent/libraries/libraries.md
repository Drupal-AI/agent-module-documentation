<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twig.js asset libraries — provider reference

Source: `twigjs.libraries.yml`, `js/twig.min.js` (vendored), `js/twigjs.light.js`,
`js/twigjs.drupal.js`, `js/underscore.min.js` (vendored). The whole module is these libraries; the
`.module` file is an empty stub and there is no config/route/service/permission of any kind.

## Install / enable

`ddev drush en twigjs -y` (or add via `composer require drupal/twigjs`). No settings page, no config
to export, nothing to configure — enabling only makes the libraries attachable. Uninstall is
equally inert.

## The three libraries

### `twigjs/twigjs` — the real Twig.js
```yaml
twigjs:
  js:
    js/twig.min.js: {}
```
Loads vendored Twig.js and exposes the browser global **`Twig`**. API:
`Twig.twig({ id: 'someId', data: templateString }).render({ ...vars })` returns an HTML string.
Full Twig-in-JS: tags, filters, functions (see https://github.com/twigjs/twig.js). `id` caches the
compiled template inside twig.js.

### `twigjs/light` — underscore-backed minimal interpolation
```yaml
light:
  js:
    js/underscore.min.js: {}
    js/twigjs.light.js: {}
```
Loads vendored Underscore plus `js/twigjs.light.js`, exposing the global **`TwigLight`** with the
*same call shape* as `Twig` (`TwigLight.twig({id, data}).render(vars)`). Implementation
(`js/twigjs.light.js`): a module-scope `cache = {}` keyed by `id`; `render` is
`_.template(data.data, { interpolate: /\{\{(.+?)\}\}/g })`. Consequences:
- **Only `{{ expression }}` substitution.** No `{% for %}`, `{% if %}`, filters, or any Twig tag —
  those are not supported.
- The expression is evaluated by Underscore as **JavaScript**, so `{{ name }}` reads `name` from the
  render-data object.
- Compiled templates are cached by `id`; reusing an `id` returns the first-compiled version.
- Rationale (README/project page): far fewer kilobytes than full Twig.js when you only need trivial
  variable substitution shared between server-rendered and client-rendered output.

### `twigjs/drupal.twigjs` — Drupal `trans` tag extension
```yaml
drupal.twigjs:
  js:
    js/twigjs.drupal.js: {}
  dependencies:
    - twigjs/twigjs
```
Depends on `twigjs/twigjs`. `js/twigjs.drupal.js` calls `Twig.extend(...)` to register two custom
tags via `Twig.exports.extendTag`:
- **`trans`** (`regex /^trans$/`, `open: true`, `next: ['endtrans']`): `compile` returns the token
  unchanged; `parse` does `Twig.parse.apply(this, [token.output, context])` and returns that as the
  tag output. Net effect: it **renders the content between `{% trans %}…{% endtrans %}`** by
  re-parsing it — it does *not* perform any Drupal `t()` translation; it exists so a template
  containing the `trans` tag does not error client-side.
- **`endtrans`** (`open: false`, `next: []`): the closing marker.

Attach this library (instead of, or in addition to, `twigjs/twigjs`) when a client-side template
uses the `{% trans %}` tag.

## How to use it (the intended pattern, from the project docs and test fixture)

Server side, put the template *string* into `drupalSettings` and attach a library:
```php
return [
  '#type' => 'inline_template',
  '#template' => $template,
  '#context' => ['users' => $data],
  '#attached' => [
    'drupalSettings' => ['twigjsTest' => ['inlineTemplate' => $template]],
    'library' => ['twigjs/drupal.twigjs'], // or 'twigjs/twigjs' / 'twigjs/light'
  ],
];
```
Client side, in a `Drupal.behaviors` callback:
```js
var t = Twig.twig({ id: 'x', data: settings.twigjsTest.inlineTemplate });
wrapper.innerHTML = t.render({ users: ['testUser'] });
```

## Drupal-vs-twig.js caveats (documented)

- **Variables must resolve to strings.** A template like `{{ content }}` where `content` is a nested
  render array (`['image' => …, 'text' => …]`) does **not** work in twig.js — pass already-rendered
  strings.
- twig.js is not a byte-for-byte reimplementation of Drupal's Twig; complex filters/functions may
  differ. The `light` variant is far more limited still (interpolation only).

## The `tests/` tree is a fixture, not a feature

`tests/modules/twigjs_test/` (a `package: Testing` submodule) and its `TestController` exist only to
drive the FunctionalJavascript tests (`InlineTest`, `SimpleTest`, `LightTest`, `TemplateFileTest`).
It is **not** installed by enabling `twigjs`. For accuracy on what those fixtures do:
- `testSimple()` / `testInline()` / `testLight()` build hardcoded template strings and echo them into
  `drupalSettings` so the JS can re-render them client-side and the test can compare.
- `testFile()` reads a **hardcoded** core template with
  `file_get_contents(DRUPAL_ROOT . '/core/modules/system/templates/time.html.twig')`. The path is a
  fixed constant — not a request parameter — so it just proves a `.html.twig` file's contents can be
  handed to twig.js. None of these routes ship in the real module.

There is no route or service in the installable module that returns a template file's contents to
the browser; template strings are only ever those the calling code chooses to place in
`drupalSettings`.
