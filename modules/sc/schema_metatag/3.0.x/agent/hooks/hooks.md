# Hooks (schema_metatag.api.php)

Two alter hooks let you retune schema tags without subclassing.

## hook_metatag_tags_alter(&$definitions)
Adjust individual Schema Metatag tag definitions (Metatag's own hook, extended with schema keys
`property_type`, `tree_parent`, `tree_depth`, `multiple`).
```php
function mymodule_metatag_tags_alter(array &$definitions) {
  // Restrict Schema Service @type options to GovernmentService only.
  $definitions['schema_service_type']['property_type'] = 'type';
  $definitions['schema_service_type']['tree_parent'] = ['GovernmentService'];
  $definitions['schema_service_type']['tree_depth'] = 0;

  // Make Recipe instructions use the HowToStep property type, multi-value.
  $definitions['schema_recipe_recipe_instructions']['property_type'] = 'how_to_step';
  $definitions['schema_recipe_recipe_instructions']['multiple'] = TRUE;
}
```

## hook_schema_metatag_property_type_plugins_alter(&$definitions)
Alter the `@SchemaPropertyType` plugin definitions globally.
```php
function mymodule_schema_metatag_property_type_plugins_alter(array &$definitions) {
  // Use plain Text for Place instead of PostalAddress + GeoCoordinates.
  $definitions['place']['property_type'] = 'Text';
  $definitions['place']['sub_properties'] = [];

  // Add an author sub-property to everything using CreativeWork.
  $definitions['creative_work']['sub_properties'] += [
    'author' => ['id' => 'person', 'label' => t('author'), 'tree_parent' => ['Person'], 'tree_depth' => 0],
  ];
}
```
