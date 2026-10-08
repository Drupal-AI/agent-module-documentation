# Contact Ajax — manual setup guide

**Contact Ajax** (`contact_ajax`) makes Drupal's core contact forms submit with
AJAX — no full page reload — and lets you choose, per contact form, exactly what the
visitor sees after a successful submission. Instead of the page refreshing and
bouncing the visitor to a confirmation, the form area updates in place, which keeps
people on the page and generally improves conversion on "Contact us" pages.

The module doesn't add a settings page of its own. Instead it adds a **"Contact
ajax"** section to each contact form's edit page. There you switch AJAX on for that
form and pick what replaces it after submit: just the usual "Your message has been
sent" status message, that message plus a fresh empty form for another submission,
the full rendered content of a node you choose (a thank‑you page, say), or a custom
formatted message you type in. Advanced options let you set a custom wrapper id or
inject the response into a different element on the page using a CSS selector.

Because the settings are stored per form, you can mix behaviors — give your lead
form a marketing thank‑you node while leaving another form on the plain status
message, or leave some forms as ordinary non‑AJAX submissions entirely. Validation
errors are handled inline over AJAX too, so a visitor who forgets a field sees the
error without losing what they typed.

It pairs nicely with the **Contact Storage** module if you want to keep a record of
submissions while still using the AJAX experience.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the per‑form "Contact ajax" settings,
   the confirmation types, and the advanced options.

## Where it lives in the admin menu

There is no central settings page. You configure each form under **Structure →
Contact forms** (`/admin/structure/contact`), on the edit page of the individual
contact form, in the **Contact ajax** section.

## How to use it

1. Install and enable the module.
2. Edit a contact form (core ships one called *Website feedback*), open the **Contact
   ajax** section, and tick **Ajax Form**.
3. Choose what shows after a successful submit, then save the form.
4. Visit the form's page and submit it — the form area updates in place instead of
   reloading.

The field‑by‑field walkthrough is in [Configuration](configuration/index.md).
