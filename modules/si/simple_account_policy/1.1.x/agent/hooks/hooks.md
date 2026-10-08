# Hooks & runtime behavior

In 1.1.x the hook implementations are attribute-based `#[Hook]` methods on two service classes —
`Drupal\simple_account_policy\Hook\SimpleAccountPolicyHooks` (help, cron, form_user_form_alter, mail,
entity_operation_alter) and `Drupal\simple_account_policy\Hook\SimpleAccountPolicyTokensHooks`
(token_info, tokens). `simple_account_policy.module` keeps thin `#[LegacyHook]` wrapper functions
that delegate to those services, plus the `simple_account_policy_time_ago()` helper.

## `hook_cron()` — inactivity blocking + deletion

`SimpleAccountPolicyHooks::cron()` runs at most once per `inactive_interval` seconds (tracked in
state `simple_account_policy.last_cron_run`; returns early if the interval has not elapsed or is 0).
It loads **all** users (`User::loadMultiple()` — not queued, so it can be heavy on large sites) and,
for each user where `applyPolicy()` is TRUE:

1. If `shouldBeDeleted()` (last-access before `delete_after_time`) → `delete()` and continue.
2. Else if already blocked → skip.
3. Else if `shouldIssueWarning()` → `issueWarning()` (sends warning mail, records the user in state
   `simple_account_policy.warned_users`).
4. Else if `isInactive()` → `block()`.

## `hook_form_FORM_ID_alter()` for `user_form` — format enforcement

`SimpleAccountPolicyHooks::formUserFormAlter()` applies the username/email format policy on the user
edit/register form: it disables the username field when `username_prevent_changes` is set, shows the
applicable rules as field `#description`s (`AccountPolicy::policy()`), and appends the static
validator `SimpleAccountPolicyHooks::userFormValidate()` which calls `AccountPolicy::validate()` and
sets form errors on `mail`/`name` when a proposed value violates a rule.

## `hook_entity_operation_alter()` — People-list row ops

`SimpleAccountPolicyHooks::entityOperationAlter()` adds an **Activate** op (link to
`simple_account_policy.activate`) on blocked users for callers with `account policy activate users`,
and a **Block** op (link to `simple_account_policy.block`) on active users for callers with
`account policy block users`.

## `hook_mail()` — warning email

`SimpleAccountPolicyHooks::mail()` builds the `inactive_warning_mail` message, token-replacing the
configured subject/body under the recipient's language.

## Token: `[account_policy:block_period]`

`SimpleAccountPolicyTokensHooks` defines token type `account_policy` (needs a `user` data object)
with one token `block_period` — a human-readable "in N weeks / N days" rendering of the user's
`getBlockTime()` via `simple_account_policy_time_ago()`. Use it in the `inactive_warning_mail.body`,
e.g. `… your account will be blocked [account_policy:block_period].`
