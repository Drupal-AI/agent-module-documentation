# Work with recurrence rules in code

Service `smart_date_recur.manager` (`SmartDateRecurManager`) plus the `smart_date_rule`
entity storage (`RuleStorage`, implements `RuleStorageInterface`).

```php
$storage = \Drupal::entityTypeManager()->getStorage('smart_date_rule');
$rule = $storage->load($rrule_id);          // SmartDateRule

$rule->getRule();                            // RRULE string
$rule->getAssembledRule();                   // recurr Rule object (simshaun/recurr)
$rule->getRuleInstances($range = []);        // all instances (with overrides applied)
$rule->getStoredInstances();                 // materialized instances
$rule->getNewInstances();                    // instances not yet stored
$rule->getRuleOverrides();                   // SmartDateOverride[] keyed by index
$rule->makeRuleInstances();                  // (re)generate instances from the RRULE
$rule->getParentEntity();                    // host entity the rule belongs to
```

- Recurrence expansion uses `simshaun/recurr`; `getAssembledRule()` returns its `Rule`.
- Overrides are `smart_date_override` entities keyed by instance index; a rescheduled or
  cancelled instance is an override, leaving the base RRULE intact.
- The `RecurRuleUpdate` queue worker calls into the manager to keep future instances fresh.
