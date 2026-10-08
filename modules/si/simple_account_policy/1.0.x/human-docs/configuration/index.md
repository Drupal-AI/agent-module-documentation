# Configuration

Account policy installs with working defaults, but you should open the settings and
tailor them to your site — especially before you let it start blocking accounts
automatically.

## Open the settings form

1. Log in as a user with the **Administer account policy** permission (an
   administrator by default).
2. Go to **Configuration → People → Account policy**, or navigate directly to
   `/admin/config/people/account_policy`.

## The policy rules

The form groups the configurable rules the module enforces. The defaults it ships
with are shown in parentheses.

- **Username must match email** *(on by default)* — when enabled, a user's username
  must equal their email address, effectively enforcing "email as username".
- **Username allowed patterns** *(none by default)* — usernames must match this
  pattern to be considered valid. Leave empty to allow any username.
- **Username ignore patterns** *(none by default)* — usernames matching this pattern
  are exempt from the policy. This is where you list the **service accounts,
  integration users, and administrator accounts** you do not want the rules — and
  especially automatic blocking — to catch.
- **Email allowed patterns** *(none by default)* — email addresses must match this
  pattern to be valid, for example to restrict registration to a corporate domain.
- **Cron check interval** *(1 day / 86400 seconds by default)* — how often the
  module re-checks all users against the policy on cron runs.
- **Inactive period** *(3 months by default)* — how long a user can go without
  logging in before they are blocked.
- **Inactive warning period** *(3 weeks by default)* — how far ahead of the block
  a warning email is sent to users about to be blocked.
- **Warning mail subject and message** — the subject and body of that warning
  email. You can use the tokens the module provides to personalise them.
- **Time after which an inactive user is removed** *(1 year by default)* — how long
  after being blocked an inactive account is deleted.
- **Content handling method when a user is removed** *(reassign by default)* — how
  the removed user's content is handled, mapping to Drupal's account-cancellation
  methods (for example reassigning their content to the anonymous user).

Save the form to apply your changes.

## Manual activate and block operations

Beyond the automatic rules, the module adds two operations you can run by hand from
the **People** screen (`/admin/people`):

- **Activate** — unblocks a user *and* clears their entry in the flood table, which
  removes any login-attempt lockout. Because this restores access to a disabled
  account, it is gated by the dedicated **Account policy activate users**
  permission — treat it as an account-recovery capability.
- **Block** — blocks a user, gated by the **Account policy block users**
  permission.

## A word of caution before enabling automatic blocking

The inactivity rules will, over time, catch accounts that rarely log in — service
accounts, scheduled-integration users, and seldom-used administrator accounts.
Locking out the account you would need to fix the problem is the classic mistake.
Before you rely on automatic blocking, list those accounts in **Username ignore
patterns** so the policy skips them.
