<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UI Patterns source: `fieldgroup`

`src/Plugin/UiPatterns/Source/FieldgroupSource.php`

```php
@UiPatternsSource(
  id = "fieldgroup",
  label = @Translation("Fieldgroups"),
  provider = "field_group",
  tags = { "entity_display" }
)
```

`class FieldgroupSource extends PatternSourceBase` (from `ui_patterns`). It makes **field groups
available as pattern sources** wherever UI Patterns builds a display-context mapping (tag
`entity_display`). That is what lets one pattern map a whole field group's rendered output — or the
group's label — into one of its slots (and is the source list the `pattern_formatter` settings form
draws on, limited to a group's own children).

## `getSourceFields()`

Reads the display context and enumerates groups, returning one `PatternSourceField` per group plus a
label source:

```php
$entity_type_id = $this->getContextProperty('entity_type');
$bundle         = $this->getContextProperty('entity_bundle');
$view_mode      = $this->getContextProperty('entity_view_mode');

$groups = field_group_info_groups($entity_type_id, $bundle, 'view', $view_mode);

foreach ($groups as $group_name => $group) {
  if (empty($this->getContextProperty('limit'))
      || in_array($group_name, $this->getContextProperty('limit'))) {
    $sources[] = $this->getSourceField($group_name, $group->label);
  }
}
$sources[] = $this->getSourceField('_label', 'Group label');   // the special label source
```

- Uses core `field_group_info_groups(..., 'view', $view_mode)` — **view** context only.
- Honors an optional `limit` context property (a list of group machine names) to restrict which
  groups are offered. The `pattern_formatter` form passes the group's children as `limit`.
- Always appends a `_label` / "Group label" source — this is the `_label` handled specially in
  `PatternFormatter::preRenderGroup()`.
