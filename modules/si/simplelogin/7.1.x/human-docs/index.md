# Simple Login — manual setup guide

**Simple Login** (`simplelogin`) restyles Drupal's anonymous user pages — login,
register, and password-reset — into a clean, branded experience with a full-page
background image (or a solid colour), a centered form card, and placeholder-style
inputs, all set up from one admin form. It's the quick way to give
`/user/login`, `/user/register`, and `/user/password` a polished look without
building a custom theme.

For anonymous visitors on those paths, the module swaps in its own page template,
adds a `simplelogin` body class, and injects CSS that applies your chosen
background, an optional opacity overlay, and optional button/link tinting. It turns
form field labels into placeholders (and can visually hide the labels while keeping
them for screen readers), relabels the login button to "Login to Account", and can
even strip the active theme's CSS from these pages for a truly minimal look.

Everything is driven by one settings form: pick an image or a colour, set the card
width, and choose the label and CSS options. The set of styled paths can be
extended in code (via a hook) to cover custom login routes, and a theme can
override the page template by dropping its own copy in place. The module has no
dependencies, no plugins, and no Drush commands, and it only affects **anonymous**
users — logged-in users and admins see the normal pages.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, field by field.

## Where it lives in the admin menu

The settings form sits at **Configuration → Simple Login**
(`/admin/config/simplelogin`). Opening it requires the core **Administer site
configuration** permission — the module defines no permission of its own.
