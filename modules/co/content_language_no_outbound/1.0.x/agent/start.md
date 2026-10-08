<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content language detection (no outbound) — agent index

A **content-language negotiation plugin** that subclasses core's
`LanguageNegotiationContentEntity`. It reads the content language from the
`language_content_entity` query parameter (inherited from the parent), but overrides
which outbound URLs receive that parameter: by default it adds it to **no** links, and
optionally to only the entity link-template paths you name in config. Info.yml name
**"Content language detection (no outbound)"**. Installed **1.0.0-rc2** (version dir
`1.0.x`). Core `^10 || ^11`. License GPL-2.0-or-later. Composer name (repo)
`neocosmo/content_language_no_outbound`; installs as `drupal/content_language_no_outbound`.

## Dependencies

- Drupal modules: core `language` (the plugin extends
  `Drupal\language\Plugin\LanguageNegotiation\LanguageNegotiationContentEntity` and uses
  its `LanguageNegotiation` attribute). No explicit `dependencies:` key in info.yml.
- PHP libraries: none (`composer.json` `require` is only `drupal/core: ^10 || ^11`).

## The problem it solves (from README)

Core's "Content language" negotiator reads `language_content_entity` **and** appends it
to generated links, which makes a language switcher on a node page change the *content*
language instead of the *interface* language. This module keeps the read side but stops
(or narrows) the write side, so the switcher's behaviour is left entirely to other
modules / your own logic. Intended use: editors change node-translation content language
in the backend via the query param, while the front-end switcher only ever changes the
interface language.

## What it provides (from source)

- **Language negotiation plugin** `language-content-entity-no-outbound`
  (`src/Plugin/LanguageNegotiation/LanguageNegotiationContentEntityNoOutbound.php`).
  `#[LanguageNegotiation]` attribute: name "Content language (no outbound)",
  `types: [TYPE_CONTENT]`, `weight: -10`,
  `config_route_name: content_language_no_outbound.negotiation_content_entity`.
  Class constant `METHOD_ID = 'language-content-entity-no-outbound'`.
  - `getLangcode()` / query-parameter reading are **inherited unchanged** from the core
    parent — this subclass does not touch content-language *detection*.
  - It overrides only **`meetsContentEntityRoutesCondition(Route, Request)`**, the parent
    hook that decides whether the `language_content_entity` query param is appended to a
    given outbound route during path processing. This override returns `TRUE` only when
    the outbound route's entity **link-template name** (e.g. `edit-form`, `canonical`) is
    listed in the module's config; otherwise `FALSE`. Empty config ⇒ always `FALSE` ⇒
    the param is never emitted.
  - `getContentEntityPaths()` builds a map of every content-entity link-template *path
    pattern* → *link name*, by scanning all entity-type definitions that implement
    `ContentEntityInterface` (`array_flip(getLinkTemplates())`).
  - `getOutboundEntityPaths()` reads config `content_entity_path_names`, splits it on
    newlines (`preg_split('/\r|\n/', …, PREG_SPLIT_NO_EMPTY)`) into a self-keyed set of
    link-template names.
- **Config form** `NegotiationContentEntityForm` (`src/Form/`), a `ConfigFormBase`
  marked `@internal`. Single field `content_entity_path_names` (textarea, one entity
  link-template name per line) bound via `#config_target` to
  `content_language_no_outbound.negotiation:content_entity_path_names`. `buildForm()`
  calls `$form_state->setRedirect('language.negotiation')`, so saving returns to the
  core language-detection page.
- **Route** `content_language_no_outbound.negotiation_content_entity`
  (`.routing.yml`): path
  `/admin/config/regional/language/detection/content-entity-no-outbound`, `_form` the
  above, requirement `_permission: 'administer languages'` (core permission — the module
  defines none of its own).
- **Editable config object** `content_language_no_outbound.negotiation`, key
  `content_entity_path_names` (string/textarea). No `config/install`, no
  `config/schema` file ships with the module.

## How to use

1. Enable the module, then go to **Configuration → Regional and language → Languages →
   Detection and selection**. Under **Content language**, enable **"Content language
   (no outbound)"** and disable core **"Content language"** (do not run both).
2. Optional: on the negotiator's own config page
   (`/admin/config/regional/language/detection/content-entity-no-outbound`, needs
   *administer languages*) list entity link-template names (one per line, e.g.
   `edit-form`) in **Outbound entity path names** to re-enable appending
   `language_content_entity` to links for *those* paths only. Leave empty (default) for
   the "never emit" behaviour the module name implies.

## Notes / gotchas

- The module name and README emphasise "no outbound", but the behaviour is
  **configurable, not absolute**: the `content_entity_path_names` textarea re-adds the
  param to the named link-template paths. Default (empty) = never added.
- Detection semantics are core's — this is a thin subclass changing only outbound path
  processing.
- No install/update hooks, services file, `.module` file, permissions, or Drush
  commands. This index covers the full surface; no subdocs warranted.
