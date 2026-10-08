# Alternative Login ID & Display Name (alt_login) — manual setup guide

**Alternative Login ID & Display Name** (`alt_login`) gives you two related
options: it lets people sign in with an **alternative identifier** — most commonly
their **email address** as well as (or instead of) their username — and it lets
you control **how a user's name is displayed** around the site.

By default Drupal only accepts the username in the login form. On many sites it is
friendlier to let people type the email address they already remember. This module
makes that possible, and separately lets you configure which value is shown as the
"display name" for accounts.

It is important to understand what this does **not** change. It only affects the
*identifier* used to find the account — the password is still verified by Drupal
core exactly as before, and core's login flood control (protection against
repeated failed attempts) still applies. Two things are worth getting right when
you allow email-as-login: make sure the alternative identifier is **unique** so it
maps to exactly one account, and remember that letting people log in by email can
make valid addresses a little easier to guess at — so keep your login and
registration messages neutral (Drupal's defaults already do this). The module has
no other role in access control.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose the login identifier and the
   displayed username.

## Where it lives in the admin menu

Once enabled, the module adds a settings form (route `alt_login.admin`) where you
choose the login and display-name options. See
[Configuration](configuration/index.md) for how to reach it and what each option
does.
