# Anonymous Login — manual setup guide

**Anonymous Login** (`anonymous_login`) forces anonymous visitors to log in
before they can view the pages you choose, then sends them straight back to the
page they were trying to reach. It is the quick way to make part of a site — or
the whole thing — members-only without writing any access-control code.

You decide which paths are protected with a simple list. A plain path (for
example `/members/*`) is an **include**: an anonymous visitor who hits it is
bounced to the login form. A path prefixed with a tilde (for example
`~/members/public`) is an **exclude**: it is never protected, even if a broader
include would otherwise catch it. Wildcards (`*`) are supported, and the module
checks both the internal path and its alias, so it works well with pretty URLs
and multilingual sites. A handful of paths are always left open — password reset
links (`user/reset/*`), cron, and public files — so you never accidentally lock
yourself out of those.

When a visitor is redirected, Anonymous Login adds `?destination=` to the login
URL so that, once they sign in, they land back on the page they originally asked
for instead of the front page. You can point the redirect at a custom login path
(handy for SSO) and show an optional status message such as "Please log in to
view this page."

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form field by field:
   which paths force login, the login path, and the message.

## Where it lives in the admin menu

Once enabled, protection is driven entirely by the settings form at
**Configuration → User interface → Anonymous login**
(`/admin/config/user-interface/anonymous-login`). Editing it requires the
**Administer anonymous login settings** permission (`administer anonymous login
settings`). On a fresh install no paths are configured, so nothing is protected
until you add at least one include path.
