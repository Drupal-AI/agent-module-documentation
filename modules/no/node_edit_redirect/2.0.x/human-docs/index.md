# Node Edit Redirect — manual setup guide

**Node Edit Redirect** (`node_edit_redirect`) fixes a subtle multilingual annoyance:
when you edit a node, it makes sure the edit form's URL matches the **language of the
translation you are actually editing**. It's a behind‑the‑scenes correction with no
settings — it just works once enabled.

The problem it solves comes up on sites where content language is negotiated from the
**URL** (a language prefix or domain). Normally Drupal redirects you to the correct
language prefix when editing an existing translation. But when a requested translation
doesn't exist yet, Drupal may fall back to another translation while *keeping the
requested language in the URL* — so you end up editing, say, the English node under a
`/fr/` prefix. Node Edit Redirect steps in and redirects the edit form to the URL
language that matches the translation being edited (for example `/fr/node/3` →
`/en/node/3`), so the prefix and the content line up.

Why that matters: several editing features key off the negotiated content language.
The module's own examples include relying on Views' "Current user's language" option
in the edit form (as with the entityreference_view_widget module), the i18n_select
module only showing entity references in the negotiated language, and wanting
localized taxonomy terms to appear on the edit form in the same language as on the
node. In all of these, getting the URL language right keeps the right options in view.

It's a content‑editing/multilingual UX fix with no content model or access role of its
own, and it requires no configuration. It supports Drupal 10.3 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — the module works automatically once enabled.

## Where it lives

Node Edit Redirect adds no admin page and no settings. Its effect is entirely on the
**node edit form's redirect behavior** on multilingual sites that negotiate content
language from the URL.

## How to use it

1. Confirm your site negotiates **content language by URL** (prefix or domain) under
   **Configuration → Regional and language → Languages → Detection and selection**.
2. Enable the module. From then on, editing a translation redirects the edit form to
   the URL whose language matches the translation actually being edited — no further
   action needed.
