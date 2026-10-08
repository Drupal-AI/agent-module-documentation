# Prelinker — manual setup guide

**Prelinker** (`prelinker`) lets you manage `preload` and `preconnect` **resource
hints** as configuration, instead of hand-editing a theme's `html.html.twig` or
writing a `hook_page_attachments()` every time you want to add one. It emits those
hints either as `Link:` **response headers** or as `<link>` elements in the page's
`<head>`, and you choose which.

Resource hints tell the browser to start work it would otherwise only discover
later. A **preconnect** opens the TCP and TLS connection to a host — a font
provider, an image CDN, an analytics endpoint — before anything on it is
requested, saving the handshake round trips that would otherwise sit in the
critical path. A **preload** fetches a specific file early so it is ready when
rendering needs it. In Prelinker, preconnect targets are their own **configuration
entities**: listable, individually editable, and exportable between environments.

A couple of things are worth knowing before you lean on it. The `Link:` header
option is the more powerful of the two — over HTTP/2 or HTTP/3 a header can reach
the browser before the HTML body arrives, which is earlier than a tag in the head.
And resource hints are a **budget, not a bonus**: every preconnect holds a
connection open and every preload competes for bandwidth with the resources that
actually decide when the page becomes usable, so four or five well-chosen hints
help while twenty is a regression.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add preconnect and preload entries,
   set visibility conditions, and choose the delivery mechanism.

## Where it lives in the admin menu

Prelinker's admin pages live at **Configuration → System → Prelinker**
(`/admin/config/system/prelinker`), the `prelinker.admin_overview` route.
