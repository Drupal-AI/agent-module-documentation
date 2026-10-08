# Mailto UI — manual setup guide

**Mailto UI** (`mailtoui`) is a lightweight front-end enhancement for ordinary
`mailto:` email links. Normally, clicking an email link hands off to whatever
mail client the visitor's operating system has configured — which does nothing
useful if they have none set up. Mailto UI replaces that with a small, friendly
modal that offers real choices: open the message in a popular webmail service
(Gmail, Outlook, Yahoo) or copy the address to the clipboard.

It's ideal for static or brochure sites where you'd rather not build a full
"Contact Us" form. Enable it, mark up your email links, and visitors get a better
experience with zero server-side configuration. Under the hood it simply wraps
the standalone [MailtoUI](https://mailtoui.com) JavaScript library and attaches
it to every page.

The module is **JavaScript-only**. There is no settings form, no routes, no
permissions, and no dependencies — nothing to configure in the admin UI at all.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** for this module — it has no settings form.
Once enabled you activate it per-link, described in "How to use it" below.

## Where it lives in the admin menu

Mailto UI adds no admin page. It works purely on the front end by attaching its
JavaScript library to every page.

## How to use it

After enabling the module, tell it which email links to enhance by adding the
`mailtoui` class to each `mailto:` link:

```html
<a class="mailtoui" href="mailto:hello@example.com">Contact us</a>
```

That's all it takes — links carrying the `mailtoui` class will open the Mailto UI
modal when clicked, giving visitors the webmail and copy-to-clipboard options.
Add the class to your contact, footer, or author links wherever a nicer email
experience helps.
