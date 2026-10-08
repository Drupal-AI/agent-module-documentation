# Configuration

System Account has a small, focused settings form with two options. It edits only
those two configuration values — it does not create, delete, or change accounts from
this screen.

## Open the settings form

1. Log in as a user with the **Administer users** permission (an administrator by
   default).
2. Go to **Configuration → People → System Account**
   (`/admin/config/people/system-account`, the `system_account.settings` route).

## The two settings

- **Display name** *(default: `System Account`)* — the name rendered wherever the
  default system account is shown, for example as the author label on nodes, comments
  and revisions it is credited with. Set this to something friendly and recognisable
  so the machine username is never exposed to visitors. Changing it updates how the
  account is displayed, not the underlying username.

- **Preserve existing accounts** *(default: on)* — controls what happens if code tries
  to create a system account whose name matches an **existing, non-system** user. When
  **on** (recommended), that existing account is left completely untouched rather than
  being converted into a system account, and the attempt is logged. When **off**, a
  same-named existing account can be converted into a system account (its mail,
  password, status and system flag get set). Leave this on unless you specifically
  intend to convert existing accounts — it is what prevents a real user from
  accidentally being turned into a bot account.

Click **Save configuration** when done.

## Beyond the form

Creating and loading system accounts programmatically (the `SystemAccountManager`
service, and shipping an account from another module via
`system_account.account.<module>.<id>` config) is a developer concern rather than a
click-through task — the full reference for that is in the agent docs at
[`agent/api/manager.md`](../agent/api/manager.md).
