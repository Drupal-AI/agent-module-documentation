<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views argument default: `fcmatch` — "Field from route context"

Class `Drupal\field_context\Plugin\views\argument_default\FieldContext`
(`src/Plugin/views/argument_default/FieldContext.php`), declared with
`#[ViewsArgumentDefault(id: 'fcmatch', title: 'Field from route context')]`.
It `extends ArgumentDefaultPluginBase implements CacheableDependencyInterface`.

Purpose: supply a contextual filter's default value from a field on the **node of the
current route**, so one view can be embedded on many node pages and filter itself by that
node's own field value — no URL argument needed.

## Configure it in a view (UI path)

There is no module settings page. You configure the plugin entirely inside the Views UI:

1. Edit the view → **Advanced → Contextual filters → Add**, add the filter whose value you
   want defaulted (e.g. a taxonomy term reference field, node reference, etc.).
2. Open that contextual filter's settings → **When the filter value is NOT available** →
   choose **Provide default value**.
3. In **Type**, select **Field from route context** (this plugin).
4. **Choose source content** (`fcftype`): pick a content type / node bundle.
5. **Choose the field from `<bundle>`**: pick the field on that bundle whose value should be
   read from the current page's node. Only one of these per-bundle selects is visible at a
   time (see form mechanics below).

## Options / stored config

The plugin's own options (merged into the view's `argument_default` config for this plugin):

| Option key | Type | Meaning |
|---|---|---|
| `fcftype` | string (bundle machine name) | The chosen node bundle; also the selector key. Default `''`. |
| `fc<bundle>` | string (field machine name) | One option per bundle present in the field map, holding the field name to read for that bundle. Only `fc{fcftype}` is actually used at runtime. |

`defineOptions()` declares only `fcftype` with a default; the `fc<bundle>` keys are added
dynamically by the options form.

## Form mechanics (`buildOptionsForm`)

- Builds a bundle→fields map by inverting `entity_field.manager`'s node field map:
  `$this->entityFieldManager->getFieldMap()['node']`, then, for every bundle each field
  appears on, records `$field_options[$bundle][$field_key] = $field_key`.
- The **Choose source content** select (`fcftype`) lists those bundles, prefixed with a
  `'' => '-Select-'` empty option.
- For each bundle it renders a second select `fc<bundle>` listing that bundle's fields,
  shown/hidden with core **`#states`** (`visible` when
  `:input[name="options[argument_default][fcmatch][fcftype]"]` equals that bundle) rather
  than AJAX — the source comment notes an AJAX callback inside the plugin class is not
  callable, so `#states` imitates it. `buildOptionsForm()` returns nothing.

## Runtime (`getArgument()`)

```php
$key = $this->options['fcftype'];
if (!empty($this->options['fc' . $key])) {
  if (($node = $this->routeMatch->getParameter('node')) && $node instanceof NodeInterface) {
    $source = $node->getFieldDefinitions();
    if (isset($source[$this->options['fc' . $key]])) {
      return $node->get($this->options['fc' . $key])->getString();
    }
  }
}
// falls through with no return → NULL
```

- **Node-only.** It reads the `node` route parameter and requires `instanceof NodeInterface`;
  no other entity type is supported.
- Returns the field's `->getString()`. For an entity-reference field that is the target ID;
  for a multi-value field it is a delimited string, so the contextual filter must be set to
  **Allow multiple values** to consume it correctly.
- **Silent failure:** if there is no node on the route, or the node lacks the configured
  field, or no field was chosen, the method returns `NULL`. The view then applies whatever its
  "when the filter value is not available" behavior is — set that deliberately (commonly
  *Hide view* / *Display all results* per your intent).

## Cacheability

`implements CacheableDependencyInterface`:

- `getCacheContexts()` → `['url']`
- `getCacheMaxAge()` → `Cache::PERMANENT`

This varies an embedded view's cache per URL, which is what keeps per-page results correct
when the same view is placed on many node pages.

## Config schema

`config/schema/field_context.views.schema.yml` defines
`views.argument_default.fcmatch` as a `sequence` of `string` (labeled
*Field from route context*) — it maps the `fcftype` / `fc<bundle>` string options. This is
the module's only shipped config; there is no `config/install/`.
