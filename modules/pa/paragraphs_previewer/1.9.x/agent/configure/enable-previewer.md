<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enable the previewer on a Paragraphs field

There is **no admin settings page** (`configure: null`). Everything is per-field form-display
config plus one global config object.

## 1. Switch the widget (per field, per form mode)

UI: *Manage form display* of the host bundle (e.g.
`/admin/structure/types/manage/article/form-display`) → set the paragraphs field's **Widget**
to **Paragraphs Previewer** → cog → set *Default edit mode* to **Closed** (or *Preview*) →
Update → Save. The widget summary then starts with `Previewer: Enabled`.

Config written to `core.entity_form_display.<entity>.<bundle>.<form_mode>`:

```yaml
content:
  field_page_sections:
    type: paragraphs_previewer     # was: paragraphs
    settings:
      edit_mode: closed            # trait default
      # ...all normal ParagraphsWidget settings still apply
```

Scriptable equivalent:

```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$c = $fd->getComponent('field_page_sections');   // an entity_reference_revisions field
$c['type'] = 'paragraphs_previewer';
$fd->setComponent('field_page_sections', $c)->save();
```

Read it back: `drush cget core.entity_form_display.node.article.default content.field_page_sections`.

## 2. Choose the view mode used to render the preview

Global, one value for the whole site, no UI:

```bash
drush cget paragraphs_previewer.settings previewer_view_mode   # default: full
drush cset paragraphs_previewer.settings previewer_view_mode teaser -y
```

Schema: `paragraphs_previewer.settings` (`config_object`) with the single string
`previewer_view_mode`. `ParagraphsPreviewController` falls back to `full` when the value is
empty. The view mode is applied to the **parent entity's field**, i.e.
`$parent_clone->{$field_name}->view($previewer_view_mode)`, so the paragraph is rendered exactly
as that field would render it on the parent.

## 3. Grant the permission

The preview route is denied without `view any paragraphs previewer` — see
[../permissions/view-previews.md](../permissions/view-previews.md).

## Notes / caveats

- The widget only appears for fields of type `entity_reference_revisions` (Paragraphs fields).
- The preview renders with the **front-end theme** and strips page chrome, so a paragraph whose
  styling depends on node-level wrapper markup can look different from the real page.
- The button is hidden for a row whose paragraphs edit mode is `remove`/`removed`, and for a
  paragraph the user has no `view` access to.
- `paragraphs_previewer_update_8001()` rewrites any form display still using the misspelled
  `paragraphs_previwer` plugin id to `paragraphs_previewer`; re-export config afterwards.
