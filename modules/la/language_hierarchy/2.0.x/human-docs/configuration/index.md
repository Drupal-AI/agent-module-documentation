# Configuration

Language Hierarchy has **no settings form of its own** and no permission of its
own. You configure it through Drupal's core **Language** admin forms, and each
language's parent is stored as a third-party setting on that language's
configuration entity. Everything else — the fallback across content, config,
interface strings, and path aliases — recalculates automatically whenever you
change a language.

## Setting a language's fallback parent

You have two ways to do it, and they edit the same underlying setting.

### One language at a time

1. Go to **Configuration → Regional and language → Languages**
   (`/admin/config/regional/language`).
2. Click **Edit** on the language you want to give a parent (e.g. Austrian German).
3. In the new **Translation fallback language** select, choose the parent it
   should inherit missing translations from (e.g. German), or **- none -** for no
   fallback.
4. **Save language.**

### The whole tree at once

On the same **Languages** overview page, the module adds a **Parent** column and
turns the table into a drag-and-drop hierarchy. Drag a language so it's indented
*under* another to make that other language its parent, then **Save**. This is the
quickest way to build a multi-level chain such as `es-MX → es → en`.

## How fallback then behaves

Once a parent is set, a missing translation in the child language is looked up in
the parent, then the parent's parent, and so on up the chain — before finally
reaching the site default. This applies to:

- **Content** translations (nodes, terms, etc.).
- **Configuration** translations — Views labels, field labels, menu link text.
- **Interface (locale) strings** — but only when core **Locale** is enabled.
- **Path aliases** — so URLs resolve across related languages.

The module also automatically **prevents fallback loops** (if you somehow created
a cycle, the chain walker guards against it), and it recomputes its internal
priority ordering whenever a language is added, changed, or removed, and after a
configuration import — so a deployed hierarchy "just works" on the target
environment.

There's a nice extra touch: when a page shows a translation that's only a
*fallback* of the current page's language, the module rewrites that item's link to
use the current page language, so navigation stays consistent.

## Setting it in code or with Drush

The parent is a third-party setting on the `configurable_language` entity, so you
can script it:

```php
use Drupal\language\Entity\ConfigurableLanguage;
$lang = ConfigurableLanguage::load('de-at');
$lang->setThirdPartySetting('language_hierarchy', 'fallback_langcode', 'de');
$lang->save();
```

Because it's config, you can also export it (`language.entity.<langcode>`) and
deploy it with the rest of your configuration.

## Verifying the effective chain

There's no config value to inspect for the *resolved* order — ask the language
manager instead:

```bash
drush php:eval 'print implode(",", array_keys(\Drupal::languageManager()->getFallbackCandidates(["langcode" => "de-at"])));'
```

For a `de-at → de` chain this prints the resolved candidate order, e.g.
`de-at,de,en,und`.

## The two Views handlers

On any content View whose base has a language filter, the module adds two handlers
you can use to surface the best translation per item:

- **Content language relevance** (a sort) — orders rows by how relevant each row's
  language is to the current content language within your hierarchy. Add it to show
  the most specific translation first.
- **Most relevant translation (using fallback)** (a filter) — collapses the View
  to a single row per item: the one translation that's most specific to the
  viewer's language along the fallback chain. Language-neutral items are kept.

Both rely on your languages having their fallback hierarchy configured; with no
hierarchy set they simply fall back to Drupal's normal weight-based ordering.
