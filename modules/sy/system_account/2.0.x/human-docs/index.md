# System Account — manual setup guide

**System Account** (`system_account`) creates and manages a dedicated "system" user
account you can use to attribute automated or system-generated actions — the author
of auto-created comments or nodes, for example, much like the *System Message*
account you see on drupal.org. Instead of automated content showing up under a real
person's name (or under the anonymous user), it can be credited to a stable,
clearly-labelled system account with a friendly display name you choose.

Under the hood the module adds a `system_account` boolean base field to the user
entity that flags an account as system-managed, and provides a `SystemAccountManager`
service that other code can use to create such accounts programmatically — each with
a strong random password and an active status. Other modules can ship a system
account by providing `system_account.account.<module>.<id>` configuration; on
install, System Account reads that config, validates the username and email, and
creates the account only if no user already matches that name or email. A hook
rewrites the display name of the default system account to the value you set on the
settings form. It depends on core's **User** module and ships no submodules.

The security posture is deliberately conservative. Existing system accounts are never
modified by a repeat create call, and with **Preserve existing accounts** enabled
(the default) an existing non-system account with the same name is left untouched
rather than being converted — both situations are logged. The only admin route,
`/admin/config/people/system-account`, is gated by the core **Administer users**
permission and merely edits two configuration values; it does not create, delete,
grant roles to, or change passwords of accounts, and it exposes no account data.
There is no anonymous or state-changing endpoint. Note the module is not covered by
the security advisory policy, and this release is an alpha.

This guide is written for a **human** setting the module up through the admin UI. If
you are an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead — including the [manager service reference](../agent/api/manager.md).

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the display name and the preserve
   toggle on the settings form.

## Where it lives in the admin menu

Once enabled, the settings form is at **Configuration → People → System Account**
(`/admin/config/people/system-account`, the `system_account.settings` route). That is
where you set the display name shown for the default system account and control
whether same-named existing accounts are preserved.
