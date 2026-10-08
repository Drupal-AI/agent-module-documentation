<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# `add_attributes()` — merge extra attributes

```twig
add_attributes(additional_attributes = {})
```

Merges a map of attributes with the template's own `attributes` object, returns the merged
`Drupal\Core\Template\Attribute`, and clears the consumed attributes from the Twig context so they
do not trickle into `{% include %}`d templates.

```twig
{% set additional_attributes = {
  "class": ["foo", "bar"],
  "baz": ["foobar", "goobar"],
  "foobaz": "goobaz",
} %}

<div {{ add_attributes(additional_attributes) }}></div>
```

Value handling (`AddAttributesTwigExtension::addAttributes()`):

| Value type | Behaviour |
|---|---|
| array | kept as a list; any `Attribute` inside it (i.e. `bem()` output) is expanded into its values for that key |
| string / int / bool | cast to a single-item array |
| `Attribute` object | replaced by `$value->toArray()[$key]` |
| anything else | becomes `''` |

Existing values for the same key are **merged, not replaced**:
`array_merge($existing_attribute, $value)`.

## Combining with `bem()`

```twig
{% set additional_attributes = {
  "class": bem("foo", ["bar", "baz"], "foobar"),
} %}
<div {{ add_attributes(additional_attributes) }}></div>
```

## Verifying on a live site

```bash
drush ev '$t = \Drupal::service("twig");
$tpl = $t->createTemplate("<div {{ add_attributes({\"class\": [\"card\", \"card--wide\"], \"data-eval\": \"yes\"}) }}></div>");
print $tpl->render(["attributes" => new \Drupal\Core\Template\Attribute(["class" => ["existing"]])]) . PHP_EOL;'
# <div  class="existing card card--wide" data-eval="yes"></div>
```

Note the merge order: the template's own classes come first, then the added ones.

## When to use which

- `bem()` — you want the element's classes generated from a BEM naming scheme (and you are
  replacing `{{ attributes }}`).
- `add_attributes()` — you want to add arbitrary attributes (`data-*`, `aria-*`, `role`, extra
  classes) on top of whatever Drupal already put in `attributes`.
- They compose: build the class list with `bem()` and hand it to `add_attributes()`.
