<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PasswordStrengthMatcher plugin type

The module defines an annotation-based plugin type for zxcvbn "matchers" — algorithms that
detect a weak-password characteristic and lower the entropy/score.

- **Plugin manager service:** `plugin.manager.password_strength.password_strength_matcher`
  (class `Drupal\password_strength\PasswordStrengthMatcherPluginManager`).
- **Discovery directory:** `Plugin/PasswordStrengthMatcher` in any module's `src/`.
- **Annotation:** `@PasswordStrengthMatcher` (`Drupal\password_strength\Annotation\PasswordStrengthMatcher`) — fields `id`, `title`, `description`.
- **Interface expected:** `Drupal\password_strength\PasswordStrengthMatcherInterface`.
- **Alter hook:** `hook_password_policy_password_strength_matcher_info_alter()`.
- **Cache key:** `password_strength_matcher`.

The manager's `findDefinitions()` merges discovered plugins with the eight built-in zxcvbn
library matchers (ids `zxcvbn_datematch`, `zxcvbn_digitmatch`, `zxcvbn_l33tmatch`,
`zxcvbn_repeatmatch`, `zxcvbn_sequencematch`, `zxcvbn_spatialmatch`, `zxcvbn_yearmatch`,
`zxcvbn_dictionarymatch`), each mapped to a `ZxcvbnPhp\Matchers\*` class. Which of these run
is gated by `password_strength.settings:enabled_matchers`
(see [../configure/matcher-settings.md](../configure/matcher-settings.md)).

## Note on the constraint plugin

The site-facing feature — the **`password_strength_constraint`** — is *not* a matcher plugin.
It is a `password_policy` **PasswordConstraint** plugin
(`src/Plugin/PasswordConstraint/PasswordStrength.php`, extending
`Drupal\password_policy\PasswordConstraintBase`). Its `validate()` builds the user's account
name + email as zxcvbn user-inputs, calls `PasswordStrength::passwordStrength()`, and fails
when `score < strength_score`. To configure it, see
[../configure/password-policy.md](../configure/password-policy.md); to score in code, see
[../api/strength.md](../api/strength.md).

## Skeleton custom matcher

```php
// mymodule/src/Plugin/PasswordStrengthMatcher/MyMatcher.php
namespace Drupal\mymodule\Plugin\PasswordStrengthMatcher;

/**
 * @PasswordStrengthMatcher(
 *   id = "my_matcher",
 *   title = @Translation("My matcher"),
 *   description = @Translation("Detects a custom weak pattern."),
 * )
 */
class MyMatcher extends \ZxcvbnPhp\Matchers\Match {
  public static function match($password, array $userInputs = []) {
    // Return an array of Match objects for detected patterns.
    return [];
  }
}
```
