<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The paragraphs listing view, Host Entity field, and delete route

The module has **no settings form**. Its behaviour is delivered by a shipped View, a custom
Views field, and a delete route.

## The listing view

- Machine name: `paragraphs` (shipped in `config/install/views.view.paragraphs.yml`).
- Path: **`/admin/content/paragraphs`** (added as a tab under the content admin).
- Base table: `paragraphs_item_field_data`.
- Access: permission **`administer paragraphs`**. (A `post_update` hook,
  `paragraphs_admin_post_update_paragraphs_admin_view_permission`, migrates the view's access
  from `access content` to `administer paragraphs` on older installs.)

Because it is an ordinary View, you can clone or extend it — add filters (e.g. by paragraph
type), exposed sorts, or extra fields.

## The "Host Entity" Views field (`paragraphs_host_entity`)

Registered by `paragraphs_admin_views_data_alter()`:

```php
$data['paragraphs_item_field_data']['paragraphs_host_entity']['field'] = [
  'title' => t('Host Entity'),
  'help'  => t('Displays a link to the top-level host entity for a paragraph.'),
  'id'    => 'paragraphs_host_entity',
];
```

Handler class `Drupal\paragraphs_admin\Plugin\views\field\ParagraphsHostEntity` (`@ViewsField`
id `paragraphs_host_entity`). At render it walks `getParentEntity()` up the chain until the top
parent is **not** a Paragraph, then:
- if that entity has a `canonical` link template → renders a `Link` to it;
- else if it has a label → renders the plain label (typical for a paragraph-in-paragraph top
  parent, i.e. a likely **orphan**);
- else → nothing.

To add it to any Paragraphs-based view, add a field whose `table` is `paragraphs_item_field_data`
and `field`/`id` is `paragraphs_host_entity`.

## Deleting a paragraph

- Route: `paragraphs_admin.delete_form`, path **`/paragraph/{paragraph}/delete`**.
- Form: `Drupal\paragraphs_admin\Form\ParagraphDeleteForm`, wired to the paragraph entity type
  as the `paragraph_delete` form via `paragraphs_admin_entity_type_build()`.
- Access requirement: `_entity_access: 'paragraph.delete'`.

This gives a standard confirm-delete form for a single paragraph entity, which is how you remove
orphaned/stray paragraphs found in the listing.
