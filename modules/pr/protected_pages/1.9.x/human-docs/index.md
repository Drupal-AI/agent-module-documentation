# Protected Pages — manual setup guide

**Protected Pages** (`protected_pages`) lets an administrator password-protect any
page — or private-file path — on a Drupal site with a per-path password prompt that
is completely separate from user accounts. When a visitor tries to reach a
protected path, they're redirected to a password form; enter the correct password
and the page unlocks for the rest of their session. It's the simplest way to put a
shared password in front of a landing page, a whole section, or even the entire
site, without creating accounts or roles for everyone.

You add protected paths one at a time from the admin UI, each with its own path
(exact like `/node/5`, or a wildcard like `/new-events/*`, or `/*` for the whole
site), an internal title, and a password. You can also set a single **global
password** that unlocks every protected page, and choose whether pages accept the
per-page password, the global password, or both. The password prompt's title,
labels, and messages are all customizable, there's a configurable session timeout,
built-in IP flood control to slow brute-force guessing, and an admin form for
emailing a protected page's URL to people.

The module works once you configure it — enabling it alone protects nothing until
you add a path. It requires only core's **Path Alias** (`path_alias`) module and
has no submodules. Protected paths are stored as plain database rows (so they do
*not* travel with a configuration export), while the text, password-mode, and
session settings live in a config object that does export.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add protected paths, set the global
   password and password mode, tune the session timeout, customize the prompt text,
   and set the permissions.

## Where it lives in the admin menu

Everything is under **Configuration → System → Protected Pages**
(`/admin/config/system/protected_pages`): the list of protected pages with add /
edit / delete, the global settings form, and the "email this page" form. The
password prompt visitors see lives at `/protected-page`.

## How to use it

Enable the module, then go to the Protected Pages admin screen and **add a protected
page** — give it a path, a title, and a password. Decide on the settings form
whether you also want a global password and how long an unlock lasts. Finally, if
anonymous visitors need to unlock pages, grant them the "access protected page
password screen" permission (see [Configuration](configuration/index.md)).
