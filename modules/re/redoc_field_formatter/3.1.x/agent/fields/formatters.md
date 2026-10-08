<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Redoc field formatters

Two display-only field formatters render a stored OpenAPI/Swagger spec (JSON or YAML) as Redoc
documentation. Neither adds its own settings — each just calls its parent's `defaultSettings()`,
`settingsForm()` and `settingsSummary()` — and both render through the same theme hook and template,
attaching the Redoc library.

| Formatter id | For field type | Class | Extends |
|---|---|---|---|
| `redoc_ui` | `file` | `RedocUIFormatter` | `Drupal\file\Plugin\Field\FieldFormatter\FileFormatterBase` |
| `redoc_link_ui` | `link` | `RedocUILinkFormatter` | `Drupal\link\Plugin\Field\FieldFormatter\LinkFormatter` |

Both classes live in `src/Plugin/Field/FieldFormatter/`. Both declare the annotation `label = "Redoc UI"`.

## Shared render path

`view()` on both formatters calls `parent::view()` then appends the library:

```php
$elements['#attached']['library'][] = 'redoc_field_formatter/redoc_field_formatter.redoc';
```

That library (`redoc_field_formatter.libraries.yml`) is a single **external** script:
`https://cdn.jsdelivr.net/npm/redoc@2.0.0/bundles/redoc.standalone.js` (`type: external`, no local
copy, no SRI hash). To run under a strict `script-src` CSP, or offline, allow that host or vendor the
file locally and override the library definition in a theme/module.

`viewElements()` builds one render element per delta with the theme hook `redoc_ui_field_item`:

```php
$element[$delta] = [
  '#theme' => 'redoc_ui_field_item',
  '#field_name' => $this->fieldDefinition->getName(),
  '#delta' => $delta,
  '#file_url' => $redoc_file,
];
```

The theme hook is registered in `redoc_field_formatter.module` (`hook_theme()`) with variables
`field_name`, `delta`, `file_url`. Template `templates/redoc-ui-field-item.html.twig`:

```twig
<div id="redoc-ui-{{ field_name }}-{{ delta }}">
  <redoc spec-url={{ file_url }}></redoc>
</div>
```

The Redoc web component (loaded by the CDN script) reads the `spec-url` attribute and fetches +
renders the spec **client-side, in the visitor's browser** — the server never fetches the spec.

## `redoc_ui` (file fields)

`RedocUIFormatter::viewElements()` iterates `getEntitiesToView($items, $langcode)` (so referenced
files respect normal file/entity access), and for each file sets:

```php
$redoc_file = $this->fileUrlGenerator->generateAbsoluteString($file->getFileUri());
```

`file_url_generator` is injected via `create()` / the constructor. `generateAbsoluteString()` returns
a percent-encoded absolute URL string. The uploaded field must allow the spec's extensions — add
`json` and `yml` (and/or `yaml`) to the field's **Allowed file extensions**, or the file cannot be
uploaded.

## `redoc_link_ui` (link fields)

`RedocUILinkFormatter` extends core `LinkFormatter` and reuses its `buildUrl()` helper. For each item
`#file_url` is set to the **`\Drupal\Core\Url` object** returned by `buildUrl($link)` (not a string) —
it iterates `$items` directly (no `getEntitiesToView`). The shared template then prints `{{ file_url }}`,
which string-casts that value; `\Drupal\Core\Url` has no `__toString()` (only `toString()`), so this
path can raise a render error. The **file-field `redoc_ui` formatter is the reliable path**; confirm
the link variant at runtime before relying on it.

## Set a formatter from code

```php
\Drupal::service('entity_display.repository')
  ->getViewDisplay('node', 'article', 'default')
  ->setComponent('field_openapi_spec', [
    'type' => 'redoc_ui',        // or 'redoc_link_ui' for a link field
    'settings' => [],
  ])->save();
```

Both formatters ship **no config schema of their own** (the module has no `config/schema/`); settings
are whatever the parent file/link formatter defines.
