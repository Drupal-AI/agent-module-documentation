# Hanging Conjunctions Filter — manual setup guide

**Hanging Conjunctions Filter** (`hanging_conjunctions_filter`) is a
text-format filter that cleans up a common typographic problem: single-letter
words left dangling at the end of a line. In Polish typography these "orphans"
(*sierotki*) — conjunctions and prepositions such as *a*, *i*, *o*, *w*, *z* — are
considered an error. The filter automatically glues each such word to the word
that follows it by inserting a non-breaking space (`&nbsp;`), so the little word
is pulled down to the next line along with its partner.

It works quietly and safely. When a text format that includes this filter renders
content, the filter splits the HTML into tag and text chunks so that **tags and
attributes are never touched**, and it deliberately skips the interior of `<a>`,
`<script>`, `<style>`, `<code>`, and `<pre>` elements. Inside the remaining prose
it inserts the non-breaking spaces where its word list says they belong. It has no
routes, permissions, services, or external calls — it's a pure string transform.

Out of the box the filter carries a built-in **Polish** word list and only acts on
Polish-language content (it checks the text's langcode). Other languages are
opt-in: a developer can add terms for any language by implementing
`hook_hanging_conjunction_filter_terms_alter(&$terms)` and supplying term arrays
keyed by langcode.

Two things to keep in mind. The filter is **irreversible** (it changes the
stored/rendered output), so enable it only on formats where inserting `&nbsp;` is
what you want. And because it rewrites markup, order it **after** filters that
need to run first — notably "Correct faulty and chopped off HTML."

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no standalone configuration page**. Like all Drupal text filters, you
switch it on per text format, described next.

## Where it lives in the admin menu

You enable and order the filter on a text format at **Configuration → Content
authoring → Text formats and editors**
(`/admin/config/content/formats`).

## How to use it

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Add a new text format or edit an existing one.
3. In the **Enabled filters** list, tick **Hanging Conjunctions Filter**.
4. In **Filter processing order**, move it so it runs **after** other filters that
   must process first — for example "Correct faulty and chopped off HTML."
5. Click **Save configuration**.

Because the filter only acts on content whose language has a term list, out of the
box it affects **Polish** content. For other languages, a developer must register
term arrays via `hook_hanging_conjunction_filter_terms_alter()`. Enable the filter
only on formats you trust, since it rewrites markup, and audit the built-in Polish
term list before relying on it elsewhere.
