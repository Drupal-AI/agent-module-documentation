# Better Login — manual setup guide

**Better Login** (`betterlogin`) restyles Drupal's user login, registration,
password-request and password-reset pages into clean, standalone,
WordPress-style screens. Out of the box those core pages are just your normal
theme with a form dropped in the content region; Better Login turns each of them
into a focused sign-in card with your site logo, the site name, a "Forgot your
password?" link and a "Back to *&lt;site&gt;*" link — the kind of front door
members expect.

It works the moment you enable it. There is **no settings form, no routes, no
permissions and no configuration to export** (`configure: null`) — enabling the
module is the entire setup. Under the hood it ships four page templates
(`page--user--login`, `page--user--register`, `page--user--password`,
`page--user--reset`), a small CSS library, and a handful of hooks that autofocus
the username field, strip the noisy default field descriptions, set friendlier
browser-tab titles (Login / Register / Reset password), and hide the
login/register/password tab bar so each page reads as a dedicated screen. Its
only dependency is Drupal core; there are no submodules and no third-party
libraries.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it. That's the whole setup.

## Where it lives in the admin menu

Nowhere — Better Login has no admin page. It has no settings form, so you won't
find it under **Configuration** or anywhere else in the admin menu. Once enabled,
visit `/user/login`, `/user/register`, `/user/password` or `/user/reset` to see
the restyled pages.

## How to use it

There is nothing to configure. Enable the module and the four user pages are
immediately restyled. A few behaviours worth knowing:

- **The "Register a new account" link** appears on the login page only when
  public registration is actually allowed. Better Login reads Drupal's own
  setting (**Configuration → People → Account settings**, *Who can register
  accounts?*); if you set it to *Administrators only*, the register link and the
  register page are hidden automatically — no separate switch to flip.
- **The username field is autofocused** on the login form so people can start
  typing immediately.
- **A `?user=` shortcut**: an anonymous visitor who lands on any URL carrying a
  `?user=` query parameter is redirected to the login form (and sent back to
  `/user` after signing in).

### Changing the look

Better Login has no theme options in the UI, but the design is meant to be
customised in code — pick whichever fits how far you want to go:

- **CSS only** — the styling lives in the `betterlogin/betterlogin_css` library
  (`css/betterlogin.css` inside the module). Override those styles from your own
  theme if the markup is fine and you only want different colours, fonts or
  spacing.
- **Markup** — copy `page--user--login.html.twig` (and the register / password /
  reset variants) from the module's `templates/` directory into your theme's
  templates folder and edit them there. The theme copy wins over the module's.
  Rebuild caches (`drush cr`) after adding a template. Inside each template you
  have the Twig variables `site_name`, `logo`, `title` and `register_url`
  (the last is only present when registration is open) to work with.
