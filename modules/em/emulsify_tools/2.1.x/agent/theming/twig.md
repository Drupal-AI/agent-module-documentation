<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twig helpers & namespaces

Registered as `twig.extension` services (`emulsify_tools.services.yml`).

## `bem()` — build BEM classes (`BemTwigExtension`)

Signature: `bem(baseClass, modifiers = [], blockname = '', extra = [])` (needs context, `is_safe: html`).
Returns a Drupal `Attribute` object, so print it directly on an element.

| Call | Output |
|---|---|
| `{{ bem('title') }}` | `class="title"` |
| `{{ bem('title', ['small','red']) }}` | `class="title title--small title--red"` |
| `{{ bem('title', ['small','red'], 'card') }}` | `class="card__title card__title--small card__title--red"` |
| `{{ bem('title', '', 'card') }}` | `class="card__title"` |
| `{{ bem('title', ['small'], 'card', ['js-click']) }}` | `class="card__title card__title--small js-click"` |
| `{{ bem('title', '', '', ['js-click']) }}` | `class="title js-click"` |

Rule: with a blockname the base becomes `<block>__<base>`; each modifier appends `<class>--<modifier>`;
`extra` classes are added verbatim (for non-BEM/JS hooks).

## `add_attributes()` — merge attributes (`AddAttributesTwigExtension`)

`add_attributes(additionalAttributes = [])` (needs context, safe html) merges a map into the template's
current attributes and returns a **detached** collection so the merge does not leak into child includes.

```twig
{% set additional = { class: ['foo','bar'], 'data-baz': 'qux' } %}
<div {{ add_attributes(additional) }}></div>

{# combine with bem(): #}
<div {{ add_attributes({ class: bem('foo', ['bar'], 'foobar') }) }}></div>
```

## `{% switch %}` tag (`SwitchExtension` / `SwitchTokenParser`)

```twig
{% switch content.field_name.0 %}
  {% case 'text' %}<p>Text</p>
  {% case 'image' %}<p>Image</p>
  {% default %}<p>No match</p>
{% endswitch %}
```

`switch`, `case`, `endswitch` are required; `default` is optional.

## Theme-defined Twig namespaces

A theme declares Symfony-style namespaces in its **`.info.yml`** under `components.namespaces` (same shape
as the Components module); a high-priority Twig loader (`ThemeNamespaceLoader` + `ThemeNamespaceRegistry`)
resolves them:

```yaml
components:
  namespaces:
    atoms: components/01-atoms
    molecules:
      - components/02-molecules
      - src/components/molecules
    vendor_components: /../vendor/acme/components
```

- Relative paths resolve from the theme dir; a leading `/` resolves from the Drupal app root.
- Search order: active theme → its base themes → default frontend theme.
- Reference templates as `@atoms/button/button.twig`; nested templates are also registered by basename,
  so `@atoms/button.twig` resolves when unique. Allowed extensions: `twig`, `html`, `svg`.
