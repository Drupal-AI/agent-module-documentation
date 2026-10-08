# Newsletter Signup Block — manual setup guide

**Newsletter Signup Block** (`newsletter_signup_block`) gives you drop‑in blocks
for a newsletter signup form, so you can invite visitors to subscribe from any
region of your site without building a form from scratch. It ships two block
plugins: a **built‑in signup form** for the lightweight case, and a
**Webform‑backed** variant that embeds a Webform you have already built — handy
when you want Webform's confirmation messages, spam controls, and submission
handlers.

Each block lets you add a heading, a description, and an optional (responsive)
image alongside the form, and it can be styled through the module's bundled
library. Because it leans on core's **Media**, **Image**, **Responsive Image**,
and **Token** modules for the imagery and text personalisation, those are
required dependencies, and **Webform** is a hard dependency too (it powers the
Webform‑backed variant).

There is **no settings page** for this module — everything is configured on the
block itself through Drupal's standard **Block layout** UI when you place it.
Submissions are handled either by the built‑in form or by the normal Webform
submission pipeline; to actually deliver addresses to an email service provider,
pair the Webform variant with a Webform handler for your provider.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it and its dependencies.

There is **no configuration page** for this module — it has no settings form. You
set it up entirely when you place the block, described in "How to use it" below.

## How to use it

Once the module is enabled, place a signup block like any other block:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in the region where you want the signup form (a footer
   or sidebar is common).
3. Choose one of the two blocks:
   - **Newsletter signup form** — the module's own built‑in form, ideal when a
     full Webform is overkill.
   - **Newsletter signup (Webform)** — embeds a Webform you select, reusing that
     form's handlers, confirmations, and spam protection.
4. In the block's configuration, set the **heading** and **description** text,
   optionally pick an **image** (and an image style / responsive image style),
   and — for the Webform variant — choose which **Webform** to embed.
5. Use the standard block **visibility** settings to limit the block to certain
   pages, or to show it only to anonymous visitors, and then **Save block**.

You can place the block in more than one region, or add several copies with
different copy to A/B test your messaging.

> **Delivering subscribers to an email service:** the built‑in form collects
> submissions, but to push addresses to a provider such as Mailchimp or a CRM,
> use the Webform‑backed variant and attach the appropriate **Webform handler**
> to your chosen Webform.
