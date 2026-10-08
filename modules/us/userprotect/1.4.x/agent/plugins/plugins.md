# The `user_protection` plugin type

User Protect defines one plugin type, declared in `userprotect.plugin_type.yml`:

- **Plugin type id:** `user_protection`
- **Manager service:** `plugin.manager.userprotect.user_protection`
  (`Drupal\userprotect\Plugin\UserProtection\UserProtectionManager`, extends `DefaultPluginManager`)
- **Plugin namespace:** `Plugin/UserProtection` (i.e. `Drupal\{module}\Plugin\UserProtection\…`)
- **Interface:** `Drupal\userprotect\Plugin\UserProtection\UserProtectionInterface`
- **Base class:** `Drupal\userprotect\Plugin\UserProtection\UserProtectionBase`
- **Discovery:** attribute `Drupal\userprotect\Attribute\UserProtection` (Drupal ≥ 10.2), with an
  annotation fallback `Drupal\userprotect\Annotation\UserProtection`
- **Alter hook:** `hook_user_protection_info_alter()` (alter id `user_protection_info`)
- Access via the wrapper `Drupal\userprotect\UserProtect::pluginManager()`.

Each protection is one operation/field on a user. A protection defines `id`, `label`,
`description`, `weight`, and default `status`; it implements `isProtected($user, $op, $account)`
and `applyAccountFormProtection(&$form, $form_state)` (disables/hides the relevant form element).

## Shipped protections

| Plugin id | Label | Protects |
|---|---|---|
| `user_name` | Username | The user's name field |
| `user_mail` | Email address | The user's mail field |
| `user_pass` | Password | The user's password field |
| `user_status` | Status | The active/blocked status field |
| `user_roles` | Roles | The roles field (also covers Role Delegation's `role_change`) |
| `user_edit` | Edit operation | `user/X/edit` (the `update` entity op) |
| `user_delete` | Cancel operation | `user/X/cancel` (the `delete` entity op) |

## Add a custom protection

Create `Plugin/UserProtection/MyProtection.php` in your module with the attribute and extend
`UserProtectionBase`:

```php
use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\userprotect\Attribute\UserProtection;
use Drupal\userprotect\Plugin\UserProtection\UserProtectionBase;

#[UserProtection(
  id: 'my_protection',
  label: new TranslatableMarkup('My protection'),
  weight: 0,
  status: FALSE,
)]
class MyProtection extends UserProtectionBase {

  public function isProtected(UserInterface $user, $op, AccountInterface $account) {
    // Return TRUE to block $op on $user.
  }

  public function applyAccountFormProtection(array &$form, FormStateInterface $form_state) {
    // Disable/hide the protected form element; return TRUE if applied.
  }
}
```

The new protection then becomes selectable when creating/editing a `userprotect_rule`.
