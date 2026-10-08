# Admin User Language — manual setup guide

**Admin User Language** (`admin_user_language`) keeps the back end of a
multilingual site in one consistent language. On a site with several languages,
every user has an *administration pages language* that defaults to
"- no preference -", which can leave the admin UI showing up in unexpected
languages. This module forces a language you choose onto users' administration
language when their account is created or updated, so your editors and
administrators all get the same back‑office language.

You pick the target language on a small settings form, and you decide how firmly
to enforce it. As a **soft default**, the language is only applied to *new*
users, and each person can still change their own admin language afterwards. As a
**hard lock**, the language is re‑applied every time an account is saved and the
*administration pages language* field on the user form is disabled, so users
can't change it at all. You can also choose to mirror each user's own site
language into their admin language instead of forcing a single fixed one.

One important caveat: this module sets each user's *stored* preference — it does
not itself switch the admin interface language at request time. For the admin UI
to actually render in the forced language you should pair it with a language
negotiation module such as `admin_language_negotiation`. The module only makes
sense on a site with two or more active languages.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the two settings that control which
   language is forced and how strictly.

## Where it lives in the admin menu

The settings form is at **Configuration → Admin User Language settings**
(`/admin/config/admin_user_language/settings`). Access to it is gated by the
**Administer admin interface language** permission.

## How to use it

Make sure your site has at least two languages, then open the settings form,
choose the language you want the back end to run in, and decide whether users may
override it. Save. From then on, matching users get that administration language
automatically — new accounts always, and existing accounts too if you turned on
the override lock. Add `admin_language_negotiation` alongside it so the interface
actually appears in that language.
