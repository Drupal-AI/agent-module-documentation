<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `embedded_paragraphs` entity

Each embed an editor creates is stored as an **`embedded_paragraphs`** content entity that wraps
the actual Paragraph. The `<drupal-paragraph>` tag in the text references it (by paragraph id /
revision id / entity uuid).

## Entity definition

`Drupal\paragraphs_entity_embed\Entity\EmbeddedParagraphs` (`@ContentEntityType`):
- id `embedded_paragraphs`; base_table `embedded_paragraphs`, revision_table
  `embedded_paragraphs_revision`; revisionable (keys id/uuid/revision_id).
- Handlers: EntityViewBuilder, `EmbeddedParagraphsViewsData`, SqlContentEntityStorage,
  form `EmbeddedParagraphsForm` (default/add/edit), access `EmbeddedParagraphsAccessControlHandler`.
- `field_ui_base_route = entity.embedded_paragraphs.edit_form`.

## Base fields

| Field | Type | Notes |
|---|---|---|
| `label` | string (255) | Required, revisionable. The embed's name. |
| `paragraph` | entity_reference_revisions → `paragraph` | Revisionable. Default view: rendered with view mode `embed`. Default form widget: `entity_reference_embed_paragraphs`. |

Useful methods: `label()`, `getUuid()`, `getParagraph()` (returns referenced Paragraph
entities). (`getLabel()`, `setId()`, `setUuid()`, `setParagraph()` are deprecated in 4.0.0.)

## Create / read in code

```php
use Drupal\paragraphs\Entity\Paragraph;
use Drupal\paragraphs_entity_embed\Entity\EmbeddedParagraphs;

$paragraph = Paragraph::create(['type' => 'my_para_type']);
$paragraph->save();                                  // an entity_reference_revisions target

$embed = EmbeddedParagraphs::create([
  'label' => 'My embedded component',
  'paragraph' => $paragraph,                          // or ['target_id'=>id,'target_revision_id'=>rid]
]);
$embed->save();

// read back
$embed->label();
$paras = $embed->getParagraph();                      // Paragraph[]
```

Load by property:
```php
\Drupal::entityTypeManager()->getStorage('embedded_paragraphs')
  ->loadByProperties(['label' => 'My embedded component']);
```

## Access

`EmbeddedParagraphsAccessControlHandler` maps operations to the module permissions
(`view` / `add` / `edit` / `delete paragraphs entity embed`).
