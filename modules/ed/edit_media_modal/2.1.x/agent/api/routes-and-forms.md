# Routes, form override & the "edit in modal" link

## Media `edit` form override

`hook_entity_type_alter()` replaces the Media entity's **`edit`** form class with
`Drupal\edit_media_modal\Form\MediaForm` (an AJAX-aware subclass). Check it live:

```php
\Drupal::entityTypeManager()->getDefinition('media')->getFormClass('edit');
// => "Drupal\edit_media_modal\Form\MediaForm"
```

`hook_entity_form_display_alter()` then swaps the media form display to the form mode chosen in
the CKEditor plugin's `editMediaModalForms` map, based on the `text_format` query parameter on the
edit URL (so different formats/bundles can show different edit forms).

## Routes

| Route | Path | Purpose |
|---|---|---|
| `edit_media_modal.get_id_by_uuid` | `/edit-media-modal/edit-url/{uuid}` | Controller `EditMediaModalController::getEditUrl` — returns (JSON) the edit URL for a media entity by UUID. Custom access via `::access`. |
| `edit_media_modal.get_id_by_uuid.access_check` | `/edit-media-modal/check-access/{uuid}` | `::getEditUrlAccessCheck` — returns (JSON) whether the current user may edit that media UUID. `_access: TRUE`. |

The CKEditor 5 plugin JS uses these to resolve the embedded media's UUID to an edit URL and to
decide whether to show the edit button (unless `skipAccessCheck` is on).

## `ResponseSubscriber`

`edit_media_modal.response_subscriber` adjusts responses on the module's routes so the media edit
form submits/returns as an AJAX modal interaction.

## Reusing the modal edit link elsewhere

You can add an "Edit this media" link to any render array / form, not just CKEditor, by linking
to the media's `edit-form` with the `edit_media_in_modal` query flag and the AJAX dialog
attributes:

```php
$link = $media->toLink($this->t('Edit this media'), 'edit-form', [
  'query' => [
    'edit_media_in_modal' => TRUE,                       // enable the AJAX modal behavior
    'destination' => Url::fromRoute('<front>')->toString(), // optional redirect after save
  ],
])->toRenderable();

$link['#attributes'] = [
  'class' => ['use-ajax', 'button'],
  'data-dialog-type' => 'modal',
  'data-dialog-options' => json_encode(['height' => '75%', 'width' => '75%']),
];
```
