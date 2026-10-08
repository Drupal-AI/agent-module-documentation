# Language Switcher: Language Code — manual setup guide

**Language Switcher: Language Code** (`language_switcher_langcode`) does one small,
useful thing: it changes the links in Drupal's core **Language switcher** block to
show the uppercased **language code** instead of the full language name. So
"English" becomes **EN**, "French" becomes **FR**, "Português (Brasil)" becomes
**PT-BR** — and the full name is kept as the link's hover tooltip (its `title`
attribute) so nothing is lost for clarity or accessibility.

It's ideal when a long language name would wrap or crowd a tight header, footer, or
top bar, or when your design already signals "language" with a globe icon and you
just want compact tokens. The markup stays identical to core (still a list of
`<a>` links), so your existing CSS and JavaScript keep working.

This is a deliberately tiny module — a single hook, with **no configuration page,
no settings, and no permissions**. You enable it and it works everywhere Drupal
builds language-switch links. It depends only on core's **Language** module. If you
need dropdowns, flags, or per-link customization, the project's own README points
to fuller alternatives like `language_switcher_extended`, `dropdown_language`, and
`language_switcher_enhanced`.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

## Where it lives in the admin menu

It has no settings page. The only related admin screen is core's **Block layout**
(**Structure → Block layout**, `/admin/structure/block`), where you place the
**Language switcher** block whose links this module rewrites.

## How to use it

1. Make sure your site has **at least two configured languages** with URL or
   interface language negotiation set up (that's what makes the core Language
   switcher block produce links).
2. Enable this module (see [Installation](installation/index.md)).
3. Place the core **Language switcher** block in a region via **Structure → Block
   layout**, if it isn't already.
4. View the site — the switcher now shows uppercase codes (EN, FR, DE …), with the
   full language name available on hover.

There's nothing to configure. If you'd like to confirm it's working from the
command line:

```bash
drush php:eval '
  $links = \Drupal::languageManager()->getLanguageSwitchLinks(
    \Drupal\Core\Language\LanguageInterface::TYPE_INTERFACE,
    \Drupal\Core\Url::fromRoute("<front>")
  );
  foreach ($links->links as $code => $l) { print $code . " => " . $l["title"] . "\n"; }
'
```

With the module enabled the printed titles are uppercased language codes; without
it they're the full language names. (Requires at least two configured languages.)
