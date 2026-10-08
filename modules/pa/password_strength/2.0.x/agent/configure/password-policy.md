<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add the Password Strength constraint to a Password Policy

password_strength registers exactly one `password_policy` constraint plugin:

- **Plugin id:** `password_strength_constraint`
- **Setting:** `strength_score` — integer `0`–`4` (0 = very weak … 4 = very strong).
  Default `3`. This is the *minimum* score a password must reach to pass.

The constraint lives inside a **Password Policy** config entity
(`password_policy.password_policy.<id>`); password_strength has no config UI of its own for it.

## Via the UI

1. Go to **Admin → Config → Security → Password Policy**
   (`/admin/config/security/password-policy`), add or edit a policy.
2. On the *Constraints* step, choose **Password Strength**, click *Configure Constraint
   Settings*, pick the minimum score, save.
3. Assign the policy to one or more roles and finish the wizard.

## Config entity shape

A saved policy stores the constraint in the `policy_constraints` sequence:

```yaml
# password_policy.password_policy.strong_password.yml
id: strong_password
label: 'Strong Password'
password_reset: 0
send_reset_email: false
policy_constraints:
  - id: password_strength_constraint
    strength_score: 4
roles:
  authenticated: authenticated
show_policy_table: true
```

`strength_score` is validated by this module's schema
(`password_policy.constraint.plugin.password_strength_constraint`).

## Create the policy in code / Drush

```php
\Drupal::entityTypeManager()->getStorage('password_policy')->create([
  'id' => 'strong_password',
  'label' => 'Strong Password',
  'password_reset' => 0,
  'policy_constraints' => [
    ['id' => 'password_strength_constraint', 'strength_score' => 4],
  ],
  'roles' => ['authenticated' => 'authenticated'],
])->save();
```

Run it with `drush php:eval '...'`. Read a policy's constraints back with
`->getConstraints()` on the loaded `password_policy` entity, or
`drush config:get password_policy.password_policy.strong_password`.

Apply **different thresholds per role** by creating multiple policies (e.g. score 4 for an
admin policy, score 2 for authenticated users).
