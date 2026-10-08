# Service: `simple_account_policy`

Class `Drupal\simple_account_policy\AccountPolicy` implementing `AccountPolicyInterface`.
Constructor args: `@config.factory`, `@database`, `@state`, `@event_dispatcher`, `@renderer`.
Get it with `\Drupal::service('simple_account_policy')` or inject the id `simple_account_policy`.

## Public methods (`AccountPolicyInterface`)

| Method | Returns | Purpose |
|---|---|---|
| `applyPolicy(UserInterface $user)` | `bool` | Whether the policy applies. FALSE if user has `bypass account policy`, name matches `username_ignore_patterns`, or user is anonymous. |
| `validate(UserInterface $user, array $data = [])` | `array` | Format-rule violations keyed `mail`/`name` (each an array of rule ids). `$data` may supply `mail`/`name` to test proposed values. |
| `policy(?UserInterface $user, array $errors = [])` | `array` | Human-readable rule descriptions for the `name`/`mail` fields (rendered markup); marks failing rules using `$errors`. |
| `getBlockTime(UserInterface $user)` | `int` | Timestamp at which the user becomes inactive (from last-access + `inactive_period`). 0 if disabled. |
| `getWarningTime(UserInterface $user)` | `int` | Timestamp to warn before block (block time − `inactive_warning`). |
| `getDeleteAfterTime()` | `int` | Cutoff timestamp; accounts last-accessed before it are deletable. |
| `inactiveInterval()` | `int` | `inactive_interval` seconds (default 86400) — cron sweep throttle. |
| `isInactive(UserInterface $user)` | `bool` | TRUE if active AND now past `getBlockTime()`. |
| `shouldIssueWarning(UserInterface $user)` | `bool` | TRUE if within warning window and not already warned. |
| `warningIssued(UserInterface $user)` | `bool` | Whether a warning was already recorded (state `simple_account_policy.warned_users`). |
| `issueWarning(UserInterface $user)` | `void` | Record the warning and dispatch `AccountPolicyWarningEvent`. |
| `shouldBeDeleted(UserInterface $user)` | `bool` | TRUE if last-access (or created time) is before `getDeleteAfterTime()`. |
| `block(UserInterface $user)` | `void` | Dispatch `AccountPolicyBlockEvent` (default subscriber blocks + saves). |
| `activate(UserInterface $user)` | `void` | Clear the warned flag and dispatch `AccountPolicyActivateEvent` (default subscriber unblocks, resets last-access, clears flood). |
| `delete(UserInterface $user)` | `void` | Dispatch `AccountPolicyDeleteEvent` with the configured `user_cancel_method`. |
| `getConfiguration()` | `Config` | The editable `simple_account_policy.settings` config object. |

All mutating actions (`block`/`activate`/`delete`/`issueWarning`) work by dispatching an event; the
actual user mutation is done by `DefaultEventSubscriber` (see [../events/events.md](../events/events.md)),
so you can substitute or extend behavior by adding your own subscriber.

## Example

```php
/** @var \Drupal\simple_account_policy\AccountPolicyInterface $policy */
$policy = \Drupal::service('simple_account_policy');
$user = \Drupal\user\Entity\User::load(42);

if ($policy->applyPolicy($user) && $policy->isInactive($user)) {
  $policy->block($user);          // fires AccountPolicyBlockEvent
}

$errors = $policy->validate($user, ['mail' => 'a@b.com', 'name' => 'a@b.com']);
// $errors === [] when the proposed name/mail satisfy the format rules.
```
