# Configure User Account Language Negotiation

The module has **no settings form**. Its `configure` route is core's negotiation page:
**Configuration → Regional and language → Detection and selection**
(`/admin/config/regional/language/detection`). There you enable the plugin **User account saver**
for the language type(s) you want (Interface text is the usual one) and set its weight.

Requires: multilingual site with core `language` + `locale` and ≥ 2 configured languages.

## Recommended setup (from the maintainer)

For a deterministic "remember my language" experience, make **User account saver** the ONLY enabled
plugin for *Interface text language detection*, then save. Provide a way to switch languages — e.g.
place core's **Language switcher** block (`/admin/structure/block`).

Drush equivalent (enable only this plugin for the interface type):

```php
// drush php:eval
$c = \Drupal::configFactory()->getEditable('language.types');
$c->set('negotiation.language_interface.enabled', ['language-user-account-saver' => 0])->save();
```

## What the plugin does per request (`LanguageNegotiationUserAccountSaver`)

- **`getLangcode()`** — extracts the first path segment as a prefix, then loops the site's languages
  comparing each against `language.negotiation` `url.prefixes.<langcode>`:
  - A language configured **with** a prefix matches when the path prefix equals it.
  - A language configured **without** a prefix matches when the request has `?language=<langcode>`.
  - On a match for an **authenticated** user it loads the account and does
    `->set('preferred_langcode', $langcode)->save()` — but only when
    `session_handler.write_safe` reports the session is writable (this skips the save while the user is
    temporarily switched by core's `AccountSwitcher`, e.g. during impersonation/queue runs).
  - On a match for an **anonymous** user it stores the langcode in `$_SESSION['language-anon']`.
  - With no prefix/query match it falls back to `parent::getLangcode()` (core's `preferred_langcode`
    lookup), or to a previously stored `$_SESSION['language-anon']` for anonymous.
- **`processInbound()`** — strips a recognized language prefix from the inbound path so routing works.
- **`getLanguageSwitchLinks()`** — builds switch links for the Language switcher block: languages with a
  prefix get an option `prefix` set (when `url.source` is `path_prefix`); otherwise the target langcode
  is added as a `?language=` query argument. Links are keyed by langcode and titled with the native name.

## Plugin metadata

- Method id: `language-user-account-saver` (constant `METHOD_ID`), weight **49**.
- Declared `types`: `TYPE_INTERFACE`, `TYPE_CONTENT`, `TYPE_URL`.
- Extends core `Drupal\user\Plugin\LanguageNegotiation\LanguageNegotiationUser` and implements
  `ContainerFactoryPluginInterface`, `InboundPathProcessorInterface`, `LanguageSwitcherInterface`.

## Install / uninstall side effects

- `hook_install` seeds locale translations of the standard language names (so each language shows in its
  own translation) via `PoDatabaseWriter`.
- `hook_uninstall` removes `language-user-account-saver` from
  `language.types` → `negotiation.language_interface.enabled` to prevent a "plugin does not exist" error.
