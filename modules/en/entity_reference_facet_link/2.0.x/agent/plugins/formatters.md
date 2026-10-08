<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Facet Link / Facet URL formatters

Two `@FieldFormatter` plugins for `field_types = { entity_reference }`, both extending
`EntityReferenceFacetFormatterBase`:

| Formatter id | Label | Output |
|---|---|---|
| `entity_reference_facet_link` | Facet link | `#type => link` per referenced entity (label linked to the facet page) |
| `entity_reference_facet_url` | Facet URL | `#markup` of the facet URL string only |

## Configure (UI)

1. On the field's **Manage display** page (`/admin/structure/types/manage/<bundle>/display`,
   or a view's field settings), set *Format* to **Facet link** (or **Facet URL**).
2. Click the settings cog and pick the **facet** from *"Select the facet to which the labels
   should be linked."*
3. Update, then **Save**.

The facet select only lists facets whose facet source targets **this same field**
(`settingsForm()` filters by the field's data definition). If you have multiple search pages
faceting the field, give the facets distinct labels so you can tell them apart. You need no
knowledge of the facet's path — the plugin reads everything it needs from the facet config.

## Where it is stored

In the display config `core.entity_view_display.<entity>.<bundle>.<view_mode>`:

```yaml
content:
  field_topic:
    type: entity_reference_facet_link   # or entity_reference_facet_url
    settings:
      facet: my_topic_facet             # the facets_facet entity id
    label: above
```

Default setting: `facet => ''` (no facet → the formatter renders nothing). Schema:
`field.formatter.settings.entity_reference_facet_link` (single string `facet`).

## Set via drush (scriptable)

```php
$vd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$vd->setComponent('field_topic', [
  'type' => 'entity_reference_facet_link',
  'settings' => ['facet' => 'my_topic_facet'],
  'label' => 'above', 'weight' => 10, 'region' => 'content',
])->save();
```

Read back: `drush config:get core.entity_view_display.node.article.default content.field_topic`.

## How the link is built (render time)

`viewElements()` loads the `facets_facet` entity, reads its facet source's
`getUrlProcessorName()`, instantiates that processor via
`plugin.manager.facets.url_processor`, wraps each referenced entity in a `Result`, and calls
`buildUrls()` — so links exactly match the facet's active URL processor (default, Facets
Pretty Paths, etc.). Cache tags from the entity and the facet source are merged in.
`calculateDependencies()` adds the facet as a config dependency.

**Requires** the `facets` module (the base class imports `Drupal\facets\…`). With no matching
facet selected, the field displays nothing.
