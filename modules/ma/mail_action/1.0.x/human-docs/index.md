# Mail Action — manual setup guide

**Mail Action** (`mail_action`) adds **action plugins for sending emails with
formatted text**. Drupal core only ships a mail action that supports plain text;
this module fills the gap with two richer actions that can be used **anywhere
Drupal actions are supported** — most usefully from
[Views Bulk Operations (VBO)](https://www.drupal.org/project/views_bulk_operations)
and [ECA (Event – Condition – Action)](https://www.drupal.org/project/eca).

The two new action plugins are:

- **Send email with formatted text** — compose the message using a configured
  WYSIWYG (CKEditor) text format, so you can send nicely formatted HTML email.
- **Send email with raw HTML** — a textarea for pasting raw HTML, with additional
  support for **Tokens** and the **Twig** templating language.

It is deliberately simple — it just adds these plugins and requires only Drupal
core. It pairs naturally with VBO (email everyone in a filtered list of users) or
ECA (send a formatted notification as part of an automated flow). If you need more
extensive email functionality, look at Easy Email, Symfony Mailer, or Mail System.

> **Security caveat — this is a powerful capability.** An action that **sends email
> to users** can, if exposed through Views Bulk Operations, mass‑email recipients
> — which an untrusted user could abuse to spam people or turn the site into a mail
> relay. **Restrict the action (and any VBO view that offers it) to trusted
> roles**, and keep the email content trusted — the formatted text is authored by
> administrators.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and make sure your site's mailer transport (DSN) is configured.

There is **no central settings form** — each action is configured where you use
it (in a VBO view, or in an ECA model), described in "How to use it" below.

## Where it lives in the admin menu

Mail Action adds no admin page of its own. The two action plugins appear wherever
Drupal actions can be chosen — for example in a Views Bulk Operations field's
selected‑actions list, or as an action step in an ECA model.

## How to use it

1. Install and enable the module, and confirm your site can send mail (see
   [Installation](installation/index.md)).
2. In a **VBO** view: add the Views Bulk Operations field, and enable
   **"Send email with formatted text"** or **"Send email with raw HTML"** as an
   available action. Restrict the view/action to trusted roles.
3. In an **ECA** model: add one of the two actions as a step and configure its
   recipient, subject, and body (choosing a WYSIWYG format, or entering raw HTML
   with tokens/Twig).
4. Run the action — via the bulk‑operations form or the ECA event — to send the
   formatted email.
