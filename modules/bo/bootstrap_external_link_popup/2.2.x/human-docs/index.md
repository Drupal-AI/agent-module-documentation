# Bootstrap External Link Pop-up — manual setup guide

**Bootstrap External Link Pop-up** (`bootstrap_external_link_popup`) is a small
presentation add-on for the [External Link Pop-up](https://www.drupal.org/project/external_link_popup)
module. The parent module shows visitors a confirmation when they click a link
that leaves your site — the familiar *"You are now leaving our website"* notice.
This module simply changes how that notice looks: instead of the parent module's
own dialog, it renders the warning as a **Bootstrap modal**.

That is the whole job. On a site already themed with Bootstrap, the framework's
modal component is loaded anyway, so the pop-up matches the rest of the site
without any extra CSS to write or override. The module adds no settings of its
own — you configure *which* links trigger a warning, and *what* the warning
says, entirely in the parent External Link Pop-up module.

An outbound-link warning is a real requirement in some sectors: public bodies and
regulated financial or health organisations often must not appear to endorse
third-party content, and a documented interstitial is how that is demonstrated.
If your need is regulatory, this is a tidy way to present it in your theme's
style. If it is only a preference, be aware an interstitial interrupts *every*
outbound click and tends to be dismissed unread after the first time — a simple
visual indicator on external links is often the lighter answer.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm the parent module is present.

## Where it lives in the admin menu

This module has no configuration page of its own. It only styles the pop-up. You
set up the actual link warnings in the parent **External Link Pop-up** module,
under **Configuration**, where you define the pop-up text and the domains treated
as external.

## How to use it

1. Install and enable both External Link Pop-up and this module (see
   [Installation](installation/index.md)).
2. Use your **Bootstrap-based theme** so the framework's modal styling is
   available.
3. Configure your outbound-link warning in the parent module as usual.
4. Click an external link on the front end — the confirmation now appears as a
   Bootstrap modal rather than the parent module's default dialog.

Because a modal is a focus event, check the essentials of accessible dialog
behaviour on your site: it should trap focus while open, close on the **Escape**
key, and return focus to the link when dismissed. A warning nobody can dismiss
with a keyboard is a link nobody can follow.
