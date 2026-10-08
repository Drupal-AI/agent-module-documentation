# Cookie Content Blocker — manual setup guide

**Cookie Content Blocker** (`cookie_content_blocker`) stops privacy‑impacting content —
YouTube/Vimeo embeds, Google Maps iframes, social widgets, tracking pixels, third‑party
scripts — from loading until the visitor has given cookie consent. In place of the embed it
shows an inert placeholder with a message and an optional "Show content" button, and reveals
the real content once consent is detected. This is a common building block for GDPR / ePrivacy
compliance.

Importantly, this module **does not manage consent itself** — it needs a **separate cookie
consent manager** (such as Klaro, Cookiebot, or any script that sets a cookie or fires an
event). You tell Cookie Content Blocker how your consent manager signals "accepted / declined /
changed", and it does the blocking and un‑blocking. It works by moving the original HTML into an
inert `<script type="text/plain">` tag so the browser never fetches its images, iframes, or
scripts; front‑end JavaScript swaps the real content back in when consent is present.

You can block content three ways: a **text filter** with a CKEditor 5 button (wrap any HTML in
the editor), a render‑array property for developers, and — via the bundled **Media** submodule —
a per‑provider oEmbed formatter. A global settings form controls the default message, the
button, and the all‑important "consent awareness" mapping, and you can define **cookie
categories** (e.g. "marketing", "statistics") so different content reveals on different consent
signals. It depends on the [js_cookie](https://www.drupal.org/project/js_cookie) module.

This guide is written for a **human** clicking through the admin UI. If you want the blocking
internals, the render property, the filter's `data-settings` and the extension points for an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs.

## Contents

1. [Installation](installation/index.md) — install the module (and its `js_cookie` dependency),
   enable it, and optionally enable the Media submodule.
2. [Configuration](configuration/index.md) — the global settings form, consent‑awareness
   mapping, cookie categories, the text filter and CKEditor button, field by field.

## Where it lives in the admin menu

- **Settings:** **Configuration → User interface → Cookie Content Blocker**
  (`/admin/config/user-interface/cookie-content-blocker`).
- **Cookie categories:** the *Categories* list under the same page
  (`…/cookie-content-blocker/categories`).
- **Text filter & CKEditor button:** enabled per text format at **Configuration → Content
  authoring → Text formats and editors** (`/admin/config/content/formats`).

## How to use it

The most common setup is: enable a consent manager, map it under *consent awareness*, then let
editors block embeds in the WYSIWYG:

1. Install and configure a separate consent manager, and map its signals on the Cookie Content
   Blocker settings form (see [Configuration](configuration/index.md)).
2. On a text format, enable the **Cookie Content Blocker** filter (run it **last**) and add the
   **CookieContentBlocker** button to the CKEditor 5 toolbar.
3. While editing content, select an embed or block of HTML and click the toolbar button to wrap
   it — it now shows a consent placeholder until the visitor accepts.
