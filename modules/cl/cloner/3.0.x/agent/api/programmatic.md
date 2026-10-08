<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Calling clone plugins directly from code

`@ClonerContentEntity` and `@ClonerConfigEntity` plugins are standalone — you can invoke them
anywhere without a `@ClonerForm` or the generated route. Use the matching plugin manager service:

- `plugin.manager.cloner.content_entity` — content entity cloners.
- `plugin.manager.cloner.config_entity` — config entity cloners.

You are responsible for the duplicate and the save (the clone form does this for you, but here you do
it manually):

```php
/** @var \Drupal\cloner\Plugin\ClonerPluginManager $manager */
$manager = \Drupal::service('plugin.manager.cloner.content_entity');

/** @var \Drupal\cloner\Plugin\Cloner\ContentEntity\ClonerContentEntityClonePluginBaseInterface $plugin */
$plugin = $manager->createInstance('cloner_examples_node_article');

$node_cloned = $node->createDuplicate();   // you create the duplicate
$plugin->cloneEntity($node, $node_cloned); // optional 3rd arg: $context array
$node_cloned->save();                      // you save it

// e.g. redirect to the new entity
$form_state->setRedirect(
  $node_cloned->toUrl()->getRouteName(),
  $node_cloned->toUrl()->getRouteParameters(),
);
```

Notes:
- `cloneEntity(EntityInterface $source, EntityInterface $destination, array $context = [])` — the
  plugin only mutates `$destination`; it neither duplicates nor saves. Pass your own `$context` if
  the plugin expects it (the clone form passes `['form_state' => $form_state]`).
- For **config entities**, remember your `cloneEntity()` must set a new unique id on the destination
  (config ids are strings); the config base plugin's `getDefinitionKey()` helps find the id/label
  keys.
- `createInstance()` on these managers supports DI (services injected via the plugin's `create()`).
- Programmatic invocation bypasses the module's route/permission check entirely — enforce whatever
  access is appropriate at your call site (e.g. the examples submodule's node button gates on
  `access all entity cloner || access node cloner` and is only added to a form the user can already
  edit). See [../architecture/clone-flow.md](../architecture/clone-flow.md).
