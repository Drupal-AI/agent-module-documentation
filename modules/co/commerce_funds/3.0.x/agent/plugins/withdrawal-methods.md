<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WithdrawalMethod plugin type

A withdrawal method describes how a user gets paid out (bank transfer, check, PayPal, Skrill…). Each
plugin defines the form fields for the payout details a user must enter; those details are stored per
user via the `user.data` service under the `commerce_funds` module namespace, keyed by the method id, and
optionally encrypted with the configured `encrypt` profile. Actual payouts are performed manually by an
administrator when they approve a withdrawal request — the plugin does not call any external API.

## The plugin type

- **Manager service:** `plugin.manager.withdrawal_method` (`WithdrawalMethodPluginManager`), discovering
  in `Plugin/Funds/WithdrawalMethod`.
- **Attribute:** `Drupal\commerce_funds\Attribute\WithdrawalMethod` (`id`, optional `label`).
- **Annotation (legacy):** `Drupal\commerce_funds\Annotation\WithdrawalMethod`.
- **Interface:** `Drupal\commerce_funds\WithdrawalMethodInterface`.
- **Alter hook:** `hook_commerce_funds_withdrawal_methods_info_alter()`.
- Cache key `commerce_funds_withdrawal_methods`.

## Bundled plugins (ids)

- `bank_account` (`Plugin\Funds\WithdrawalMethod\BankAccount`) — collects bank details; validates against
  Symfony `intl` constraints when `symfony/intl` is present.
- `check` (`…\Check`)
- `paypal` (`…\Paypal`)
- `skrill` (`…\Skrill`)

Which of these a site offers is set in the Withdrawal methods config form (`withdrawal_methods` sequence,
see [../configure/settings.md](../configure/settings.md)).

## Where they plug in

- Admin enables/disables them at `commerce_funds.settings.withdrawal_methods`.
- A user edits their own details at `commerce_funds.withdrawal_methods.edit`
  (`/user/{user}/withdrawal-methods/{method}/edit`); the controller
  `Controller\WithdrawalMethods::editMethod()` builds the plugin's form class, and `::content()` lists a
  user's saved methods. Access is via `WithdrawalMethodAccessCheck` (own account + `withdraw funds`, or
  `administer withdrawal requests`).
- When submitting a withdrawal (`FundsWithdraw` or the `withdrawal` widget), the user must have saved
  details for the chosen method, else validation links them to the edit form.
- On approval, `ConfirmWithdrawalApproval` reads the stored (and decrypts, if `encrypt` is enabled)
  payout details to display them to the administrator.

## Writing a custom method

Create a class in your module's `Plugin/Funds/WithdrawalMethod/`, annotate with
`#[WithdrawalMethod(id: 'my_method', label: new TranslatableMarkup('My method'))]`, implement
`WithdrawalMethodInterface`, and provide the details form (mirror `BankAccount`/`Check`). Store values
through `user.data` under `commerce_funds`. Add its id to the `withdrawal_methods` config to enable it.
