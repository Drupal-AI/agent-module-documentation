# Title Case Suggestions — manual setup guide

**Title Case Suggestions** (`titlecasesuggestions`) automatically tidies up the
capitalisation of your article titles. As soon as an editor fills in a title, the
module rewrites it to follow recommended title-case rules — the kind of
consistent, correctly-cased headline you would expect on a polished publication —
so your team does not have to remember which words to capitalise.

Behind the scenes it does this by calling a third‑party web service,
[titlecaseconverter.com](https://titlecaseconverter.com/) (accessed through
RapidAPI). That means the module is **not** fully self-contained: before it can do
anything useful you have to sign up for the service, obtain an API key, and add
that key to your site's settings. The service has a free tier (roughly 100 API
calls a month at the time of writing), but signing up requires a credit card. The
title text you type is sent to that external service to be re-cased — worth
keeping in mind if your titles are ever sensitive.

An editor who wants to keep their own capitalisation can simply untick the box the
module adds on the edit form to opt out for that piece of content. There is
currently no button to undo an automatic re-casing once it has happened. As a
bonus, if your content type has a shorter "index title" field, the module also
copies the title into it.

There is **no settings form** in the admin UI — the one thing you must configure
(the RapidAPI key) is set directly in `settings.local.php`, as described in
[Installation](installation/index.md). The module supports Drupal 9.2, 10, and 11
and has no other module dependencies.

This guide is written for a **human** setting the module up by hand. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and add your RapidAPI key in `settings.local.php`.

## How to use it

Once the module is enabled and the API key is in place, it works while editors
type: fill in an article title and it is re-cased to the recommended title casing
automatically. To keep a title exactly as written, untick the module's opt-out
checkbox on the content edit form before saving.
