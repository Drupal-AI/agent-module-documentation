<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Untranslated 404 (untranslated_404) — agent index

Returns the site's **404 page** when a content entity's **canonical** route is requested in a
language it has no translation for, instead of Drupal's default language fallback (serving the
original language at the requested-language URL). Depends on core `content_translation`. Core
requirement `^10 || ^11`. **No config, no routes, no permissions, no hooks** — it is entirely
automatic and applies wherever content translation is enabled.

Policy warning — this is a deliberate choice, not a reflexive default:
- *Fully-translated site:* 404 is right — fallback creates duplicate content across language URLs and
  tells search engines a page exists in a language it does not.
- *Selectively-translated site:* fallback may serve visitors better than a dead end.
- Interacts with **hreflang** output and **XML sitemap** generation — make those agree, or search
  engines get told about URLs that now 404.

## What you'd do → where

- **Understand exactly how it works, its precise scope (which entities/routes/bundles 404), that it
  cannot bypass access, and how to limit/override/redirect it instead of 404** →
  [extend/mechanism.md](extend/mechanism.md)

## Key facts (real names)

- Two services (`untranslated_404.services.yml`): access check
  `untranslated_404.access_check.has_translation` (`Access\HasTranslation`, arg `@language_manager`,
  tagged `access_check applies_to: _untranslated_404_has_translation`) and event subscriber
  `untranslated_404.event_subscriber.not_found_if_no_translation`
  (`EventSubscriber\NotFoundIfNoTranslationSubscriber`, arg `@entity_type.manager`).
- On `RoutingEvents::ALTER`, adds requirement `_untranslated_404_has_translation: 'TRUE'` to
  `entity.{id}.canonical` of **every content entity type** (subclasses of `ContentEntityInterface`).
- The access check forbids with the exact reason `'Entity has no translation'`
  (`HasTranslation::ACCESS_RESULT_REASON`) only when: the route param is a `TranslatableInterface`,
  its language is real (not `und`/`zxx`), content translation is enabled for that entity type+bundle,
  and `$entity->hasTranslation(currentContentLangcode)` is FALSE.
- `on403()` rewrites that specific 403 into a `NotFoundHttpException` at priority **100**;
  `getHandledFormats()` is `[]` = all formats. It only ever *adds* restriction — no access bypass.
- Sole scope lever: content translation per bundle at `/admin/config/regional/content-language`.
  Nothing to configure otherwise.
- 2.x is a rewrite of 1.x (which used a view-hook exception + a settings form + permission, both
  removed by update hook `untranslated_404_update_10201`).
