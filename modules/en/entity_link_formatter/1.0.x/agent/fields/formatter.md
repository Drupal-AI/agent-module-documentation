<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The "Entity link" formatter

## Install & enable

```bash
composer require drupal/entity_link_formatter
drush en entity_link_formatter -y
```

No hard dependencies (no `composer.json` ships; `info.yml` declares none). The **Token** module is
optional: when enabled, the settings form shows a token-browser link (`#theme => 'token_tree_link'`).
No sub-modules, no permissions, no Drush commands, no config schema.

## Enable it on a field

Plugin id **`entity_link`**, label *"Entity link"*, defined by
`EntityLinkFormatter` (`src/Plugin/Field/FieldFormatter/EntityLinkFormatter.php`), which extends core
`EntityReferenceFormatterBase`. It applies to **`entity_reference`** fields
(`field_types = { "entity_reference" }`) — not link fields, not other custom types.

UI: *Structure → (bundle) → Manage display* → set the reference field's format to **Entity link** →
click the gear to configure. Drush/config equivalent on a view display:

```bash
drush cset core.entity_view_display.node.article.default \
  content.field_ref.type entity_link -y
drush cr
```

## Settings

From `defaultSettings()`:

| Setting key | Default | Meaning |
|---|---|---|
| `link_template` | `''` | The target link, encoded `ENTITY_TYPE:LINK_TEMPLATE_ID` (e.g. `node:canonical`, `node:edit-form`). Empty falls back to `<target_type>:canonical`. Form field is **required**; options are every entity type × its registered link templates. |
| `link_text` | `''` | Text shown for the link. **Required** in the form. Token-replaced against the referenced entity (e.g. `[node:title]`). |
| `route_parameter_first` | `''` | Value for the route's 1st parameter (as it appears in the path). Literal or token, e.g. `[node:nid]`. |
| `route_parameter_context_first` | `displayed_entity` | Token context for param 1: `displayed_entity` (the entity being viewed) or `referenced_entity`. |
| `route_parameter_second` | `''` | Value for the route's 2nd parameter. |
| `route_parameter_context_second` | `displayed_entity` | Token context for param 2. |
| `route_parameter_third` | `''` | Value for the route's 3rd parameter. |
| `route_parameter_context_third` | `displayed_entity` | Token context for param 3. |
| `destination` | `''` | Adds `?destination=…` to the link. Token-replaced; the special value `[current-destination]` uses `redirect.destination` (return to the current page). |
| `destination_context` | `displayed_entity` | Token context for `destination`: `displayed_entity` or `referenced_entity`. |

`settingsSummary()` prints one line: `Link template: <link_template>`.

`getCurrentEntityType()` / `getCurrentTemplateId()` split `link_template` on `:` (falling back to the
field's `target_type` and `canonical` when unset).

## How `viewElements()` builds each link

For every `$entity` in **`getEntitiesToView($items, $langcode)`** (core access filtering applies):

1. Skip if `$entity->isNew()`.
2. Look up the target entity type's template path with `EntityType::getLinkTemplate(getCurrentTemplateId())`,
   then `routeProvider->getRoutesByPattern($path)->all()`; skip the item if no route matches. Take the
   first route (`array_key_first` / `reset`).
3. If the route declares `options.parameters`, iterate them positionally (first/second/third). For each,
   read the matching `route_parameter_*` value + `_context`:
   - if the value contains no `[`, it is used verbatim as the param;
   - only `entity:*` param types are token-resolved. The context entity is the **displayed** entity when
     context is `displayed_entity` and the field's parent is an `EntityAdapter`, otherwise the
     **referenced** entity; if that entity's type doesn't match the param's `entity:*` type the param is
     skipped. Otherwise `token->replace($value, [<type> => $contextEntity])` fills it.
4. `setDestination()` computes URL options: `[current-destination]` → `['query' => destination->getAsArray()]`;
   any other non-empty `destination` → `['query' => ['destination' => token->replace(...)]]` against the
   displayed or referenced entity per `destination_context`.
5. Build `Url::fromRoute($routeName, $params, $options)` and **skip the item unless `$url->access()`**.
6. Emit `#type => 'link'` with `#title => token->replace(link_text, [<referenced type> => $entity])` and
   `#url`; attach `#cache[tags] = $entity->getCacheTags()`.

## Notes

- Access is enforced twice: entities are pre-filtered by `getEntitiesToView()`, and each candidate link is
  dropped when `Url::access()` denies it — links to routes/entities the viewer cannot use are simply not
  rendered.
- Link markup is a core `#type => 'link'` render element (title and URL rendered/escaped by core), and the
  configured `link_text`/params/`destination` are administrator-supplied formatter settings, token-replaced
  with core's `Token::replace()`.
- Only up to **three** route parameters are supported, matched positionally to the route's declared
  `options.parameters` order.
- No config schema ships for the formatter settings, so strict config-schema tooling may flag the
  view-display config; settings still save and work.
