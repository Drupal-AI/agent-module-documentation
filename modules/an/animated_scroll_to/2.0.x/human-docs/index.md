# Animated Scroll To — manual setup guide

**Animated Scroll To** (`animated_scroll_to`) makes in-page anchor links glide smoothly
to their target instead of jumping there instantly, and it can also scroll to an element
automatically when a page loads with a `#fragment` in its URL. It is handy for long
documentation pages, one-page sites, table-of-contents jumps, deep-linked comments, and
scrolling to a form's error summary.

The two behaviours are deliberately separate, which is why the module ships two scripts:
one handles clicks on links that point to an anchor within the current page, and the other
handles arriving at a URL that already carries a `#fragment` — the case a click handler
cannot cover, because no click happens. The module has no dependencies beyond Drupal core.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it.

## Where it lives in the admin menu

The settings form is at **Configuration → Animate Scroll To → Settings**
(`/admin/config/animate-scroll-to/settings`), behind the module's own **Administer
animated scroll to** permission.

## How to use it

After enabling the module, open the settings form at
`/admin/config/animate-scroll-to/settings` to control the scroll **duration**, an
**offset** (useful so a sticky header doesn't cover the target), and **which elements**
are affected. Save, then click an in-page anchor link — it will glide to its target rather
than jump.

### Consider the CSS-native alternative first

Modern CSS offers `scroll-behavior: smooth` (paired with `scroll-margin-top` for a
sticky-header offset), which needs no JavaScript and — importantly — is automatically
disabled by browsers when the visitor has asked for reduced motion. A JavaScript
implementation must honour `prefers-reduced-motion` itself. Scroll animation is one of the
motion effects most likely to trouble people with vestibular disorders, so verify that
before enabling this on a public site, and check whether the CSS-native approach already
covers your need.
