# Programmatic API — entities & services

## Entities

| Entity type | Class | Kind | Key |
|---|---|---|---|
| `tmgmt_job` | `Drupal\tmgmt\Entity\Job` | content (`base_table: tmgmt_job`) | `tjid` |
| `tmgmt_job_item` | `Drupal\tmgmt\Entity\JobItem` | content (`base_table: tmgmt_job_item`) | `tjiid` |
| `tmgmt_message` | `Drupal\tmgmt\Entity\Message` | content (`base_table: tmgmt_message`) | log entry |
| `tmgmt_remote` | `Drupal\tmgmt\Entity\RemoteMapping` | content (`base_table: tmgmt_remote`) | local↔remote map |
| `tmgmt_translator` | `Drupal\tmgmt\Entity\Translator` | config (`config_prefix: translator`) | `name` |

## Create a job and add items in code

```php
use Drupal\tmgmt\Entity\Job;

$job = Job::create([
  'source_language' => 'en',
  'target_language' => 'de',
  'translator' => 'my_provider',   // a tmgmt_translator config entity id
]);
$job->save();

// Add a source thing to translate (plugin id, item type, item id):
$item = $job->addItem('content', 'node', 1);   // returns a tmgmt_job_item

// Request translation through the assigned provider:
if ($job->canRequestTranslation()->getSuccess()) {
  $job->requestTranslation();      // hands data to the translator plugin
}
```

Useful `Job` methods: `addItem()`, `getItems()`, `requestTranslation()`, `submitted()`,
`finished()`, `aborted()`, `getData()`, `addTranslatedData()`, `getState()`,
`getTranslatorPlugin()`, `getSourceLanguage()`/`getTargetLanguage()`, `addMessage()`.
`JobItem`: `acceptTranslation()`, `getData()`, `getSourcePlugin()`, `getCountAccepted()`,
`getCountPending()`, `active()`/`needsReview()`/`accepted()`.

## Core services

| Service | Class | Use |
|---|---|---|
| `tmgmt.data` | `Data` | Flatten/unflatten job data, `filterTranslatable()`, `wordCount()`, `itemLabel()`, file-translation helpers |
| `tmgmt.job_checkout_manager` | `JobCheckoutManager` | `checkoutAndRedirect()`, `checkoutMultiple()`, `requestTranslationMultiple()`, `needsCheckoutForm()` — drives the multi-job checkout/submit flow |
| `tmgmt.queue` | `JobQueue` | Ordered queue of jobs during checkout |
| `tmgmt.cart` | `JobItemCart` | The translation cart |
| `tmgmt.continuous` | `ContinuousManager` | Continuous-job collection on cron |
| `tmgmt.language_matcher` | `LanguageMatcher` | Match source/target langcodes |
| `tmgmt.segmenter` | `NullSegmenter` (`SegmenterInterface`) | Segment text (overridable) |
| `plugin.manager.tmgmt.translator` | `TranslatorManager` | Discover/instantiate provider plugins |
| `plugin.manager.tmgmt.source` | `SourceManager` | Discover/instantiate source plugins |

```php
/** @var \Drupal\tmgmt\Data $data */
$data = \Drupal::service('tmgmt.data');
$flat = $data->filterTranslatable($job->getData());   // only #translate items
$words = $data->wordCount($text);
```

`RemoteMapping::loadByLocalData($tjid, $tjiid, $key)` looks up the remote reference a provider
stored for a job/item — used by async providers to correlate callbacks.
