# Anonymous Redirect — manual setup guide

**Anonymous Redirect** (`anonymous_redirect`) sends every anonymous
(not-logged-in) visitor to a destination you choose — the login page, an
internal landing page, the front page, or an entirely different domain — while
authenticated users browse the site as normal. It's a lightweight way to turn a
site into a login-gated members area, a "coming soon" holding page, or a
locked-down staging environment, without pulling in a full access-control
system.

It works by checking each incoming request: if the redirect is switched on, the
user is anonymous, and the site isn't in maintenance mode, the visitor is sent to
your configured target. External URLs are handled safely as trusted redirects,
`<front>` goes to the front page, and anything else is treated as an internal
path. You can list **override paths** — one per line, with `*` wildcards — that
anonymous users are still allowed to reach, so you can keep the login page, a
privacy policy, or a whole public section open. When the target is the login
page, the visitor's originally requested path is preserved as a `?destination=`
so they land where they intended after signing in.

The module is careful about the details: it skips asset-generation paths so CSS/JS
and image derivatives still build, strips a language prefix before matching
overrides on multilingual sites, and stays out of the way during maintenance mode
so admins can always recover. Because it's a single config object, you can toggle
or retarget it per environment from `settings.php` (for example, lock only your
staging site).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — turn the redirect on, set the
   target, and whitelist paths.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Anonymous Redirect**
(`/admin/config/system/anonymous-redirect`), gated by the core **Administer site
configuration** permission.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Open the settings form and set your **redirect target** (it defaults to the
   login page).
3. Add any paths anonymous users should still reach — at minimum keep the login
   page reachable — to the **overrides** list.
4. Tick **Enable Anonymous Redirect** and save.

See [Configuration](configuration/index.md) for each field in detail.
