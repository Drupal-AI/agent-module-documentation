<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# React to a merge — the `term_merge.terms_merged` event

Term Merge invites no hooks (there is no `term_merge.api.php`). The single supported
extension point is a Symfony event.

## The constant and the event class

```php
Drupal\term_merge\TermMergeEventNames::TERMS_MERGED === 'term_merge.terms_merged';
```

```php
class TermsMergedEvent extends \Drupal\Component\EventDispatcher\Event {
  public function getSourceTerms(): array;        // TermInterface[] about to be deleted
  public function getTargetTerm(): TermInterface; // the survivor (already saved)
}
```

## Timing — this matters

`TermMerger::mergeIntoTerm()` dispatches the event **after** references have been migrated but
**before** `$termStorage->delete($terms_to_merge)`. So inside a subscriber:

- the source terms are still loadable and still have their labels/fields,
- entities have **already** been re-pointed at the target term,
- the target term already has an id (it is saved first if it was new).

Anything you need from a source term must be read now — it will not exist afterwards.

## A subscriber

```php
// src/EventSubscriber/TermMergeSubscriber.php
namespace Drupal\mymodule\EventSubscriber;

use Drupal\term_merge\TermMergeEventNames;
use Drupal\term_merge\TermsMergedEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class TermMergeSubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return [TermMergeEventNames::TERMS_MERGED => ['onTermsMerged', 0]];
  }

  public function onTermsMerged(TermsMergedEvent $event): void {
    $target = $event->getTargetTerm();
    foreach ($event->getSourceTerms() as $source) {
      \Drupal::logger('mymodule')->notice('Merged @from (@tid) into @to', [
        '@from' => $source->label(),
        '@tid' => $source->id(),
        '@to' => $target->label(),
      ]);
    }
  }

}
```

```yaml
# mymodule.services.yml
services:
  mymodule.term_merge_subscriber:
    class: Drupal\mymodule\EventSubscriber\TermMergeSubscriber
    tags:
      - { name: event_subscriber }
```

Typical uses: write an audit log, record a redirect from the old term path to the new one,
push the change to an external taxonomy/search index, or copy fields off the dying terms onto
the survivor (the Synonyms integration in `MergeTermsConfirm` does exactly that, but in the
form rather than in a subscriber).

## The other seam: `hook_form_alter()`

`MergeTermsConfirm::submitForm()` stores the surviving tid as
`$form_state->set('destination_tid', $tid)`, explicitly so `hook_form_alter()` implementations
on form id `taxonomy_merge_terms_confirm` can read it. Use the event for anything
non-UI — it also fires for programmatic merges, which the form alter does not.
