# Language Switcher Enhanced — manual setup guide

**Language Switcher Enhanced** (`language_switcher_enhanced`) fixes what core's
language switcher does with content that is **not translated into every
language**. Core lists every enabled language and links each one to the equivalent
path — whether or not a translation actually exists there. On a site where every
page is translated that is fine. On a real multilingual site — where the news
archive is translated, the policy pages are, and the eight hundred older articles
are not — it produces links that lead to the untranslated original, to a 404, or
to a page in a language the visitor never asked for. The last is also an SEO
problem, because search engines follow the switcher and index whatever they find.

This module supplies the missing behaviours: for a language with no translation of
the current page, it can **hide** that language from the switcher, **mark it as
unavailable** (disable it), or **redirect** somewhere sensible. It has no
dependencies and targets Drupal 10 and 11.

Which behaviour to choose is a genuine decision, not a default to accept:

- **Hide** gives a clean switcher, but the set of languages then *shifts from page
  to page*, which is disorienting once a visitor has learned where the control is.
- **Disable / mark unavailable** keeps the switcher stable and tells the truth
  about what exists — usually the better answer for a public site.
- **Redirect** is the one to be careful with. Sending a visitor to a language
  homepage because their language lacks *this* page loses their place, and doing
  it as an actual redirect rather than a link confuses search engines about which
  URL is canonical.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — choosing the behaviour for
   untranslated languages.

## Where it lives in the admin menu

The module has no standalone settings page. Its behaviour is chosen on the
**language‑switcher block**, which you manage under **Structure → Block layout**
(`/admin/structure/block`). See [Configuration](configuration/index.md).
