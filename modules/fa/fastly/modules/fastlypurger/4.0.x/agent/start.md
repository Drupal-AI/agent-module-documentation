# Fastly Purger — agent index

Submodule of **fastly** that plugs Fastly into the contrib **Purge** module. Enable separately
(`drush en fastlypurger`); depends on `fastly` + `purge`. No config of its own — Fastly
credentials come from the parent module's forms; the purger is added/ordered via Purge.

- **Register & configure the Fastly purger in Purge (plugin id, types, diagnostic, service alter)** →
  [configure/purger.md](configure/purger.md)

Key facts:
- Purge purger plugin id `fastly` (label "Fastly"), types `tag` / `url` / `everything`,
  `multi_instance = FALSE`. Class `FastlyPurger`; routes each type to `fastly.api`
  (`purgeKeys`/`purgeUrl`/`purgeAll`).
- Purge diagnostic check `fastly_creds` (`CredentialCheck`) — flags missing/invalid Fastly creds
  (`dependent_purger_plugins = {"fastly"}`).
- `FastlypurgerServiceProvider` clears the `cache_tags_invalidator` tag from
  `fastly.cache_tags.invalidator` so invalidation goes through Purge's queue.
- Purgers are stored in `purge.plugins:purgers`; add with `drush p:purger-add fastly`.
