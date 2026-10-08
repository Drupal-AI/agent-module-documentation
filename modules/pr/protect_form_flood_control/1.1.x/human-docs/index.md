# Protect Form Flood Control — manual setup guide

**Protect Form Flood Control** (`protect_form_flood_control`) applies Drupal core's
built-in **flood control** service to any form on your site. In plain terms: it blocks
a visitor who submits a given form too many times within a set time window — a simple,
CAPTCHA-free way to slow down bots and abusers on contact forms, registration forms,
login, password reset, webforms and more.

You decide what "too many" means with two numbers: a **threshold** (how many
submissions are allowed) and a **window** (over how many seconds). When a client goes
over the threshold, the next submission is rejected with an error; otherwise the
submission is recorded and allowed. You can protect **every** form at once (with a list
of exceptions), or protect just an explicit list of form IDs, and you can override the
window and threshold for individual forms — so a newsletter signup might allow 3 per
hour while everything else uses a looser site-wide default.

Sensible safety rails are built in. Core's own `system_*`, `search_*` and exposed-filter
forms are never protected, and neither is the module's own settings form. A **whitelist**
of IP addresses and a *bypass* permission let trusted staff skip the limits entirely,
an optional log records blocked submissions so you can monitor abuse, and a debug mode
prints each form's ID to privileged users so you can discover the IDs you need to
configure. The module needs nothing beyond Drupal core.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the protection modes, per-form overrides,
   whitelist, logging, debug mode, and permissions.

## Where it lives in the admin menu

The settings form is at **Configuration → User interface → Protect Form Flood
Control** (`/admin/config/user-interface/protect-form-flood-control`), governed by the
**Administer protect form flood control** permission.
