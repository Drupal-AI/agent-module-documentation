# Description List Field — agent index

Provides one field type, `description_list_field`, storing term/description pairs rendered as an
HTML `<dl>`. Ships a default widget and formatter and a Twig template. No config page
(`configure` null), no permissions, no Drush, no plugin types defined. Depends only on core
(implicitly `text`/`filter` for text formats). OpenEuropa package.

- **The field type (columns, properties), default widget, default formatter, theme hook, and TMGMT
  processor — how to create and render the field** → [api/field.md](api/field.md)

Key facts:
- Field type id `description_list_field`; columns `term` (text big), `description` (text big),
  `format` (varchar 255, indexed). Default widget `description_list_widget`, default formatter
  `description_list_formatter`.
- Computed property `description_processed` (`\Drupal\text\TextProcessed`) exposes the
  format-applied description.
- Theme hook `description_list` → `templates/description-list.html.twig` (`<dl><dt>/<dd>`).
- Term is rendered `#plain_text`; description as `#type => processed_text` with its stored format.
