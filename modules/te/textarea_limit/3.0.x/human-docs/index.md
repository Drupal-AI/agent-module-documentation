# Textarea Limit — manual setup guide

**Textarea Limit** (`textarea_limit`) caps how many characters can be typed into
selected textarea widgets and shows a live counter, so a summary field that is
meant to fit a card stops turning into three paragraphs. You pick which widgets
are limited, set a global character limit (or a per-field one), and editors see
how many characters they have left as they type.

Length constraints are usually a design requirement rather than a data one: a
teaser must fit a card, a meta description must fit a search result, a strapline
must not wrap onto three lines. Drupal's field settings offer a maximum length on
some field types and nothing at all on textareas, so the rule tends to live in a
style guide that nobody reads while typing. Textarea Limit makes the limit
visible and enforced in the editor: it provides a settings form to choose which
widgets are limited and supplies the counter through its own CSS and JavaScript
library. It depends only on core and runs on Drupal 9, 10 and 11, with its own
`administer textarea_limit` permission so the limits can be tuned by an editorial
lead rather than only a full site administrator.

**One important limitation to be clear about:** a JavaScript counter is an
editorial *aid, not validation*. It guides the person typing, but anything that
submits without running the script — a programmatic save, a content import, a
REST or JSON:API write — is unaffected. Where the limit must genuinely hold, pair
this with a server-side length constraint on the field itself. Also note that it
overlaps with the **`maxlength`** module, which covers similar ground; do not run
both on the same widget — pick one.

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the global limit and choose
   which textarea widgets are limited.

## Where it lives in the admin menu

The global settings are at **Configuration → Content authoring → Textarea Limit**
(`/admin/config/content/textarea-limit`), reachable by users with the
`administer textarea_limit` permission. Which widgets are limited (and any
per-field override) is then set on each field's form-display options.
