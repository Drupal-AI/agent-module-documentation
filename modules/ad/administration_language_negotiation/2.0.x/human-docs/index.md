# Administration Language Negotiation — manual setup guide

**Administration Language Negotiation** (`administration_language_negotiation`)
lets you keep the back office in one language while the public site runs in
another. It adds an extra interface-language detection method — called
"Administration language" — that forces administration pages (and, by default,
node add/edit and translation forms) into each user's preferred admin language,
regardless of what language the front end is showing.

Out of the box the module does not change anything until you switch the detection
method on and place it above Drupal's other interface-language methods. Once it is
active, any user who holds the *Administration language negotiation* permission
gets their chosen admin language on the pages you have defined as "admin
locations". Which locations count as admin is up to you: a list of path patterns
(defaulting to `/admin`, `/admin/*`, node add/edit/translation paths, and so on),
an option to treat *every* admin route as admin, and an optional fallback to the
site default language. Each user's own choice is stored in the core
**"Administration pages language"** field, which the module unhides on the user
edit form for permitted users.

The module depends on core's **Locale** module, adds one permission, and defines
a small plugin type (admin-location "conditions") so developers can add their own
matching rules. It ships no submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — turn on and order the detection
   method, choose which paths count as admin, grant the permission, and set each
   user's preferred admin language.

## Where it lives in the admin menu

The module's own settings form is at **Configuration → Regional and language →
Languages → Detection and selection → Administration language**
(`/admin/config/regional/language/detection/administration_language`). You enable
and reorder the detection method one screen up, on the **Detection and selection**
page itself.
