# Webform Spam Words — manual setup guide

**Webform Spam Words** (`webform_spam_words`) blocks Webform submissions whose text
fields contain words you have flagged as spam. It is a lightweight keyword
blocklist — a simple way to stop a contact or feedback form from accepting messages
stuffed with terms like "casino" or "Click Here," without installing a CAPTCHA or a
third-party anti-spam service. You can use it on its own or as an extra layer
alongside Honeypot or reCAPTCHA.

The important thing to understand up front is that the module has **two separate
pieces that do not talk to each other**:

1. A **global settings form** where you can type a default list of spam words, an
   error message, and the field names to check. This form only stores *defaults for
   itself* — nothing in the module reads it to automatically protect any webform.
   Think of it as a scratch pad / starting point you copy from.
2. A **submission handler** you attach to a specific webform. This is the part that
   actually does the blocking. Nothing gets checked until you add this handler to a
   form and give it real settings.

So configuring the global form alone has no effect. Real spam blocking happens only
once the handler is attached to a webform. The module requires **Webform** 6.3+ and
works on Drupal 10.3+ and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the global settings form, and (the
   part that matters) attaching and configuring the spam-words handler on a webform.

## Where it lives in the admin menu

- The global default-words form is at **Configuration → Webform → Webform Spam
  Words** (`/admin/config/webform/webform-spam-words`).
- The handler is added per form, under **Structure → Webforms → (your webform) →
  Settings → Handlers**.
