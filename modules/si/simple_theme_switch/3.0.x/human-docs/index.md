# Simple Theme Switch — manual setup guide

**Simple Theme Switch** (`simple_theme_switch`) makes Drupal render its account
pages — the user **login** page, the **password-request** page (`/user/password`),
and the **password-reset** confirmation page (`/user/reset/...`) — in your site's
**admin theme** instead of the front-end theme. By default Drupal shows those pages
in the public theme, which can look out of place; this module gives them the same
back-office styling as the rest of your administration UI, so login and password
flows feel consistent and on-brand.

Under the hood it registers a theme negotiator that recognises exactly those three
routes and returns whatever theme you've set as the site's admin theme. It also
provides an extension hook,
`hook_simple_theme_switch_flag_for_applies_of_admin_theme()`, so a custom module can
opt *additional* routes into the admin theme — the shipped example matches Webform
submission view pages. If you don't need extra routes, you never touch the hook.

Setup is about as light as it gets: install the module and make sure you've chosen
the admin theme you want under **Appearance**. There is no settings form of its own,
and the module adds no routes, permissions, or configuration. Changing which theme
gets applied is simply a matter of changing your site's admin theme. It works on
Drupal 10 and up. Because it only affects *which theme renders already-public
account pages*, it has no access or security implications.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There's nothing to configure. Once enabled, the login, password-request, and
password-reset pages render in whatever theme is set as your **admin theme** under
**Appearance** (`/admin/appearance`). To change the look of those pages, change your
admin theme — pairing it with an admin theme like Gin or Claro gives the login
screens a clean back-office style. To extend the admin theme to further routes (for
example Webform submission pages), a developer can implement
`hook_simple_theme_switch_flag_for_applies_of_admin_theme()` in a custom module.
