# Smart Paste — manual setup guide

**Smart Paste** (`smart_paste`) adds an intelligent **"Smart Paste" button** to
Drupal forms that uses AI to read unstructured text and fill the form's fields for
you. Copy a blob of text — an email, a message, a document, a pasted address or
contact block — to your clipboard, click Smart Paste, and the module asks an AI
model to extract the relevant pieces (names, emails, phone numbers, addresses, and
so on) and map them into the matching form fields.

The problem it targets is the tedious re-keying of information that already exists
somewhere as prose. Instead of copying each value into each field by hand, you
paste once and let the AI do the field mapping. You choose which forms show the
button, so it only appears where it helps.

It builds on the **AI** module (`ai`) for its model access, which means AI provider
credentials are handled by that module (environment-backed, not stored in this
module), and it works with whichever provider you have configured there — OpenAI,
Gemini, or another. Because each Smart Paste uses a real AI call, usage carries the
normal per-request cost and latency of your provider. The module provides its own
permission and includes CSRF protection on the paste action, so you can limit who
sees the button. It runs on Drupal 10.2+ and 11. At the time of documentation this
was an early alpha release (`1.0.0-alpha1`).

This guide is written for a **human** using and administering the site. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and make sure the AI module and a provider are ready.

## How to use it and set it up

Smart Paste depends on a working **AI** module setup: install the AI module and
configure at least one AI provider (with its credentials) before Smart Paste can do
anything. See that module's own documentation for provider setup — Smart Paste
reuses whatever you configure there.

Once the AI side is ready:

- **Grant the permission.** Smart Paste provides its own permission controlling who
  gets the button; assign it to the appropriate roles at **Administration → People
  → Permissions**.
- **Choose which forms show the button.** The module lets you target specific forms
  so the Smart Paste button appears only where you want it, rather than on every
  form.

For an editor, the feature then surfaces as a **Smart Paste button** on those
forms: copy your source text, click the button, and review the fields it fills
before saving. Because each click sends text to your configured AI provider, keep
the button scoped to trusted users and mind the provider's cost.
