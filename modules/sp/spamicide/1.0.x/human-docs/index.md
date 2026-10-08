# Spamicide — manual setup guide

**Spamicide** (`spamicide`) is a lightweight, honeypot-based anti-spam module. It
adds a text field to your forms that is hidden with CSS, so real people never see
or fill it in — but automated bots, which fill in every field they find, do. Any
submission where that hidden field has a value is silently rejected. There is no
CAPTCHA to solve and no puzzle for real users or screen readers, which makes it a
friction-free, accessible form of spam protection.

Protection is configured per form. Each protected form is a small configuration
entity keyed by the form's ID, so you can turn protection on or off for specific
forms. When the module is installed it automatically protects five common core
forms — the site-wide contact form, the personal contact form, the user
registration form, the user login form, and the default comment form. You can add
protection to any other form (custom, Webform, newsletter signup, and so on) by
its form ID.

When a bot is caught, Spamicide blocks the submission and — if logging is enabled
— records the form ID and the attacker's IP address, and bumps a running counter
of blocked submissions. Because it is honeypot-only, it does not add flood
control or CAPTCHA; you can happily layer it with tools like Honeypot or CAPTCHA
for defense in depth.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — manage which forms are protected and
   tune the settings.

## Where it lives in the admin menu

Protections are managed at **Structure → Spamicide**
(`/admin/structure/spamicide`), and the module's settings are one level down at
`/admin/structure/spamicide/settings`.

## How to use it

1. Enable the module — the five common core forms are protected automatically.
2. Add protection for any other form you care about by its form ID (see
   [Configuration](configuration/index.md)).
3. Optionally turn on **admin mode** to get one-click "protect this form" links
   as you browse your site's forms.
