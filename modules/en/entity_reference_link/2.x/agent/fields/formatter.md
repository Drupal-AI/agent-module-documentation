<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Entity Reference Custom Link" formatter

One class: `EntityReferenceLinkFormatter` (extends core `FormatterBase`, implements
`ContainerFactoryPluginInterface`) at
`src/Plugin/Field/FieldFormatter/EntityReferenceLinkFormatter.php`.

```
@FieldFormatter(
  id = "entity_reference_link",
  label = @Translation("Entity Reference Custom Link"),
  field_types = { "entity_reference" }
)
```

## Install & enable

```bash
composer require drupal/entity_reference_link
drush en entity_reference_link -y
```

Only dependency is core **`field`**. No permissions, no Drush, no config form, no config schema.

## Enable it on a field

Applies to any core **entity_reference** field (`field_types = { "entity_reference" }`). UI path:
*Structure → (bundle) → Manage display* → set that reference field's format to **Entity Reference
Custom Link** → click the gear to open the settings (below). Or set it in the view-display config:

```bash
drush cset core.entity_view_display.node.article.default \
  content.field_related.type entity_reference_link -y
drush cr
```

Note: the module ships **no config schema**, so strict config-schema tooling may warn on the
`settings` block of the view-display; the settings still save and render.

## Tokens

Three tokens are available inside the URL template, the link-attributes values, and the link-text
template. They are substituted per referenced item by `viewValue()`:

| Token | Value | Source |
|---|---|---|
| `{{ id }}` | Referenced entity ID (`target_id`) | field item value |
| `{{ referencing_id }}` | ID of the entity holding this field | `$items->getEntity()->id()` |
| `{{ label }}` | Referenced entity label, or a *"Missing %type Entity %id"* placeholder if the target no longer loads | `$entity->label()` |

Templates are rendered with `\Drupal::service('twig')->renderInline($template, $replacements)`.

## Settings (from `defaultSettings()`)

### Link generator (`link_generator`)

`route` (default) or `custom` — chooses which URL block below is used.

### Route mode (`route_url_options`) — when `link_generator = route`

| Key | Default | Meaning |
|---|---|---|
| `route` | `''` | Machine name of a Drupal route; the URL is `Url::fromRoute($route)`. |
| `route_id_usage` | `route_parameter` | How the **referenced** ID is applied: `route_parameter`, `query_parameter`, or `none`. |
| `route_id_parameter` | `''` | Parameter key for the referenced ID (route or query, per above). |
| `route_referencing_id_usage` | `route_parameter` | How the **referencing** (host) ID is applied: `route_parameter` / `query_parameter` / `none`. |
| `route_referencing_id_parameter` | `''` | Parameter key for the referencing ID. |

`viewValue()` builds `Url::fromRoute($route)`, then per `*_id_usage`: `route_parameter` →
`$url->setRouteParameter($param, $id)`; `query_parameter` → merged into `$url->setOption('query', …)`
(the referencing-ID branch merges rather than overwrites an already-set query). The referenced route
must exist, or `Url::fromRoute()` throws when the field is viewed.

### Custom mode (`custom_url_options`) — when `link_generator = custom`

| Key | Default | Meaning |
|---|---|---|
| `template_href` | `/{{ id }}` | Twig template for the `href`. Rendered, then `Url::fromUserInput($rendered)`. |

`Url::fromUserInput()` requires the result to begin with `/`, `#`, or `?` (internal paths only) and
throws otherwise, so external/absolute URLs and non-path schemes are not accepted here.

### Display options (`display_options`)

| Key | Default | Meaning |
|---|---|---|
| `link_template` | `{{ label }}` | Twig template for the visible **link text**. |
| `link_attributes` | `''` | Extra anchor attributes, **one per line** in `key=value` form. Each value is Twig-rendered with the tokens; lines are split on `preg_split('/$\R?^/m', …)` and only lines with exactly one `=` are used. Applied as `$url->setOption('attributes', …)` (route mode). |

The link itself is built with `Link::fromTextAndUrl($link_text, $url)` and returned as
`->toString()->getGeneratedLink()`.

### List / multi-value options (`list_options`)

| Key | Default | Meaning |
|---|---|---|
| `single_item_type` | `no_list` | `no_list` = a single value skips list markup (rendered as bare `#markup`); `use_list` = apply the list logic even for one value. |
| `list_option_type` | `separator` | `separator`, `element`, `ol`, or `ul`. |
| `list_separator` | `, ` | Text joined between items when type is `separator` (`implode`). |
| `list_element` | `div` | Wrapper tag (`div`/`p`/`span`/`h1`–`h6`) when type is `element`; each item becomes an `#type => html_tag`. |
| `list_classes` | `''` | CSS classes on the `<ol>`/`<ul>` wrapper (`item_list` theme). |
| `list_item_classes` | `''` | CSS classes on each list item / element wrapper. |

`viewElements()` prepares each item via `viewValue()` keyed by referenced entity ID, then emits:
`separator` → one `#markup` of the imploded links; `element` → one `html_tag` per item;
`ol`/`ul` → a `#theme => item_list`; single-value `no_list` → bare `#markup` per item.

## `settingsSummary()`

Shows: link generator, then route (route mode) or href (custom mode), link-text template, single-item
handling, and list type — displayed on the Manage-display summary line.

## Operational notes

- The formatter loads each referenced entity with the entity type manager to resolve `{{ label }}`;
  a deleted/missing target renders the *"Missing … Entity …"* placeholder instead of failing.
- All of `route`, `template_href`, `link_template`, `link_attributes` and the list options are
  **admin-authored display settings**, not end-user input.
- `viewElements()` uses `\Drupal::` static calls for `entityTypeManager` and `twig` even though the
  class implements `ContainerFactoryPluginInterface`; behaviour is unaffected.
