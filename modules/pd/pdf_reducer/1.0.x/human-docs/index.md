# PDF Reducer — manual setup guide

**PDF Reducer** (`pdf_reducer`) shrinks the file size of PDFs as they are uploaded,
so your documents download faster and take up less disk and network. When a PDF is
uploaded to any file field — including files added through a rich‑text editor via
the *Editor file* module — the module runs it through a Ghostscript‑based PHP
library and compresses it to the "ebook" quality level, which is usually good
enough for on‑screen reading.

The behaviour is deliberately safe. If compression fails, or if the "compressed"
file would actually be *larger* than the original, the module keeps the original
and does nothing. When it does succeed, it replaces the bigger original with the
smaller version on the server and shows the uploading user a message letting them
know the file was reduced.

There is genuinely **nothing to configure**: as soon as you enable the module,
every file field gains this behaviour automatically. The one operational
requirement is that **Ghostscript must be executable on your server** — that is
what does the actual compression. The module is a small sustainability and
performance win, and is one of the recommendations of the French *General
Ecodesign Guidelines for Digital Services* (RGESN 5.7).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm Ghostscript is available.

There is **no configuration page** for this module and no settings to adjust — it
works the moment it is enabled.

## Where it lives in the admin menu

PDF Reducer adds no admin page and no settings form. It works transparently in the
background whenever a PDF is uploaded to a file field. There is nothing to visit —
just enable it (see [Installation](installation/index.md)) and make sure
Ghostscript is present on the server.
