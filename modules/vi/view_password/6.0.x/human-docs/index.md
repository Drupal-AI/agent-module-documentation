# View Password — manual setup guide

**View Password** (`view_password`) adds a small "show/hide password" eye toggle
next to the password fields on the forms you choose. A visitor can click the eye
to reveal what they typed, check it, and hide it again — all in the browser, with
no data sent to the server. It's the same convenience you see on most modern login
screens, brought to Drupal's forms.

Out of the box it targets the standard user login form. You decide which forms get
the toggle by listing their form IDs on a small settings page, so you can add it to
the registration form, a password‑change form, or any custom form that has a
password field. The toggle is accessible: its button carries an `aria-label` that
flips between "Show password" and "Hide password" as the field is revealed or
hidden.

The module is deliberately tiny. It depends only on Drupal core, stores its choices
in a single configuration object (so they export and deploy cleanly between
environments), and lets you restyle the button or swap the eye icons for your own
SVGs if you want a branded look.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — pick which forms get the toggle, and
   optionally set custom CSS classes or icons.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → View Password Settings**
(`/admin/config/system/view-password-settings`). You need the **Administer view
password** permission to open it. By default the login form
(`user_login_form`) already has the toggle once the module is enabled.
