# ECA Flag condition

Source: `src/Plugin/ECA/Condition/IsFlagged.php`.
One ECA condition `#[EcaCondition(id: 'eca_flag_entity_is_flagged', label: 'Flag: entity flagged')]`,
extends `ConditionBase`. "Performs a lookup whether an entity is flagged."

All other flag checks the maintainers expect you to do with ECA's generic **Compare two scalar
values** condition using tokens taken from the flag/flagging entities — this is the only bespoke
condition.

## Config

| Key | Widget | Notes |
|---|---|---|
| `flag_name` | `select`, required | Options are all flags (`FlagService::getAllFlags()`), keyed by flag id. Stored value is the flag id. |

Schema `eca.condition.plugin.eca_flag_entity_is_flagged` (`flag_name: string`) plus ECA's base
condition mapping (which supplies the standard `negate` flag).

## Context

- `entity` — a `ContextDefinition('entity')`. Bind the entity to test to this context in the model.

## How it evaluates

```php
$entity = $this->getValueFromContext('entity');
$flagName = $this->configuration['flag_name'];
if (!empty($flagName)) {
  $flagName = $this->tokenService->replaceClear($flagName);   // token support
}
$flag = $this->flagService->getFlagById($flagName);
return $this->negationCheck($flag->isFlagged($entity));       // Flag's own lookup
```

- Returns `FALSE` (through `negationCheck`) if there is no entity, no `flag_name`, or the flag id does
  not resolve.
- `flag_name` is run through `tokenService->replaceClear()`, so a token (e.g. `[flag:id]`) can select
  the flag dynamically even though the form is a plain select.
- The result passes through ECA's `negationCheck()`, so the standard "negate" option inverts it.
- `isFlagged()` is Flag's global "does any flagging exist for this entity" check (not scoped to a
  particular user).
