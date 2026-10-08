# Multilingual plus — manual setup guide

**Multilingual plus** (`multilingual_plus`) is a small set of enhancements that sit
on top of Drupal's core multilingual features to smooth a few common multilingual
site‑building tasks. Rather than replacing anything, it adds targeted conveniences
where core leaves gaps.

Based on the project's own description, it provides two concrete additions:

- A **handler that shows the original language of a piece of content** — useful when
  you want editors or visitors to see which language a translation was derived from.
- A **Webform email handler** that lets you **send the email to different recipients
  for each language** — so a multilingual contact or enquiry form can route
  submissions to the right team depending on the language it was filled in.

These are practical, behind‑the‑scenes helpers for multilingual sites. The module
plays no access‑control role; its effect is on language handling and translation
presentation. Because it works through handlers rather than a central settings
screen, there is no dedicated configuration page — you use its pieces where they
belong (a field/display handler for the original‑language feature, and the Webform
handler list for the email routing).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no central settings form** for this module. Its features are used in
place: the original‑language handler where you configure the relevant display, and
the per‑language email handler within a Webform's email/handler settings (which
requires the Webform module).

## Where it lives in the admin menu

Multilingual plus adds no admin page of its own. Its per‑language email routing is
configured on a **Webform**'s handlers (under **Structure → Webforms**, if you use
the Webform module), and its original‑language feature is used where you build the
relevant content display.
