# Prevent absolute internal links — manual setup guide

**Prevent absolute internal links** (`prevent_absolute_internal_links`) is a
single‑purpose module that adds validation to **Link** fields so editors cannot
enter internal links as hard‑coded absolute URLs. On a site at
`https://www.example.com`, a link typed as `https://www.example.com/node/999` is
rejected with a message asking the editor to use the autocomplete reference
instead (which stores the link as an internal reference such as `/node/999` or an
entity path).

Why this matters: absolute internal URLs bake your domain into your content. That
content then breaks when the domain changes, and it points at the wrong place when
copied between environments — a link entered on production can send a staging or
dev visitor straight back to production. Keeping internal links relative makes
content portable and correct across every environment.

The module validates link input **on save**. It does not change access control or
alter how links are displayed — it simply refuses to store an internal link in
absolute form. It is published under the **Newcity** package.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. The validation applies to Link
fields automatically once the module is enabled — see "How to use it" below.

## How to use it

Once enabled, the validation runs on **Link** fields when content is saved. If an
editor pastes an absolute URL that points at the site's own domain, the save is
blocked and a message prompts them to use the link autocomplete (which stores the
link as a proper internal reference) instead.

There is nothing to switch on per field — the check applies to link input across
the site. Editors simply keep using the link field's autocomplete for internal
destinations, and paste absolute URLs only for genuinely external sites.
