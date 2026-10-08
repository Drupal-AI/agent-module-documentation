# GOV.UK Webform Elements — manual setup guide

**GOV.UK Webform Elements** (`govuk_webform_elements`) extends the
[Webform](https://www.drupal.org/project/webform) module with **GOV.UK Design
System form components** — reusable composite elements that follow the UK
government's accessible form patterns. If you are building GOV.UK‑styled services,
these let you drop in the government's standard form widgets rather than
recreating their markup and accessibility behaviour by hand.

At present the module provides a GOV.UK Design System **composite date input**,
with more elements planned. The components are composites, so they behave like
Drupal's standard composite elements: you can add them to any webform, and they
can be customised through the provided UI and reused consistently across multiple
forms.

This is purely a forms and accessibility feature. It affects the form elements
available in Webform; it has no content model of its own and no access‑control
role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   ensure Webform is present, and enable it.

There is **no dedicated settings page** for this module. You use it entirely from
within Webform — see "How to use it" below.

## How to use it

1. Make sure the **Webform** module is installed and enabled (it is a required
   dependency).
2. Edit the webform you want to add a GOV.UK element to, and open its **Build**
   (elements) tab.
3. **Add element** and choose the GOV.UK composite you need — for example the
   **GOV.UK date input** — then configure it like any other Webform element.
4. Because these are composites, you can adjust and reuse them across multiple
   webforms for a consistent, accessible GOV.UK look and feel.
