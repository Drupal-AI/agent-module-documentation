<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin type: AiContextScope

A scope is a **dimension** that can be attributed to context items so the selector can decide
which items apply to a given agent, route, entity, or language.

| Facet | Value |
|---|---|
| Attribute | `#[\Drupal\ai_context\Attribute\AiContextScope]` (`src/Attribute/AiContextScope.php`) |
| Namespace | `Drupal\<module>\Plugin\AiContextScope` |
| Interface | `Plugin\AiContextScope\AiContextScopeInterface` |
| Base class | `Plugin\AiContextScope\AiContextScopeBase` |
| Manager | service `plugin.manager.ai_context_scope` = `AiContextScopeManager` |
| Discovery cache | `ai_context_scope_plugins`; alter hook `ai_context_scope_info` |

## Attribute parameters

`id` (string), `label` (`TranslatableMarkup`), `description` (`?TranslatableMarkup`),
`weight` (int, default 1 — higher sorts first and scores stronger), `deriver` (`?class-string`),
`icon_class` (`?string`, CSS class for the UI icon).

## Key interface methods (`AiContextScopeInterface`)

- `getValues(): array` / `getAlteredValues(): array` — the `value_id => label` options this scope
  offers (altered version runs `hook_ai_context_scope_values_alter`).
- `getValuesFromEntity(AiContextItem $item): array` — the values stored on an item.
- `matchesCurrentContext(AiContextItem $item): ?bool` — does the item match the current
  route/entity/language? (`null` = not applicable.)
- `allowsMultiple()`, `isDynamic()`, `supportsSubscriptions()`, `isEnabled()`, `getWeight()`.
- `getConfigName()` (its `ai_context.scope_settings.<id>` object), `defaultConfiguration()`,
  and `buildSettingsForm()/validateSettingsForm()/submitSettingsForm()` for the per-scope tab.
- `buildValueForm()`, `extractFormValues()`, `getCurrentValue()`,
  `getSelectedValueLabels()` for the item/subscription forms.

`AiContextScopeBase` implements most of these; subclass it and override what differs. Shipped
implementations are a good template: `AiContextScopeGlobal`, `AiContextScopeUseCase`,
`AiContextScopeLanguage`, `AiContextScopeTag`, `AiContextScopeSiteSection`, `AiContextScopeTaxonomy`,
`AiContextScopeEntityType`, `AiContextScopeEntityItem`.

## Add a scope

```php
namespace Drupal\my_module\Plugin\AiContextScope;

use Drupal\ai_context\Attribute\AiContextScope;
use Drupal\ai_context\Plugin\AiContextScope\AiContextScopeBase;
use Drupal\Core\StringTranslation\TranslatableMarkup;

#[AiContextScope(
  id: 'department',
  label: new TranslatableMarkup('Department'),
  description: new TranslatableMarkup('Match context to an org department.'),
  weight: 5,
  icon_class: 'ai-icon--scope-department',
)]
final class AiContextScopeDepartment extends AiContextScopeBase {

  public function getValues(): array {
    return ['sales' => 'Sales', 'support' => 'Support'];
  }

  public function matchesCurrentContext($item): ?bool {
    // Return TRUE/FALSE to include/exclude, or NULL if not applicable here.
    return NULL;
  }
}
```

A new scope automatically gains a settings tab and (when `supportsSubscriptions()` is TRUE) appears
in agent subscription forms via `Service\AiContextScopeSubscriptionFormBuilder`. To hide a scope
conditionally, implement `hook_ai_context_scope_info_alter` — see
[../hooks/hooks.md](../hooks/hooks.md).
