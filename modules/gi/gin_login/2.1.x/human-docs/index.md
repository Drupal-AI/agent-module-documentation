# Gin Login — manual setup guide

**Gin Login** (`gin_login`) restyles Drupal's user **login**, **password-reset**
and **registration** pages so they match the **Gin** administration theme. Instead
of the plain front-end login form, visitors and content editors get a clean,
branded sign-in experience: the form sits on a centered card next to a large
brand wallpaper, and the whole screen honors the accent color, focus color, dark
mode and high-contrast settings you have configured for Gin. The module also adds
handy action links to the forms — a *Create new account* button and a
*Forgot your password?* link — and relabels the buttons to fit the Gin look.

Because it only touches the anonymous user-authentication pages, Gin Login has no
effect on the rest of your site's theme. It does, however, rely on the **Gin admin
theme** to supply its styling, so Gin must be installed and set as the admin theme
for the login pages to render fully.

This guide is written for a **human** clicking through the admin UI. If you are
looking for terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

![The Gin Login Configuration Form with its Logo and Wallpaper sections](images/settings.png)

## Where it lives in the admin menu

The module adds a single configuration screen at **Configuration → System → Gin
Login** (`/admin/config/system/configuration/gin-login`). From there you choose the
logo and wallpaper used on the login pages. There are no separate tabs — everything
is on that one form.

## Contents

1. [Installation](installation/index.md) — install Gin Login with Composer, enable
   it, and make sure the Gin theme is in place.
2. [Configuration](configuration/index.md) — click through the settings form to set
   a logo and a wallpaper for your login pages, then see the result at
   `/user/login`.
