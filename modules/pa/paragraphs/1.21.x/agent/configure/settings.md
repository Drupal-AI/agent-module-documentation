# Configure — Global settings

Form at **Admin → Configuration → Content authoring → Paragraphs settings**
(`/admin/config/content/paragraphs`, route `paragraphs.settings`, permission
`administer paragraphs settings`, form `Drupal\paragraphs\Form\ParagraphsSettingsForm`).

## `paragraphs.settings` config (`config/install/paragraphs.settings.yml`)
Schema `config/schema/paragraphs.schema.yml`:

| Key | Type | Meaning |
|---|---|---|
| `show_unpublished` | boolean | When TRUE, users holding the **view unpublished paragraphs** permission can see unpublished paragraphs. |

Read in code with `\Drupal::config('paragraphs.settings')->get('show_unpublished')`.

## Bundled view mode
`config/install/core.entity_view_mode.paragraph.preview.yml` defines the **preview**
view mode used by the stable widget's `closed_mode: preview`.

## Multilingual
Paragraph *fields* are translatable, but the paragraph entity-reference-revisions field on
the host must stay **non-translatable**. Enable content translation on the host bundle and
mark individual paragraph-type fields translatable; leave the paragraphs field itself
untranslated (Paragraphs shows a warning/error on the field config form otherwise). See
`paragraphs_form_field_config_edit_form_alter()` in `paragraphs.module`.
