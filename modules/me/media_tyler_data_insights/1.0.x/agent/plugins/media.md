<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media source, formatter & constraint

The module ships plugin **implementations** (it does not define new plugin types). Three plugins do
the work.

## Media source: `media_tylerdi`

`Plugin/media/Source/TylerDataInsightsSource` (`@MediaSource id = "media_tylerdi"`, label
"Tyler Data & Insights"). Key traits:

- `allowed_field_types = {"string_long"}` — the source field stores the raw embed snippet.
- `getMetadataAttributes()` returns `[]` (no extracted metadata).
- `getSourceFieldConstraints()` attaches the `media_tyler_data_insights` validation constraint.
- `default_thumbnail_filename = "generic.png"`.
- Provides a `media_library_add` form (`Form/MediaForm`, extends media_library `AddFormBase`) with an
  "Embed Code" textarea so editors paste the snippet directly in the Media Library.

### Create a media type using it

UI: *Structure → Media types → Add media type*, set **Media source = "Tyler Data & Insights"**, save
(this auto-creates the `string_long` source field). Then grant the relevant core Media permissions
(create/edit) for the new type. Scriptable:

```php
$type = \Drupal\media\Entity\MediaType::create([
  'id' => 'tyler_di', 'label' => 'Tyler Data & Insights', 'source' => 'media_tylerdi',
]);
$type->save();
$field = $type->getSource()->createSourceField($type);
$field->getFieldStorageDefinition()->save();
$field->save();
$type->set('source_configuration', ['source_field' => $field->getName()])->save();
```

## Field formatter: `media_tyler_data_insights`

`Plugin/Field/FieldFormatter/MediaTylerDataInsightsFormatter` (label "Tyler Data & Insights embed",
for `string_long` fields). Loads the snippet HTML, extracts the first iframe's `src` via XPath, and
renders `#theme => 'media_tyler_data_insights'` (template `media-tyler-data-insights.html.twig`,
variables `url`, `title`, `width`, `height`). Settings: `width` (default `100%`) and `height`
(default `400px`), any valid CSS unit. Set it as the display formatter for the source field on the
media type's *Manage display*.

## Validation constraint: `media_tyler_data_insights`

`Plugin/Validation/Constraint/MediaTylerDataInsightsConstraint` + validator. Applied to the source
field; rejects a value unless it contains exactly one iframe whose path matches `/^\/(w|stories)\//`
and whose host is present in `media_tyler_data_insights.settings.allowed_hosts`
(see [../configure/allowed-hosts.md](../configure/allowed-hosts.md)). Two messages:
`invalidEmbedCodeMessage` and `invalidHostMessage`.

## Theme hook

`hook_theme()` registers `media_tyler_data_insights` with variables `url`, `title`, `width`,
`height`, rendered by `templates/media-tyler-data-insights.html.twig` (the iframe wrapper).
