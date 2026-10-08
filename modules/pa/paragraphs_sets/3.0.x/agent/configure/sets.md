# Define and enable Paragraphs Sets

## The `paragraphs_set` config entity

A set is a config entity (config name `paragraphs_sets.set.<id>`). Exported keys: `id`, `label`,
`description`, `icon_uuid`, `paragraphs`. The `paragraphs` value is an **ordered list** of
`{bundle: <paragraph_type>, data: {<field>: <default value>}}`.

Managed at **Structure → Paragraphs sets** (`/admin/structure/paragraphs_set`, route
`entity.paragraphs_set.collection`; add form route `paragraphs_sets.set_add`). Permission:
`administer paragraphs sets`.

Example config (`paragraphs_sets.set.landing.yml`):

```yaml
id: landing
label: 'Landing section'
description: 'Hero plus two text columns'
paragraphs:
  - bundle: bp_callout
    data: {  }
  - bundle: bp_simple
    data:
      field_body: '<p>Column one.</p>'
  - bundle: bp_simple
    data: {  }
```

Create from code:

```php
\Drupal\paragraphs_sets\Entity\ParagraphsSet::create([
  'id' => 'landing',
  'label' => 'Landing section',
  'description' => 'Hero plus two text columns',
  'paragraphs' => [
    ['bundle' => 'bp_callout', 'data' => []],
    ['bundle' => 'bp_simple', 'data' => ['field_body' => '<p>Column one.</p>']],
  ],
])->save();
```

```bash
drush php:eval 'foreach(\Drupal::entityTypeManager()->getStorage("paragraphs_set")->loadMultiple() as $id=>$s){print "$id: ".$s->label()."\n";}'
```

`data` sets default field values on each paragraph (primitive fields work out of the box; for
complex values use the [alter hooks](../hooks/data-alter.md)).

## Enable sets on a Paragraphs field (widget settings)

Paragraphs Sets adds three settings to the **Paragraphs** (stable `paragraphs`) widget on an
entity's *Manage form display* (they appear on the `entity_reference_revisions` field's widget
cog, only for the `paragraphs` widget — not the legacy `entity_reference_paragraphs` widget):

| Setting | Key | Meaning |
|---|---|---|
| Enable Paragraphs Sets | `use_paragraphs_sets` | Show the set selector atop the widget. |
| Limit sets to | `sets_allowed` | Restrict which sets are offered on this field. |
| Default set | `default_set` | Use this set as the field's default value (requires the widget's "Default paragraph type" = "- None -"). |

They are stored as **third-party settings** on that field's component in the form-display config:

```
core.entity_form_display.<entity>.<bundle>.<mode>
  -> content.<field>.third_party_settings.paragraphs_sets.use_paragraphs_sets: true
  -> ... .paragraphs_sets.sets_allowed: {landing: landing}
  -> ... .paragraphs_sets.default_set: landing
```

Set them in code with the form-display component's `third_party_settings`, e.g.:

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.page.default');
$component = $fd->getComponent('field_sections');
$component['third_party_settings']['paragraphs_sets'] = [
  'use_paragraphs_sets' => TRUE,
  'sets_allowed' => ['landing' => 'landing'],
  'default_set' => '_none',
];
$fd->setComponent('field_sections', $component)->save();
```

When enabled, editors get a set selector; choosing a set appends its paragraphs pre-filled with
the set's `data`. Runtime discovery uses `Drupal\paragraphs_sets\ParagraphsSets::getSets()` /
`getSetsOptions()`.
