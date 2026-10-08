# Forma11y — manual setup guide

**Forma11y** (`forma11y`) improves the accessibility of your site's forms. It
makes sure that when a form has validation errors, those errors are Drupal's own
**inline error messages** — programmatically linked to the fields they belong to
— rather than the browser's native HTML5 validation bubbles, which are not
consistently exposed to screen readers and can pre‑empt Drupal's own error
handling.

It does this in two small, automatic steps. First it adds the `novalidate`
attribute to every form, which tells the browser to stand back and let Drupal
handle validation. Second, working together with core's **Inline Form Errors**
module, it associates each error message with its input using `aria-describedby`,
gives error messages a `role="alert"` ARIA live region so screen readers announce
them immediately, and generates unique IDs so the references are correct. The net
effect is a consistent, accessible error experience across browsers and assistive
technologies.

Setup is **zero‑configuration**: enable the module (and its Inline Form Errors
dependency) and every form on the site immediately gets `novalidate` plus the
helper library. There are no settings, no routes, and no permissions to manage.

The maintainers note that once the corresponding core issue ("programmatically
associate error messages with inputs") is resolved in Drupal core, this module
will no longer be necessary — but until then it bridges the gap.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (it pulls in Inline Form Errors).

There is **no configuration page** — the module has no settings. Once enabled it
works everywhere automatically.

## How to use it

Just enable it. Every form on the site then loads with native HTML5 validation
suppressed and Drupal's accessible inline errors doing the work. It pairs well
with **Webform** and applies equally to core content, login, and registration
forms. To confirm it's active, trigger a validation error on any form and check
that the message is Drupal's inline error (announced by a screen reader) rather
than a browser pop‑up.
