# Datalayer Webform — manual setup guide

**Datalayer Webform** (`datalayer_webform`) fires a custom `dataLayer` event in the
browser whenever a webform is submitted — the piece you need to track form
conversions in Google Tag Manager, Google Analytics 4, or any tag/pixel that listens
for a `dataLayer` push. It's especially handy for modal (AJAX) confirmations, where a
normal page‑view event would never fire.

It works by adding a single **Webform handler** you attach to any individual form.
The handler has just one setting: a small **YAML** snippet describing the object to
push to `dataLayer` — for example an event name plus a few values. Webform tokens are
supported, so you can inject submitted field values, the webform's id and title, or
other submission data straight into the event. On submit, the module resolves those
tokens and pushes the resulting object to `dataLayer`.

Because the handler has unlimited cardinality, you can attach several to one form to
push different events, and you can copy the same YAML across many forms to
standardize your event schema. There is no global settings page, no permissions of
its own, and no Drush — everything is configured per form on the handler.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside its Webform and Datalayer dependencies.
2. [Configuration](configuration/index.md) — add the handler to a form and write the
   event YAML.

## How to use it

There's no admin menu item. You configure it per webform: edit a form, go to its
**Settings → Emails / Handlers** tab, add the **Datalayer Webform** handler, and fill
in the event YAML. See [Configuration](configuration/index.md) for the details.

One important dependency note: the global `dataLayer` array itself is set up by the
separate [Datalayer](https://www.drupal.org/project/datalayer) module (typically
wired to your Google Tag Manager container). Make sure that module is enabled and
configured so your pushed events are actually consumed.
