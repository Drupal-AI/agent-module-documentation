# Migrate Booster — manual setup guide

**Migrate Booster** (`migrate_boost`) speeds up Drupal migrations by temporarily
switching off the module hooks that would otherwise fire on every single row you
import. During a large migration, side‑effect hooks — pathauto generating a URL
alias for each node, xmlsitemap updating sitemap links, workbench_moderation
reacting to every insert, search indexing kicking in per item — run thousands of
times and dominate the run time. Migrate Booster lets you suppress exactly those
hooks while `drush migrate:import` or `drush migrate:rollback` runs, then you
regenerate the aliases, sitemaps, and indexes once, in bulk, afterwards.

It works by decorating Drupal's `module_handler` service. When "boost" is active
it filters your chosen hook implementations out of the calls Drupal makes, so the
migration proceeds without those extra side effects. Boost is off during normal
web traffic — a request subscriber force‑disables it on every HTTP request, so a
stray flag can never affect your live site — and it is only turned on inside
Drush, automatically, while the migrate import/rollback commands run.

This is a command‑line performance tool for developers. It has **no
configuration screen, no permissions, and no blocks** — you tell it what to skip
with a couple of settings in `settings.php`, and you drive it with Drush. It
targets **Drupal 11.1+** and requires **Drush 13**.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

There is no admin UI. You configure two keys of the `migrate_boost.settings`
config object, normally as overrides in your `settings.php` so they never ship in
exported configuration:

```php
// Skip a specific hook for specific modules.
$config['migrate_boost.settings']['hooks'] = [
  'entity_insert'  => ['pathauto', 'xmlsitemap', 'workbench_moderation'],
  'entity_presave' => ['xmlsitemap'],
];

// Or skip ALL hooks of a module.
$config['migrate_boost.settings']['modules'] = [
  'pathauto',
  'xmlsitemap',
];
```

- `hooks` maps a hook name to the list of modules whose implementation of that
  hook should be suppressed.
- `modules` lists modules whose hooks are suppressed entirely.

Once those are in place, boost activates automatically whenever you run
`drush migrate:import …` or `drush migrate:rollback …` — no extra flags needed.
Two explicit commands are also provided for custom CLI flows:
`drush migrate:booster:enable` (alias `mbe`) turns boost on, and
`drush migrate:booster:reset` (alias `mbr`) resets the hook cache mid‑run.

Because suppressing hooks skips their side effects, remember to regenerate what
you turned off once the migration finishes — for example bulk‑generate Pathauto
aliases and rebuild the XML sitemap and search index with their own Drush
commands.
