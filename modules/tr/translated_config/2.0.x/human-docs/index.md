# Translated Config — manual setup guide

**Translated Config** (`translated_config`) is a small **developer helper** that
solves one specific, annoying problem with multilingual Drupal configuration.
When a config object (say `system.site`) has translations for some keys but not
others, reading the language override directly gives you back *only* the
translated keys — everything untranslated is missing. Translated Config hands you
a single, **complete** config array for a chosen language: translated where a
translation exists, and the original value everywhere else.

It does this by merging the base config with its language override in a way that
only replaces the keys the override actually defines, so nothing is lost. The
result is wrapped in a small read-only object with a familiar `get('foo.bar')`
dot-path accessor, and it carries the correct cacheability metadata from *both*
the original and the override — so you can safely attach it to a render array
without breaking caching.

There is **nothing to configure and no admin UI** — no routes, forms,
permissions, or settings. It is purely an API you call from custom module code
(a controller, service, Twig-facing preprocess function, normalizer, and so on)
whenever you need "give me this config in language X, complete." Enable it, inject
or fetch the service, and call one method.

This guide is written for a **human** setting the module up. The real audience
for this module is developers; for a terse, code-focused reference (the service
signature and a usage example) read the sibling [`agent/`](../agent/start.md)
docs, which include copy-paste code.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

The module exposes a single service, `translated_config.helper`, with one method:

```php
/** @var \Drupal\translated_config\TranslatedConfigHelper $helper */
$helper = \Drupal::service('translated_config.helper');

// Current interface language, complete set:
$config = $helper->getTranslatedConfig('system.site');
$name   = $config->get('name');         // translated if available, else original
$front  = $config->get('page.front');   // dot-path lookup

// A specific language:
$de  = $helper->getTranslatedConfig('system.site', 'de');
$all = $de->get();                       // the full merged array
```

Pass a config object name and, optionally, a language code — omit the language and
it uses the current interface language. Call `get()` with a dot-path to read one
value, or with no argument to get the whole merged array. Use this instead of
reading the language override directly, which would omit every untranslated key.

## Where it lives in the admin menu

Nowhere — Translated Config has no admin pages, settings, or menu entries. Its
only footprint is the service it provides to code.
