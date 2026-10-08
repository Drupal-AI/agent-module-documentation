# Hooks & runtime behavior

Implemented in `simple_account_policy.module` and `simple_account_policy.tokens.inc`.

## `hook_cron()` — inactivity blocking + deletion

`simple_account_policy_cron()` runs at most once per `inactive_interval` seconds (tracked in state
`simple_account_policy.last_cron_run`; returns early if the interval has not elapsed or is 0). It
loads **all** users (`User::loadMultiple()` — the code notes this is not queued and can be heavy on
large sites) and, for each user where `applyPolicy()` is TRUE:

1. If `shouldBeDeleted()` (last-access before `delete_after_time`) → `delete()` and continue.
2. Else if already blocked → skip.
3. Else if `shouldIssueWarning()` → `issueWarning()` (sends warning mail, records the user in state
   `simple_account_policy.warned_users`).
4. Else if `isInactive()` → `block()`.

## `hook_form_FORM_ID_alter()` for `user_form` — format enforcement

`simple_account_policy_form_user_form_alter()` applies the username/email format policy on the user
edit/register form: it disables the username field when `username_prevent_changes` is set, shows the
applicable rules as field `#description`s (`AccountPolicy::policy()`), and appends
`simple_account_policy_form_user_validate` which calls `AccountPolicy::validate()` and sets form
errors on `mail`/`name` when a proposed value violates a rule.

## `hook_entity_operation_alter()` — People-list row ops

`simple_account_policy_entity_operation_alter()` adds an **Activate** op (link to
`simple_account_policy.activate`) on blocked users for callers with `account policy activate users`,
and a **Block** op (link to `simple_account_policy.block`) on active users for callers with
`account policy block users`.

## `hook_mail()` — warning email

`simple_account_policy_mail()` builds the `inactive_warning_mail` message, token-replacing the
configured subject/body under the recipient's language.

## Token: `[account_policy:block_period]`

`simple_account_policy.tokens.inc` defines token type `account_policy` (needs a `user` data object)
with one token `block_period` — a human-readable "in N weeks / N days" rendering of the user's
`getBlockTime()`. Use it in the `inactive_warning_mail.body`, e.g.
`… your account will be blocked [account_policy:block_period].`
