# Programmatic API — `context.manager`

Service `context.manager` (`Drupal\context\ContextManager`). Evaluates every `context`
entity against the current request and exposes the active contexts/reactions. (Not to be
confused with Drupal core's own context system.)

```php
/** @var \Drupal\context\ContextManager $cm */
$cm = \Drupal::service('context.manager');

// All context entities (sorted by weight):
$cm->getContexts();                 // ContextInterface[] keyed by id
$cm->getContext('my_context');      // one (supports '*' wildcard match)
$cm->getContextsByGroup();          // grouped by ->getGroup()
$cm->contextExists('my_context');   // bool

// Evaluate conditions and get the active ones:
$cm->getActiveContexts();           // ContextInterface[] whose conditions pass and not disabled
$cm->conditionsHasBeenEvaluated();  // bool

// The main hook used by integrations — get active reactions:
$cm->getActiveReactions();              // ALL active reactions across active contexts
$cm->getActiveReactions('body_class');  // by reaction plugin id
$cm->getActiveReactions(\Drupal\context\Plugin\ContextReaction\Blocks::class); // by class
```

`getActiveReactions($type)` accepts a reaction **plugin id** (e.g. `'blocks'`, `'theme'`,
`'page_title'`) or a **class name**, or `NULL` for all. Each returned object is a
`ContextReactionInterface`; call `->execute()` (and `->getConfiguration()`) on it. This is
exactly how the module's own hooks apply reactions — e.g. `context_preprocess_html()` does
`foreach ($cm->getActiveReactions('body_class') as $r) { ... $r->execute(); }`.

## Working with a context entity in code

```php
use Drupal\context\Entity\Context;

$context = Context::load('my_context');   // or ::create([...])
$context->addCondition(['id' => 'request_path', 'pages' => '/blog/*']);
$context->addReaction(['id' => 'body_class', 'body_class' => 'is-blog']);
$context->setRequireAllConditions(TRUE);
$context->save();

$context->getConditions();  // ConditionPluginCollection (core)
$context->getReactions();   // ContextReactionPluginCollection
$context->hasReaction('blocks');
```

Related services: `context.repository`/`context.handler` (core context plumbing used to apply
context-aware conditions), `theme.negotiator.context_themeswitcher` (theme reaction), and the
`BlockPageDisplayVariantSubscriber` event subscriber (blocks reaction).
