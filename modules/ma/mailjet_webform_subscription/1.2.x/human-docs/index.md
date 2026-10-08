# Mailjet Webform Subscription — manual setup guide

**Mailjet Webform Subscription** (`mailjet_webform_subscription`) adds a custom
[Webform](https://www.drupal.org/project/webform) element — a "subscribe to our
mailing list" checkbox — that, when a visitor ticks it and submits the form,
adds their email address to a chosen [Mailjet](https://www.mailjet.com/) contact
list. It's the easy way to bolt a newsletter opt-in onto any existing webform
without writing code.

Crucially, it supports a **double opt-in** flow. When someone submits the form
with the box ticked, the module emails them a confirmation link containing a
strong random token, and the address is only actually added to your Mailjet list
once they click that link. That keeps your list clean and consent-based, and the
confirmation email can be styled with a Mailjet template. You can also map extra
webform fields (first name, last name) so subscribers arrive in Mailjet with
their names attached.

The module has **no settings page of its own**. It relies on the
[Mailjet API](https://www.drupal.org/project/mailjet_api) module for your Mailjet
credentials, and everything else is configured directly on the checkbox element
inside the Webform builder. Because it sends subscriber email addresses to
Mailjet, remember that you are processing **personal data** — the double opt-in
flow exists precisely to record consent, so keep it enabled where consent is
required.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside
   Webform and Mailjet API, and enable it.

There is **no configuration page** for this module. Your Mailjet API key and
secret are set once in the Mailjet API module (at
`/admin/config/system/mailjet/api`), and each subscription checkbox is configured
where you build the form — see "How to use it" below.

## Where it lives in the admin menu

The module adds no admin page. You use it entirely from the Webform builder at
**Structure → Webforms → *(your form)* → Build**. The Mailjet credentials it
depends on live in the Mailjet API module's settings.

## How to use it

1. Make sure your Mailjet API key and secret are configured in the **Mailjet
   API** module first (`/admin/config/system/mailjet/api`).
2. Open the webform you want to add the opt-in to and go to its **Build** tab.
3. Add an **Email** element — the value entered there is used as the subscriber's
   address. (Add name fields too if you want to personalise the subscription.)
4. Add the **Mailjet Subscription** element (the checkbox). In its settings:
   - Choose the **Mailjet contact list** the subscriber should be added to.
   - Point it at which webform fields hold the email and, optionally, the first
     and last name.
   - Optionally set the success/confirmation template and a success node to show
     after confirmation.
5. Save the form. When a visitor ticks the box and submits, they receive a
   confirmation link; clicking it validates the token and adds them to the list.

You can add more than one Mailjet Subscription checkbox to the same form if you
want to offer sign-up to several different lists.
