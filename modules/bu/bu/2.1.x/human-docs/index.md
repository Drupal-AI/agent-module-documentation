# Browser update — manual setup guide

**Browser update** (`bu`) shows visitors on outdated browsers a small, dismissible
"please update your browser" notice. It's a thin, no-dependency Drupal wrapper around
the maintained **browser-update.org** script: the module decides *when* and *where*
the message should appear and hands the details to that script, which does the actual
browser detection and renders the notice on the client.

Enabling the module doesn't put the notice everywhere by default — it ships with
sensible defaults (for example, it stays off admin pages) and a settings form where
you tune everything. From that one form you control which browsers and versions
trigger the message (e.g. "more than 4 versions behind Chrome"), where it appears
(top, bottom, or corner), whether to include mobile or insecure browsers, the wording,
reminder timing, and more. It depends only on Drupal core.

One thing to be aware of: by default the message is powered by a script loaded from
`browser-update.org`. If you'd rather not call an external host, you can point the
`source` / `show_source` settings at a self-hosted or CDN copy of the script.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form, field by field.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → Browser update**
(`/admin/config/system/browser-update`), gated by the core **Administer site
configuration** permission. Tip: append `#test-bu` to any URL, or turn on **Test
Mode**, to force the notice so you can preview it while configuring.
