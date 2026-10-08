# Hooks (auto_entitylabel.api.php)

## Enable auto-label for an entity type
Auto-label attaches to bundle config entities that have an `auto-label` link template. Add it
in `hook_entity_type_alter()` for types the module doesn't already cover (it auto-adds it to
any bundle entity type with an `edit-form` template):
```php
function mymodule_entity_type_alter(array &$entity_types) {
  foreach ($entity_types as $entity_type) {
    if ($entity_type->getProvider() === 'eck' && $entity_type->getBundleOf()) {
      $entity_type->setLinkTemplate(
        'auto-label',
        $entity_type->getLinkTemplate('edit-form') . '/auto-label'
      );
    }
  }
}
```

## Add token types to the settings form
```php
function mymodule_form_auto_entitylabel_settings_form_alter(&$form, $form_state, $form_id) {
  if (\Drupal::routeMatch()->getRawParameters()->has('MYTYPE')) {
    $form['auto_entitylabel']['token_help']['#token_types'][] = 'MYTYPE';
  }
}
```

## Post-process a generated label
Invoked from `AutoEntityLabelManager::generateLabel()`:
```php
function mymodule_auto_entitylabel_label_alter(&$label, $entity) {
  $label = trim($label);
}
```
