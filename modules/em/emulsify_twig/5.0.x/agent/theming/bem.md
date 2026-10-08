<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `bem()` — BEM class builder

```twig
bem(base_class, modifiers = [], blockname = '', extra = [])
```

Returns a `Drupal\Core\Template\Attribute`, so you print it **in place of** `{{ attributes }}`:

```twig
<h1 {{ bem('title', ['small', 'red'], 'card', ['js-click']) }}>
```

## Output table (verified against the running site)

| Call | Rendered |
|---|---|
| `bem('title')` | `class="title"` |
| `bem('title', ['small', 'red'])` | `class="title title--small title--red"` |
| `bem('title', ['small', 'red'], 'card')` | `class="card__title card__title--small card__title--red"` |
| `bem('title', '', 'card')` | `class="card__title"` |
| `bem('title', ['small'], 'card', ['js-click', 'other'])` | `class="card__title card__title--small js-click other"` |
| `bem('title', '', '', ['js-click'])` | `class="title js-click"` |

Rules:

- With a `blockname`, the base class becomes `blockname__base` and every modifier becomes
  `blockname__base--modifier`. Without it, `base` and `base--modifier`.
- `modifiers` / `extra` may be a plain string; they are cast to an array.
- `extra` classes are appended verbatim (no BEM prefixing) — use them for JS hooks or utilities.

## Object form

Instead of positional arguments you may pass a single map/object:

```twig
{{ bem({ block: 'title', element: 'card', modifiers: ['small'], extra: ['js-click'] }) }}
```

Key mapping (from `BemTwigExtension::bem()`): `block` → `base_class`, **`element` → `blockname`**,
`modifiers` → `modifiers`, `extra` → `extra`. Note the naming inversion: `block` is the *element*
part and `element` is the block prefix. (In this branch the object form only remaps the variables
and does not build classes, so prefer the positional form.)

## Interaction with `attributes`

When Drupal is present the function:

1. Copies any `class` values from the template's `attributes` into the class list;
2. Copies every other attribute (id, `data-*`, contextual link markers…) onto the returned
   `Attribute` object;
3. **Removes** each of those from `context['attributes']`, so an `{% include %}` further down the
   template does not print them again.

That is why you replace `{{ attributes }}` with `{{ bem(...) }}` rather than printing both.

```twig
{# node.html.twig #}
<article {{ bem('node', [node.bundle], 'teaser') }}>
  {% include '@components/title.twig' %}   {# attributes no longer leak in here #}
</article>
```

## Verifying on a live site

```bash
drush ev '$t = \Drupal::service("twig");
print $t->createTemplate("<h1 {{ bem(\"title\", [\"large\"], \"teaser\", [\"js-teaser\"]) }}>x</h1>")
  ->render([]) . PHP_EOL;'
# <h1  class="teaser__title teaser__title--large js-teaser">x</h1>
```

(The double space is normal — `Attribute` renders with a leading space.)
