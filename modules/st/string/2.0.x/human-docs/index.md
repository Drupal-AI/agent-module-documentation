# String — manual setup guide

**String** (`string`) is a framework for managing translatable interface
strings. It changes how developers write the text that Drupal's `t()` function
translates: instead of writing the English message itself as the translation
key (`t('Drupal is great')`), you write a short, stable keyword
(`t('drupal.great')`) and then supply the human-readable value as a translation
of that keyword. The keyword becomes the id that every language — including the
default language — translates against, so wording changes no longer break your
existing translations.

The problem it solves is a familiar one on multilingual sites: with core's
default approach, the source English string *is* the key, so editing a sentence
orphans all of its translations. String's "keyword philosophy" gives every
message a name that never changes, which makes strings easier to manage across a
large multilingual site and across a decoupled JavaScript front-end. It
integrates with core's translation API so it still works with `t()`, the Locale
import/export tools, and the interface-translation editor.

String depends on core's **Locale** module and provides its own permissions. It
is primarily a developer and translator feature — the strings are managed
content for translators, and the module carries no access-control role beyond its
permission. It ships two submodules for wider workflows: **String i18next**
(`string_i18next`) to expose strings to an i18next-based JavaScript front-end,
and **String TMGMT** (`string_tmgmt`) to feed strings into the Translation
Management Tool (TMGMT) for a managed translation workflow.

This guide is written for a **human** setting the module up and working through
the admin UI. If you are an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead — they are terser and token-cheaper.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and choose the submodules you need.

## How to use it

String has no central settings form of its own. In practice you define your
keyword strings in code (using `t()` with keyword ids, and `format_plural()` the
same way), then translate those keywords through Drupal's normal interface
translation tools under **Configuration → Regional and language → User interface
translation**. The submodules extend where those strings can travel: enable
**String i18next** to hand them to a JavaScript front-end, or **String TMGMT** to
route them through a translation-management workflow. For detailed developer
usage, the project also maintains an external documentation site linked from its
drupal.org page.
