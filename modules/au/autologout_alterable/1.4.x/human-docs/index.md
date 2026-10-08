# Autologout Alterable — manual setup guide

**Autologout Alterable** (`autologout_alterable`) automatically logs users out
after a period of inactivity. It is a modern take on the classic Autologout
module, built to be "alterable": the timeout can be set globally, per role, or per
individual user, and almost every part of its behaviour can be changed by other
modules through events and a JSON API — handy for decoupled front-ends or
single-sign-on setups.

By default a signed-in user is logged out after 30 minutes (1800 seconds) of doing
nothing. "Doing nothing" is tracked both on the server (each request) and in the
browser — mouse movement, touches, clicks, key presses, and scrolling all count as
activity, and you can choose which of those to honour. Before the session expires,
an optional countdown dialog can warn the user and offer to keep them signed in.

The module is useful wherever idle sessions are a risk: shared or kiosk machines,
or sites with security/compliance requirements for idle session termination. You
can exempt trusted accounts entirely, force a hard maximum session length that
cannot be extended, redirect users somewhere specific after logout, and even let
cron clean up expired sessions server-side when a browser tab was simply closed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form, role and per-user
   timeouts, the warning dialog, and the permissions, field by field.

## Where it lives in the admin menu

The settings form is at **Configuration → People → Autologout Alterable**
(`/admin/config/people/autologout_alterable`), gated by the **Administer
autologout_alterable** permission. The settings are translatable, so the dialog
text can be localised per language.
