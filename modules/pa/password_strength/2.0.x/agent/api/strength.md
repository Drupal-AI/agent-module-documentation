<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Score a password in code

`Drupal\password_strength\PasswordStrength` wraps the zxcvbn-php estimator.

```php
use Drupal\password_strength\PasswordStrength;

$estimator = new PasswordStrength();          // constructs a ZxcvbnPhp\Zxcvbn internally
$result = $estimator->passwordStrength($password, $userInputs);
//        ^ $userInputs is an optional array of strings to penalise (e.g. username, email)

$score   = $result['score'];    // int 0–4 (this is what the policy constraint compares)
$entropy = $result['entropy'];  // float bits of entropy
$matches = $result['match_sequence'];
```

The returned array has keys `password`, `entropy`, `match_sequence`, `score`. The
`password_strength_constraint` uses exactly this: it fails validation when
`$result['score'] < $configuration['strength_score']`, passing the account name and email as
`$userInputs` so a user cannot use their own identifiers as a password.

Notes:
- `PasswordStrength` is a plain class, `new`-instantiated (not a container service).
- Which matchers zxcvbn applies is a library-level concern here; the site-wide
  `enabled_matchers` toggle is consulted by the module's own `Matcher` helper /
  plugin manager, not by this raw estimator call — see
  [../plugins/matchers.md](../plugins/matchers.md) and
  [../configure/matcher-settings.md](../configure/matcher-settings.md).
- To *enforce* a score, add the constraint to a Password Policy rather than calling this
  directly — see [../configure/password-policy.md](../configure/password-policy.md).
