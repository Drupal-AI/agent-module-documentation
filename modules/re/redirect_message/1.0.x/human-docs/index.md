# Redirect Message — manual setup guide

**Redirect Message** (`redirect_message`) lets you attach a message to any
redirect (from the contrib Redirect module) that is shown to the visitor once
they land on the destination page. It is a small, friendly touch for redirects
that need a word of explanation — telling people a page has moved, been renamed,
replaced, or deprecated, rather than silently sending them somewhere new.

The module adds two fields to each redirect: a **message** (formatted long text)
and a **message type** — status, warning, or error, which controls how the
message is styled when it appears. When the redirect fires, the message is shown
through Drupal's standard Messenger service, so it looks exactly like any other
system message on the page. Leave the message blank and the redirect stays silent
as before.

One thing to keep in mind: the message is authored by whoever can edit redirects
and is rendered through its chosen text format. That means XSS exposure is bounded
by that format's filters — so grant redirect-edit access only to trusted roles,
and avoid handing untrusted authors a full-HTML text format. The module adds no
routes or permissions of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the Redirect
   module it depends on, and enable it.

There is **no dedicated configuration page** for this module — you author the
message on the standard redirect add/edit form, described in "How to use it"
below.

## How to use it

1. Go to the Redirect admin at **Configuration → Search and metadata → URL
   redirects** (`/admin/config/search/redirect`) and add or edit a redirect the
   usual way.
2. On the redirect's add/edit form you will find the two fields this module adds:
   - **Message** — the text to show the visitor after the redirect. It is a
     formatted long-text field, so you pick a text format for it. Leave it empty
     for a silent redirect.
   - **Message type** — choose **status**, **warning**, or **error** to control
     how the message is styled.
3. Save the redirect. When a visitor is redirected, the message is pushed to
   Drupal's Messenger and appears on the page they land on.

> **Tip:** keep the message safe by using a **restricted text format** for
> redirect messages, and only give redirect-edit permission to roles you trust —
> the message is rendered as markup.
