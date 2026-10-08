<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable the processor and write the label mapping

The module has **no settings page of its own** (`configure: null`). You enable the
**Facets custom label processor** on a specific facet and fill in its `replacement_values`
textarea.

## Mapping syntax

One mapping per line:

```
<origin>|<value>|<new label>
```

- `<origin>` = `r` — match the facet item's **raw value** (machine name, or entity id such as
  a node/term id). Example: `r|article|Awesome news`.
- `<origin>` = `d` — match the facet item's **display value** (a content title or term name).
  Example: `d|Apple|Apple products`.
- Lines with fewer than two `|` separators are ignored. A display value that itself contains a
  `|` is **not** supported.
- Raw-value matches are applied first, then display-value matches, per result.

## Where it is stored

Config entity `facets.facet.<facet_id>`:

```yaml
processor_configs:
  facets_custom_label:
    processor_id: facets_custom_label
    weights:
      build: 50
    settings:
      replacement_values: |-
        r|article|Awesome news
        d|Apple|Apple products
```

## Via the UI

1. Edit the facet (Facets admin: `/admin/config/search/facets` → your facet).
2. In the facet's **Processors** section, enable **Facets custom label processor**. Mind the
   processor order — it runs at the `build` stage (weight 50); make sure any processor that
   sets the labels you want to match runs before it.
3. In the **Replacement values** textarea, add your `origin|value|new label` lines.
4. Save the facet.

## Via drush php:eval (scriptable)

```php
$facet = \Drupal\facets\Entity\Facet::load('my_facet');
$facet->addProcessor([
  'processor_id' => 'facets_custom_label',
  'weights' => ['build' => 50],
  'settings' => ['replacement_values' => "r|article|Awesome news\nd|Apple|Apple products"],
]);
$facet->save();
```

## Read it back

```bash
drush cget facets.facet.my_facet processor_configs.facets_custom_label.settings.replacement_values
```

## Translated labels

Enable core **Configuration Translation** and translate the facet configuration to provide
per-language custom labels.
