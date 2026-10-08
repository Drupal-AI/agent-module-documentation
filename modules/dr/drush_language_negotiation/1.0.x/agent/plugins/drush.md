<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LanguageNegotiationDrush plugin

The module's entire behavior. File: `src/Plugin/LanguageNegotiation/LanguageNegotiationDrush.php`.
Class `LanguageNegotiationDrush extends Drupal\language\LanguageNegotiationMethodBase`.

## Definition (`@LanguageNegotiation` annotation)

- `id` = `LanguageNegotiationDrush::METHOD_ID` = constant **`language-drush`**.
- `weight` = **-99** — a very low (high-priority) weight so, once enabled, it wins over the
  other detection methods for CLI runs.
- `name` = *"Drush Language Switching to correct language"*; `description` = *"Switch to correct
  language using drush (Default language instead of ENG)"*.
- No `types` restriction in the annotation, so the method is offered for every language type
  (interface, content, etc.) on the detection page.

## Detection logic (`getLangcode()`)

```
public function getLangcode(Request $request = NULL) {
  $langcode = NULL;
  if (PHP_SAPI === 'cli') {
    $langcode = \Drupal::languageManager()->getDefaultLanguage()->getId();
  }
  return $langcode;
}
```

- The **only** condition is `PHP_SAPI === 'cli'`. `PHP_SAPI` is set by the PHP runtime from the
  server API it is running under (`cli` for command-line/Drush; `fpm-fcgi`, `apache2handler`,
  `cgi-fcgi`, etc. for web). It is **not** read from `$_SERVER`, request headers, env vars, or any
  request-controlled input.
- Under CLI it returns the **site default language id** via
  `\Drupal::languageManager()->getDefaultLanguage()->getId()`.
- For any non-CLI (web/browser) request it returns `NULL`, which tells core's language negotiator
  "no opinion" — so web requests fall through to the other enabled methods unchanged.
- No caching metadata is set or altered; the base class default applies. The plugin never
  influences web-request language, so it introduces no page-cache/language-context concerns.

## Install & enable

1. `composer require drupal/drush_language_negotiation` then `drush en drush_language_negotiation -y`
   (prefix with `ddev` when running from the host). Core's **Language** module must be enabled.
2. Enabling the module only *registers* the method; it is inactive until turned on.
3. Go to **Configuration → Regional and language → Languages → Detection and selection**
   (`/admin/config/regional/language/detection`).
4. Check **Drush Language Switching to correct language** for the language type(s) you want it to
   govern (typically Interface text, and Content if used), then order it high enough that it wins,
   and **Save settings**.
5. Verify: on a site whose default language is not English, run a Drush command that previously
   resolved to English (e.g. `drush config:import`) and confirm it now uses the default language;
   front-end language behavior is unchanged.

## Notes for callers

- There is **no module settings route** (`configure` is null) — all configuration is core's
  detection UI, which stores the enabled methods/order in core `language.types` config, not in any
  config owned by this module.
- The name is misleading: it provides **no `drush` command**, only this negotiation plugin.
