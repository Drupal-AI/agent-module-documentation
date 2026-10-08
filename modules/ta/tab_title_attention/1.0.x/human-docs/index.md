# Tab Title Attention — manual setup guide

**Tab Title Attention** (`tab_title_attention`) is a small user-engagement module
that animates the text in the browser tab when a visitor switches away from your
site. When the tab loses focus and sits inactive for a while, your custom message
can appear, blink, or scroll across the browser-tab title — a gentle nudge to draw
the visitor's attention back and keep them coming back to your site.

Everything happens client-side in the browser: the module changes the tab's title
text and has no effect on your content or on access control beyond its own
permissions. It requires no other modules — just Drupal core.

Unlike a pure "works on enable" module, Tab Title Attention needs a little setup
before it does anything: you activate and configure the animation on its settings
page, and you decide **who can edit** the animation settings and **who the
animation is shown to** using the module's permissions.

There is one caveat worth knowing up front. The module is affected by a
long-standing Drupal core bug (issue [#2783897]) around visibility conditions.
Until that is resolved, you may need to explicitly select your theme in the
condition settings for the animation to apply as expected.

This guide is written for a **human** clicking through the admin UI. If you are an
AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — activate and configure the tab-title
   animation, and set who can edit and who sees it.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → User interface → Tab
Title Attention settings**. Its permissions — who may edit the animation and who
sees it — are set at **People → Permissions**.
