# Content Fixtures — manual setup guide

**Content Fixtures** (`content_fixtures`) is a developer framework for defining
reproducible test or demo content **in code** and loading it on demand — modelled
closely on Symfony's DoctrineFixturesBundle. If you build a site straight from your
repository and then realise you need some dummy content to work with, this module
gives you an API to program your own content generators and run them with a single
command, filling the site with exactly the content your development or presentation
needs.

You write **fixture classes** — PHP classes registered as services with a
`content_fixture` tag — that create nodes, terms, users, and any other entities.
There are a few refinements borrowed from Doctrine: extend `AbstractFixture` to
**share created objects** between fixtures; implement `OrderedFixtureInterface` or
`DependentFixtureInterface` to control the **order of execution**; and implement
`FixtureGroupInterface` to assign fixtures to **groups**, so you can keep one set
for presentation and another for development. The module deliberately deletes all
content before loading fixtures (it warns you first) so you always start from a
known, unambiguous state — which makes it a great match for Docker and automated
setups. The `content_fixtures_example` submodule ships as a worked example of the
pattern.

This is a **developer tool for dev, test, and CI contexts — not a runtime feature,
and not for production.** Because loading fixtures wipes existing content first,
never run it against a production site. Everything is driven through **Drush**: the
module provides `content-fixtures:list`, `content-fixtures:load`, and
`content-fixtures:purge`. It has no dependencies beyond Drupal core and no admin
settings form.

This guide is written for a **human** developer working from the command line. If
you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and (optionally) the example submodule.

This module has **no configuration page** — there is no settings form. You configure
it by writing fixture classes in code and running the Drush commands, outlined in
"How to use it" below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)). Optionally enable
   `content_fixtures_example` first to study a working fixture.
2. Write one or more fixture classes that implement `FixtureInterface` (or extend
   `AbstractFixture` for object sharing), and register each as a service tagged
   `content_fixture` in your module's `*.services.yml`.
3. Control execution order with `OrderedFixtureInterface` or
   `DependentFixtureInterface`, and assign groups with `FixtureGroupInterface` if you
   want separate sets for development vs presentation.
4. Manage them with Drush:
   - `drush content-fixtures:list` — see the registered fixtures.
   - `drush content-fixtures:load` — load fixtures (this deletes existing content
     first, after warning you). Load by group to run a specific set.
   - `drush content-fixtures:purge` — remove loaded content.

   Run `drush help content-fixtures:load` (and the other commands) for the full
   options.
