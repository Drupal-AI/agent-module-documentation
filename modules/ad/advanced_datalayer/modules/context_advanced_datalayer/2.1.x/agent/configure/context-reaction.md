# The `context_advanced_datalayer` Context reaction

## What it is

A Context **reaction** plugin (`@ContextReaction(id = "context_advanced_datalayer")`). You add
it to a Context (alongside conditions like path/role) at *Structure → Context*. Its config form
is the Advanced Datalayer tag-value form (`advanced_datalayer.manager->form($values, [], TRUE, [], [], TRUE)`),
so you fill in values for the datalayer tags. Whichever Contexts are **active** on a request
contribute their tag values to the pushed dataLayer.

## Where the values live

Stored in the Context config entity:

```yaml
# config: context.context.<name>
reactions:
  context_advanced_datalayer:
    id: context_advanced_datalayer
    <tag_id>: '<value>'      # e.g. site_Name: 'ACME'
    # ...
```

Read it back:

```bash
drush cget context.context.<name> reactions.context_advanced_datalayer
```

## How values reach the dataLayer

`context_advanced_datalayer_advanced_datalayer_alter(&$tags, $context)`
(`hook_advanced_datalayer_alter`) runs while Advanced Datalayer builds the page's dataLayer:

```php
foreach (\Drupal::service('context.manager')
    ->getActiveReactions('context_advanced_datalayer') as $reaction) {
  $data = array_filter($reaction->execute());   // the tag_id => value map
  unset($data['id']);
  foreach ($data as $key => $value) {
    $tags[$key] = $value;                        // merged into the dataLayer
  }
}
```

So values from every Context whose conditions match are merged in (later ones win on key
clash). The module's install weight (1000) ensures this hook runs after Context has evaluated.

## Build one in code (scriptable)

```php
use Drupal\context\Entity\Context;

$c = Context::create(['name' => 'promo', 'label' => 'Promo']);
$c->save();
// (add conditions with $c->addCondition([...]) as needed)
$c->addReaction(['id' => 'context_advanced_datalayer', 'site_Category' => 'promo']);
$c->save();
```

## Requirements

Needs both `context` and `advanced_datalayer` enabled, and datalayer **tags** to exist (the
base module ships none — enable `example_advanced_datalayer` or provide your own). The reaction
only sets values for tags the tag plugin manager knows about.
