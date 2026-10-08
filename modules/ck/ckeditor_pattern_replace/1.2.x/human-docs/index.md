# CKEditor Pattern replace — manual setup guide

**CKEditor Pattern replace** (`ckeditor_pattern_replace`) is a **text‑format
filter** that runs a list of administrator‑defined regular‑expression
search‑and‑replace rules over a field's text when it is output. Despite the name,
it is not a CKEditor button — it is a filter you enable on a text format, and it
quietly rewrites the rendered HTML according to your rules.

You configure it as a simple list, one rule per line, in the form
`/pattern/|replacement`: the part before the `|` is a PHP regular expression, and
the part after it is the replacement text (which may be empty to simply delete
matches). The filter applies each rule in order.

It is genuinely handy for recurring cleanup and enforcement tasks. Common uses:
mask or remove foul language, redact personal data such as phone numbers or email
addresses on display, normalize typography, strip empty tags the editor leaves
behind, rewrite legacy URLs, remove tracking query strings, or enforce a house
style — all without touching the stored content.

One caveat deserves emphasis because it governs who should be allowed to set these
rules. The patterns are PHP regular expressions supplied by whoever can administer
text formats, which makes this an **admin‑trusted feature**: a malformed pattern
can break your output and a too‑broad pattern can alter markup in surprising ways.
So restrict the **Administer filters** capability to people you trust, and test
rules carefully. (For reassurance on a historical concern: PHP's old `/e` modifier
that once allowed code execution through `preg_replace` was removed in PHP 7, so
modern PHP cannot execute code through these patterns.)

The module depends on the CKEditor module and works across a wide range of Drupal
(8 through 11).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — enable the filter on a text format
   and write your `pattern|replacement` rules.

## Where it lives in the admin menu

There is no standalone settings page. You enable and configure the filter per text
format at **Administration → Configuration → Content authoring → Text formats and
editors** (`/admin/config/content/formats`). The rules live in the filter's
settings on each format. See [Configuration](configuration/index.md).
