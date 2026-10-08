# tourauto.manager service API

Service `tourauto.manager` (`Drupal\tourauto\TourautoManager`, autowired; alias by class
name). It manages tourauto data for the **current** user by default. All tour/user-data
access uses `accessCheck(FALSE)` internally except `getCurrentTours()`, which enforces the
`access tour` permission.

```php
$manager = \Drupal::service('tourauto.manager');
```

| Method | Returns | Purpose |
|---|---|---|
| `tourautoEnabled()` | `bool` | Whether auto-open is on for the user (default TRUE if never set; FALSE for anonymous). |
| `setTourautoPreference(bool $preference)` | `void` | Save the `tourauto_enable` preference. |
| `getCurrentTours()` | `array` | Tours matching the current route, keyed by tour id → tip id → tip configuration. Returns `[]` without `access tour`. |
| `getSeenTours()` | `string[]` | Tour ids the user has already seen. |
| `markToursSeen(array $tours)` | `void` | Add tour ids to the user's seen state. |
| `clearState()` | `void` | Delete the user's seen state (all tours become unseen). |
| `getManagerForAccount(AccountInterface $account)` | `TourautoManager` | A new manager instance scoped to another account (e.g. the user being edited). |
| `translate(string $string)` | `TranslatableMarkup` | Translate a runtime string. |

Constructor dependencies: `current_user`, `user.data`, `current_route_match`,
`entity_type.manager`, and Tour's `tour.helper` service.

Example — mark all current-route tours as seen for a user without showing them:

```php
$manager = \Drupal::service('tourauto.manager')->getManagerForAccount($account);
$manager->markToursSeen(array_keys($manager->getCurrentTours()));
```
