<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `link` FieldGroupFormatter plugin

`Drupal\field_group_link\Plugin\field_group\FieldGroupFormatter\Link` — the module's only
plugin. This module **consumes** Field Group's plugin type; it defines no plugin type of its
own.

## Annotation

```php
@FieldGroupFormatter(
  id = "link",
  label = @Translation("Link"),
  description = @Translation("Renders a field group as a link."),
  supported_contexts = { "view" },
  supported_link_field_types = { "link", "entity_reference", "file", "image" }
)
```

- `supported_contexts = {"view"}` → the format is offered on **Manage display** only, never on
  Manage form display.
- `supported_link_field_types` is a **custom** annotation key read back in `settingsForm()` to
  decide which of the bundle's fields can be picked as `target`.

`defaultContextSettings()` returns
`['target' => '_none', 'classes' => '', 'custom_uri' => '', 'target_attribute' => 'default']`
merged over Field Group's base defaults.

## How the URL is resolved (`preRender()`)

1. Find the entity in the render array. It looks for `#<entity_type>`, falling back to
   `#term` (taxonomy_term), `#account` (user), then `#entity`. **If no
   `ContentEntityInterface` is found it returns and no link is produced** — this is why exotic
   entity types occasionally "do nothing".
2. Switch on `target`:
   - `entity` → `$entity->toUrl()`, skipped when `$entity->isNew()`.
   - `custom_uri` → `token.replace($uri, [<entity_type> => $entity], ['clear' => TRUE, 'sanitize' => TRUE])`
     then `Url::fromUri()`; an `\InvalidArgumentException` aborts silently.
   - anything else → `getUrlFromField()`, which reads `$entity->get($target)->getValue()[0]` and,
     by field type:
     - `link` → `Url::fromUri($value['uri'], $value['options'] ?? [])`
     - `file` / `image` → `File::load($value['target_id'])->createFileUrl(FALSE)`
     - `entity_reference` → load the target entity, `$target_entity->toUrl()`
     Empty field → no URL → no link.
3. If a URL was produced, the group element is turned into:

```php
$element += [
  '#type' => 'field_group_link',
  '#url' => $url,
  '#options' => ['attributes' => ['class' => ['field-group-link', ...$group_classes]]],
];
// plus 'target' => '_blank' when target_attribute !== 'default'
// plus 'id' => <id setting> when the group's id setting is non-empty
```

4. Every child element is moved **by reference** into `$element['#title'][$child]`, so the
   fields render inside the anchor.

## The render element

`Drupal\field_group_link\Element\LinkElement` — `@RenderElement("field_group_link")`, a
subclass of core's `Link` element. Its only change is `preRenderLink()`: it unsets the children
that were copied into `#title` so they are not output twice.

## Actual markup

```html
<a href="https://example.com/target" class="field-group-link" target="_blank">
  <div class="field field--name-field-fgl-text field--type-string field--label-hidden field__items">
    <div class="field__item">Inner text</div>
  </div>
</a>
```

`getClasses()` always prepends `field-group-link` to whatever is in the group's `classes`
setting.

## Caveats

- **Keep the contents anchor-safe.** A link field, a rich-text/formatted-text field, or another
  link group nested inside produces invalid nested `<a>` markup. The README says so explicitly.
- No link is rendered for a new/unsaved entity when `target: entity`.
- Only the **first delta** (`[0]`) of the target field is used.
- Base fields are excluded from the target select, even if their type matches.
- The formatter has no effect in form context at all.
