# The `renderThis` Twig filter

Defined in `src/TwigExtension/RenderThis.php` as `TwigFilter('renderThis', ...)` →
`RenderThis::renderThisFilter($content, $view_mode = 'default')`.

## Signature
```twig
{{ content|renderThis }}                 {# view mode 'default' #}
{{ content|renderThis('teaser') }}       {# explicit view mode #}
```

## What `content` can be
| Type | What happens |
|---|---|
| `EntityInterface` | `\Drupal::entityTypeManager()->getViewBuilder($entity->getEntityTypeId())->view($entity, $view_mode)` — full entity view via its view builder. |
| `FieldItemInterface` | `$content->view($view_mode)` — renders the single field item. |
| `FieldItemListInterface` | `$content->view($view_mode)` — renders the field's item list through its formatters. |
| any object with a `view()` method | `$content->view($view_mode)` is called. |
| anything else | returns the translated string `"Twig Render This: Unsupported content."` |

Return value is a render array (or `TranslatableMarkup` for the unsupported case), which Twig
then renders — so formatters, view-mode config and cacheability all apply.

## Examples
```twig
{# a referenced node entity #}
{{ node.field_related.entity|renderThis('teaser') }}

{# a field item list from the render array's `content` #}
{{ content.field_body|renderThis }}

{# an entity provided by a preprocess function as `my_entity` #}
{{ my_entity|renderThis('full') }}
```

## Notes
- The filter does **not** perform an explicit entity view-access check; it renders whatever
  object the template passes. Since templates are authored by trusted developers, ensure the
  variable you feed it is one the current user is allowed to see (as with any Twig rendering).
- `renderThisFilter` is a `public static` method, so it can also be called directly from PHP if
  needed.
