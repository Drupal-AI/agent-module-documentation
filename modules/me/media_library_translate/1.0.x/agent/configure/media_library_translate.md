<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — enabling the translate button

The module has **no admin settings page** (`configure` is `null`). Its only setting is a per-widget
**third-party setting** on the core Media Library widget, toggled from a form display.

## Prerequisites

1. Media translation must be enabled for the media type(s) you want to translate — enable
   `content_translation`, then at `/admin/config/regional/content-language` turn on translation for
   the relevant Media type and fields (e.g. Name, the image field's Alt text).
2. The site must have more than one language (`/admin/config/regional/language`).
3. A reference field must use the **Media library** widget (`media_library_widget`) in a form display.

The button will only appear at all when the media entity type exposes a
`drupal:content-translation-overview` link template — content_translation provides this once media
translation is enabled.

## Turn it on (UI)

1. Go to the form display holding the media reference field, e.g.
   `/admin/structure/types/manage/{content_type}/form-display`.
2. Click the gear (settings) for the field using the **Media library** widget.
3. Check **"Show translation button"**. Save.

The widget summary then shows "Show translation button". After that, when an editor selects a media
item in the widget on a node add/edit/translate form, a small translate icon appears on the selected
item; clicking it opens the media item's translation-overview page in a modal.

## How it is stored / set programmatically

The setting is third-party setting `show_translation` under provider `media_library_translate`, on
the widget in the `core.entity_form_display.*` config entity. To set it in code:

```php
$display = \Drupal::service('entity_display.repository')
  ->getFormDisplay('node', 'article', 'default');
$component = $display->getComponent('field_media');           // the media_library_widget field
$component['third_party_settings']['media_library_translate']['show_translation'] = TRUE;
$display->setComponent('field_media', $component)->save();
```

There is no config schema shipped for this third-party setting, so the value is a plain boolean.

## What the setting does (mechanism)

When `show_translation` is TRUE, `hook_field_widget_single_element_form_alter()` adds a
`media_translate` link element to each selected item, but only if the selected media entity passes
`$media->access('update')` and the media entity type has the translation-overview link template. The
link is a plain `#type => link` to core's `drupal:content-translation-overview` route (resolves to
`/media/{media}/edit/translations`), rendered as an AJAX modal (`use-ajax`,
`data-dialog-type = modal`). All translation access, form tokens and storage are core
`content_translation`'s — this module adds no route or endpoint of its own.

The attached JS (`Drupal.behaviors.mediaLibraryTranslate`) only post-processes the opened modal: it
sets the translation-overview action links to open in a new tab and appends `destination=<current
path>` so the editor is returned to the form after translating.

## Removing it

Uncheck "Show translation button", or uninstall the module — nothing else changes, because no
translations or config entities are owned by this module (the third-party setting is simply dropped).
