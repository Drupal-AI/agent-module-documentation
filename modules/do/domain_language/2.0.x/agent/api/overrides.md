<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the restriction is actually applied

Three independent mechanisms; know which one you are debugging.

## 1. `DomainLanguageOverrider` — config factory override

Registered in `domain_language.services.yml`:

```yaml
domain_language.overrider:
  class: Drupal\domain_language\DomainLanguageOverrider
  tags:
    - { name: config.factory.override, priority: -140 }
```

`loadOverrides($names)` only acts when a domain is active (`domain.negotiator`, forced with
`getActiveDomain(TRUE)` if the first call is too early in bootstrap) and only for two config names:

- **`system.site`** — delegates to `domain_config.overrider` and returns its override, so the
  domain's `default_langcode` applies.
- **`language.negotiation`** — reads `domain.language.{domain}.language.negotiation:languages`;
  if non-empty it nulls `url.prefixes` and `url.domains` in the override *and* (at nesting level 1
  only) writes the filtered lists into the global `$config` variable, intersecting the site's
  prefixes/domains with the allowed languages. The `$config` write is the part that actually takes
  effect — the comment in the code points at core issue 2829242 (no alter mechanism for removing
  array entries in overrides).

Both branches are skipped entirely when the current user has **`bypass language restrictions`**.

`getCacheSuffix()` returns the domain id, and `getCacheableMetadata()` adds the `url.site` cache
context, so overridden config is cached per domain.

## 2. Swapped `language.default` service

`DomainLanguageServiceProvider::alter()` replaces the class of core's `language.default` service
with `Drupal\domain_language\LanguageDefault`.

```php
// LanguageDefault::get()
$language = parent::get();
if ($domain = \Drupal::service('domain.negotiator')->getActiveDomain()) {
  // Read the raw config, NOT through config.factory overrides — avoids an infinite loop
  // back through DomainLanguageOverrider.
  $default_langcode = \Drupal::config("domain.config.{$domain->id()}.system.site")->get('default_langcode');
  if ($default_langcode !== NULL && $language->getId() !== $default_langcode) {
    $language = $this->getLanguage($default_langcode);
    \Drupal::languageManager()->reset();
    \Drupal::translation()->setDefaultLangcode($language->getId());
  }
  $this->languageDomain = $language;
}
```

Notes for anyone extending this:

- The resolved language is memoised in `$languageDomain`; `set()` writes to it once it exists, so
  a later `set()` does **not** change the site-wide default any more.
- `getLanguage()` builds a `Language` object straight from `language.entity.{langcode}` config
  (mapping `label` → `name`), bypassing the language manager.
- A `ServiceCircularReferenceException` is swallowed — the code notes it "seems to occur only in
  command line", so on CLI the domain default may silently not apply. Pass `--uri` and verify.

## 3. Language switcher filtering

`domain_language_language_switch_links_alter(&$links, $type, $path)` runs for
`$type === 'language_interface'` only:

```php
$domain = \Drupal::service('domain.negotiator')->getActiveDomain();
$languages = \Drupal::configFactory()
  ->get('domain.language.' . $domain->getOriginalId() . '.language.negotiation')
  ->get('languages');
if (!empty($languages)) {
  $links = array_intersect_key($links, $languages);
}
```

So the **interface** switcher is filtered; a `language_content` or `language_url` switcher block
is not touched.

## Extending

- To add your own per-domain language rule, register another `config.factory.override` with a
  priority lower than −140 (runs later) and read the same two config objects.
- Do not call `config.factory` for `domain.config.*.system.site` from inside an override —
  follow `LanguageDefault`'s example and use `\Drupal::config()` on the raw name to avoid
  recursion.
- `hook_domain_operations()` is where the *Languages* link on the domain list comes from; add
  your own operations the same way.
