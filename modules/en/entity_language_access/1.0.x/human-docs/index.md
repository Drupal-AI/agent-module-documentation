# Entity Language Access — manual setup guide

**Entity Language Access** (`entity_language_access`) adds an access rule for
multilingual sites: it **denies the canonical view of a translatable content entity
when the current content language is neither the entity's original language nor an
available translation**. In plain terms, if a node only exists in English and French
and someone visits it in a language it hasn't been translated into, they get a
"forbidden" response instead of Drupal silently falling back to showing the content
in its original language.

This is useful when you don't want to translate everything immediately but also
don't want untranslated pages appearing under the wrong language. It depends only on
core's **Language** module.

How it fits the access system matters. The module implements a proper **entity
access check** that returns *forbidden* for the canonical view whenever the current
language differs from the entity's language and there is no matching translation.
Because it's an entity‑access result, it is honored by the canonical route and by any
per‑entity access check — including Views and JSON:API when they call entity access.

There are two important scope notes:

- It governs the **canonical view only**, based on language. It does **not** hide
  untranslated entities from listings. For anything that lists content — Views blocks
  and pages, feeds, search results — you must still add a filter on the translation
  language yourself, or untranslated entities will keep showing up in those lists.
- It assumes entities use the best‑practice canonical route name
  `entity.{entity_type_id}.canonical`. It won't take effect for entities that use a
  different route name for their canonical view.

Verify it composes as you expect with your particular multilingual setup, language
fallback configuration, and any API or listing paths you rely on.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

The module is active as soon as it's enabled — it applies to all translatable
content entity types that have a canonical route in all languages. There is only a
small amount of optional setup (a fallback page and two permissions), described in
"Settings and permissions" below.

## Settings and permissions

- **Optional fallback content.** Instead of a plain 403 for a missing translation,
  you can point the module at a **Node** to show as fallback content. Configure it at
  **Configuration → Region and language → Entity Language Access**. The fallback node
  must be translated into all available languages and be accessible to all users;
  otherwise visitors could hit an error or another access denial.
- **Permissions.** The module provides a permission to **bypass** its access checks
  (users with it always see the canonical view regardless of language) and a
  permission to **administer** the module's settings. Review both at **People →
  Permissions** and grant them deliberately.

## How to use it

1. Enable the module (see [Installation](installation/index.md)). The language‑based
   access check is active immediately for translatable entity types with canonical
   routes in all languages.
2. (Optional) Configure a fallback node at **Configuration → Region and language →
   Entity Language Access**, translated into every language and readable by everyone.
3. Review the bypass and administer permissions at **People → Permissions**.
4. **Remember the listings caveat:** add a translation‑language filter to your Views
   and other listings — this module does not hide untranslated entities there.
