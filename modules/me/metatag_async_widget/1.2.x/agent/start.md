# Metatag Async Widget — agent index

One field **widget** plugin, `metatag_async_widget_firehose` ("Advanced meta tags form
(async)"), for the `metatag` field type. It defers building the heavy Metatag form behind a
"Customize meta tags" button (AJAX), speeding up entity edit forms. No settings form
(`configure=null`), no permissions, no Drush. Depends on `metatag`.

- **Enable/configure the widget on a metatag field, its setting, stored config shape** →
  [configure/widget.md](configure/widget.md)

Key facts:
- Widget plugin `metatag_async_widget_firehose` (`AsyncMetatagFirehose extends
  Drupal\metatag\Plugin\Field\FieldWidget\MetatagFirehose`), `field_types = {"metatag"}`.
- Enable it on an entity's **Manage form display**: the metatag field's component becomes
  `type: metatag_async_widget_firehose` in the `entity_form_display` config entity.
- Inherits the `sidebar` widget setting (schema
  `field.widget.settings.metatag_async_widget_firehose` extends `...metatag_firehose`).
- Initial form shows only a "Customize meta tags" submit; AJAX rebuild reveals the real form.
  Unexpanded saves keep the entity's existing meta tags (`massageFormValues`/`extractFormValues`).
