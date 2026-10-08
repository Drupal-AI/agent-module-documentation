<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# cancel_account — agent orientation

- Standalone self-service account-cancellation form (`src/Form/CancelAccountForm.php`, id `cancel_account_form`).
- Access control reviewed: submit ALWAYS cancels `currentUser()->id()` — no cross-account deletion; build gated by `user->id() == account->id()` and `cancel account` permission; user 1 excluded.
- CSRF: standard FormBase token. Password re-entry required and checked via core `password` service. Sound — no finding.
- Cancellation method honors `select account cancellation method` permission else site default; redirect to <front>.
- No routes/permissions declared by the module itself; form is embedded by host code.
