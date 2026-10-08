# Permissions — AJAX Quiz

Defined in `ajax_quiz.permissions.yml`.

| Permission | Description | Notes |
|---|---|---|
| `access ajax quiz` | "Allowed to take a quiz with ajax." | Gates the whole feature. Without it, the standard (non-AJAX) quiz flow is used; with it, the answering/report forms get the AJAX wrapper and callback. |

This is the module's only surface — it defines no other permission and no configuration. Grant
it to the roles that should get the AJAX experience.

```php
// Grant to authenticated users.
$r = \Drupal\user\Entity\Role::load('authenticated');
$r->grantPermission('access ajax quiz');
$r->save();
```

```bash
drush php:eval '$r=\Drupal\user\Entity\Role::load("authenticated");var_export($r->hasPermission("access ajax quiz"));'
```
