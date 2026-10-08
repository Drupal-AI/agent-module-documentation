# System Messages Override — manual setup guide

**System Messages Override** (`system_messages_override`) lets an administrator
replace the wording of Drupal's built-in status, warning and error messages with
text you supply — no code required. Core's messages were written for people who
already know Drupal: "The website encountered an unexpected error" tells an ordinary
visitor nothing they can act on, and "Article *Foo* has been created" speaks in the
content model's vocabulary rather than your organisation's. Those messages appear at
exactly the moments a user is confused — on login, on registration, on a failed
access, on a form validation error — so improving them is one of the cheapest wins
on a site.

The module works by swapping Drupal's core messenger for a custom messenger that
rewrites messages according to the overrides you configure, and it understands
translatable-markup messages as well as plain strings. You add overrides on a
configuration screen at `/admin/config/system/messages-override`, where each entry
pairs an original message with its replacement. A built-in **Debug** option
(together with the core dblog module) can log the exact message strings as they pass
through, so you can copy them precisely and know what to paste as the "original". It
provides its own permission, has no module dependencies and ships no submodules, and
it is covered by the security advisory policy.

Two things are worth keeping in mind before you start rewording, both covered on the
[Configuration](configuration/index.md) page. First, a **replaced message loses the
translations** the core original shipped with — so on a multilingual site, check how
an override interacts with the translation layer first. Second, **error messages
carry meaning that support and logs depend on** — softening "Access denied" into
something friendlier can help the visitor but make a support conversation harder, so
keep enough specificity that someone can still tell which condition fired.

This guide is written for a **human** setting the module up through the admin UI. If
you are an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add message overrides, use Debug to
   capture exact strings, and the caveats to keep in mind.

## Where it lives in the admin menu

Once enabled, the configuration screen is at
**Configuration → System → Messages override**
(`/admin/config/system/messages-override`). Access to it is controlled by the
module's own permission, which is marked as a restricted-access permission.
