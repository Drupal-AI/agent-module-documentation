# Webform Simplenews Handler — manual setup guide

**Webform Simplenews Handler** (`webform_simplenews_handler`) connects Webform to
Simplenews. It adds a **Submission Newsletter** handler that you attach to any
webform; when the form is submitted, the email address from that submission is
subscribed to (or unsubscribed from) one or more Simplenews newsletters.

The point is to turn any richer form — one that also collects a name, company,
region, or preferences — into a newsletter signup, instead of relying on
Simplenews's bare email-only subscription block. Because it runs through
Simplenews's own subscription manager, it keeps Simplenews's **double opt-in**
behaviour: new anonymous subscribers are set to *unconfirmed* and sent a
confirmation email, unless Simplenews is configured to skip confirmation.

The whole module is this one handler. It has no settings page, no permissions, and
no configuration of its own — you add and configure it per webform, and it plugs
into Webform's existing handler-administration permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (Webform and Simplenews are required).

## Where it lives in the admin menu

There's no central admin page. You work with the handler on each webform:

- **Structure → Webforms → (your form) → Settings → Emails / Handlers**, then
  **Add handler → Submission Newsletter** (listed under the "Newsletter"
  category).

## How to use it

1. Install and enable the module, plus Webform and Simplenews (see
   [Installation](installation/index.md)), and create at least one Simplenews
   newsletter.
2. Edit the webform you want to use as a signup form and go to **Settings →
   Emails / Handlers → Add handler**.
3. Choose **Submission Newsletter** and configure the handler instance:
   - **When to run it** — which submission states trigger the subscription:
     *draft*, *converted* (anonymous → authenticated), *completed* (the default),
     and *updated*.
   - **Email element** — which form element supplies the subscriber's email
     address (or "Default").
   - **Newsletters** — one or more target newsletters to subscribe/unsubscribe.
   - **Action** — **Subscribe** or **Unsubscribe**.
4. Save. You can add **several** Submission Newsletter handlers to one form (the
   handler has unlimited cardinality) — for example, one that subscribes to a
   general list and another mapped to an optional-interest checkbox, or a separate
   unsubscribe handler.

On submission, for each selected newsletter the handler calls Simplenews's
subscription manager with the submitter's email, then (unless Simplenews is set to
skip confirmation) marks new subscribers *unconfirmed* and sends them the
Simplenews confirmation email — preserving proper double opt-in.
