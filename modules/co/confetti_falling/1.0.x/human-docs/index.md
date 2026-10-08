# Confetti Falling — manual setup guide

**Confetti Falling** (`confetti_falling`) adds a gentle *falling confetti* effect
to the front end — small pieces of "paper" drifting down the screen, for a
festive or celebratory touch. It's ideal for a thank-you page, a completed
checkout, or a seasonal landing page, and it saves you from writing custom
animation JavaScript.

The effect is triggered by a **CSS class**: you tell the module which class name
identifies the page or element where confetti should fall, and it attaches its
JavaScript to make the animation play whenever that class is present. That means
you can reuse it across many pages by sharing one class, or limit it to specific
elements.

The module has no dependencies beyond Drupal core, creates no content, and is
purely client-side — so it adds essentially no server load and has a negligible
security surface. It has a single small settings form (gated by the *administer
site configuration* permission) where you set the trigger class.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

The configuration is a single field, so it's covered in "How to use it" below
rather than in a separate page.

## Where it lives in the admin menu

The settings form is at `/admin/config/confetti_falling_settings` (route
`confetti_falling.settings`), available to users with the **Administer site
configuration** permission.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to `/admin/config/confetti_falling_settings`.
3. Set the **class name** (or id) of the page or element where the confetti
   should fall. Any page that contains that CSS class will play the animation.
4. Save, then **clear the cache**.
5. Visit the target page — the falling-confetti animation should appear.

To change where the effect appears, edit the configured class; to remove it
entirely, uninstall the module.
