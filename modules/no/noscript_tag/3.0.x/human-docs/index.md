# Noscript Tag — manual setup guide

**Noscript Tag** (`noscript_tag`) shows a message to visitors whose browser has
JavaScript disabled, by rendering your configured content inside a standard HTML
`<noscript>` block. Because a `<noscript>` element is only displayed when
JavaScript is unavailable, the notice appears exactly for the people who need it and
stays invisible to everyone else.

It solves a small but real problem on JavaScript‑dependent sites: when a visitor
has scripting turned off (or blocked), interactive features silently break and the
experience degrades with no explanation. With this module a site admin can put a
message — plain text or markup — at the top of the site telling those visitors to
enable JavaScript, pointing them to a supported browser, or providing fallback
instructions or contact details.

The message and who sees it are controlled from an admin settings form, and the
content is stored as exportable configuration (`noscript_tag.settings`), so you can
update it without touching theme code. The module has two permissions:
**administer noscript tag** (who may configure it) and **view noscript tag** (who
the tag is shown to). It has no third‑party dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the noscript message and control
   who sees it.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Development → Noscript
Tag** (`/admin/config/development/noscript-tag-setting`), gated by the *administer
noscript tag* permission.
