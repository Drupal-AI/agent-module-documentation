<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# twig_renderable — Twig function and filters

All three are defined in
`src/TwigExtension/RenderablesExtension.php` (`RenderablesExtension extends AbstractExtension`),
registered by the service `twig_renderable.twig.attr_extension` (tag `twig.extension`, argument
`@renderer`). The extension name (`getName()`) is `twig_renderable`.

## Function: `will_have_output(variable, ...parents)`

Declared with `needs_context => TRUE`, `needs_environment => TRUE`, `is_variadic => TRUE`.

```twig
{% if will_have_output('content', 'field_foo') %}
  <div class="card">{{ content.field_foo }}</div>
{% endif %}
```

- `variable` — the **name** (string) of a variable in the current template context.
- `parents` — zero or more additional keys forming a path into a nested render array.
  `will_have_output('content', 'field_media', 0)` targets `content.field_media.0`.

Returns a **boolean**. Logic (`willHaveOutput()`):

1. `array_unshift($parents, $variable)` — prepends the variable name to the key path.
2. `$element = &NestedArray::getValue($context, $parents, $key_exists)` — resolves the path by
   reference against the template context.
3. If the key does not exist or the value is `NULL` → returns `FALSE`.
4. If the value is an **array**: `$this->renderer->render($element)` renders it, then the context
   entry is **replaced** with `['#markup' => $output]`. When `$env->isDebug()` is true, HTML
   comments are stripped from the copy used for the emptiness test (so Twig debug markers do not
   make an empty element look non-empty). Returns `trim($output) != ''`.
5. If the value is a **scalar**: returns `trim($element) != ''`.

### Important side effect

Because step 4 writes `['#markup' => $output]` back into the context by reference, the render array
is **rendered once and finalised**. A subsequent `{{ content.field_foo }}` prints the cached markup
rather than rendering the array again — this is intentional (avoids double rendering) but means the
variable is mutated by the mere act of testing it. Do not rely on the original array structure
after calling `will_have_output` on it.

### Why not just `{% if content.field_foo %}`

A render array is a nested PHP array that is almost never falsy, and its true emptiness depends on
`#access`, lazy builders, formatters and cache metadata that only resolve at render time. Plain
Twig truthiness cannot see that; `will_have_output` renders first, then reports.

## Filter: `add_class(class)`

```twig
{{ content.field_x|add_class('highlight') }}
{{ attributes|add_class('is-active') }}
```

`addClass($renderable, $class)`:
- If `$renderable` is an **array** → `$renderable['#attributes']['class'][] = $class;`
- If it is a `\Drupal\Core\Template\Attribute` → `$renderable->addClass($class);`
- Returns the (modified) renderable/attribute. Anything else is returned untouched.

## Filter: `merge_attributes(attributes)`

```twig
{{ element|merge_attributes({'data-foo': 'bar', 'class': ['x', 'y']}) }}
{{ attributes|merge_attributes(other_attributes) }}
```

`mergeAttributes($renderables, $attributes)`:
- If `$attributes` is an `Attribute`, it is first converted with `->toArray()`.
- If `$renderables` is an **array**: merges into `#attributes` with `array_merge_recursive` (or sets
  `#attributes` if absent). Because it is recursive, `class` lists are concatenated, not replaced.
- If `$renderables` is an `Attribute`: any `class` key is applied via `->addClass()` and removed,
  then each remaining `name => value` is set with `->setAttribute()`.
- Returns the modified renderable/attribute.

## Safety note

No callback sets an `is_safe` flag. The function returns a boolean; the filters return render
arrays / `Attribute` objects that Twig renders and auto-escapes exactly as it would any other
renderable. The module does not mark any string as pre-sanitized HTML, so it introduces no new
autoescape bypass. Class and attribute values still pass through the normal `Attribute`/render-array
escaping when printed.
