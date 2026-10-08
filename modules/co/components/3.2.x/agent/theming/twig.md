# Twig namespaces, functions & filters

## Register a namespace
In any theme's or module's `<name>.info.yml`:
```yaml
components:
  namespaces:
    fusion:
      - components/fusion      # paths are relative to the extension
```
Then reference templates as `@fusion/box.twig` from any Twig file (`include`,
`embed`, `extends`, or the `template()` function below). Multiple paths per
namespace are searched in order. The module's own default namespace is
`components`; a theme may reuse it because the module sets
`allow_default_namespace_reuse: true`.

## Twig function
- `template(name, key=value, ...)` — returns a **render array** for a template
  name or theme hook, after Drupal's normal preprocessing and theme suggestions.
  Named args become `#key` variables. Namespaced names (starting `@`) are NOT
  allowed here — pass a bare template name or theme hook.
  ```twig
  {% set list = template('item-list.html.twig',
       title = 'Animals', items = ['lemur', 'weasel']) %}
  {# a theme hook / suggestion also works: #}
  {% set list = template('item_list__node', items = [...]) %}
  ```

## Twig filters (operate on render arrays)
- `recursive_merge(array)` — `array_replace_recursive` into the element:
  `{{ form|recursive_merge({'element': {'#attributes': {'placeholder': 'Label'}}}) }}`
- `set(at, value)` — replace a deeply-nested value by dotted path:
  `{{ form|set('element.#attributes.placeholder', 'Label') }}`
- `add(at, value)` / `add(at, values=[...])` — append to a nested key; if the
  target is an array the value(s) are merged/appended, otherwise it is replaced:
  `{{ form|add('element.#attributes.class', 'new-class') }}`

All three accept named args (`at=`, `value=`, `values=`) and throw a Twig
`RuntimeError` if the piped value is not array/Traversable.
