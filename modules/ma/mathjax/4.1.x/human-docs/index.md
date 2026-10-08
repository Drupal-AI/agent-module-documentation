# MathJax — manual setup guide

**MathJax** (`mathjax`) loads the MathJax JavaScript library on your site so that
LaTeX/TeX and MathML written inside delimiters — such as `$…$`, `$$…$$`, `\(…\)`
and `\[…\]` — is typeset as real, crisp mathematics in the visitor's browser.
Nothing is rendered on the server; the maths is drawn client-side as the page
loads, so authors can write formulas in plain text and readers see properly
formatted equations.

The module is essentially three things: a settings form, a **text-format filter**
(so you can turn maths on for just one format, like *Full HTML*), and the MathJax
JavaScript itself. The recommended way to run it is **Text Format mode**: you add
the *MathJax* filter to a text format, and only fields using that format get
scanned for maths — comments and other content are left alone. There is also a
**Custom mode** that attaches MathJax to every page and lets you paste a raw
MathJax JSON configuration.

MathJax can load its library from a CDN (the default) or from a local copy at
`/libraries/MathJax` for sites that must not call out to third parties. One
permission, **Administer MathJax**, guards the settings form.

One important caveat: this version ships defaults built around **MathJax 2.x**,
and its JavaScript uses the MathJax 2 API to re-typeset content that arrives via
AJAX. Pointing the CDN URL at MathJax 3 or 4 will load the library but break that
re-typesetting, so stick with a 2.x build unless you know what you are changing.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form field by field, the
   two modes (Text Format vs. Custom), CDN vs. local library, and how to add the
   filter to a text format.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Content authoring →
MathJax** (`/admin/config/content/mathjax`). To actually typeset maths in
content you also add the **MathJax** filter to a text format at
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`).

## How to use it

1. Enable the module.
2. Leave **Configuration type** on **Text Format** (the recommended default).
3. Go to a text format (e.g. *Full HTML*), enable the **MathJax** filter, and drag
   it to the **bottom** of the filter processing order.
4. Write a formula between delimiters in a field that uses that format — for
   example `The area is $\pi r^2$.` — and view the page. MathJax typesets it.
