<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Fixtures provides a framework for defining and loading content fixtures — reproducible test or demo content — in code, similar to Doctrine data fixtures.

---

Content Fixtures provides a developer framework for defining content fixtures — reproducible sets of
entities (nodes, terms, users, etc.) declared in code and loaded on demand — modelled on Doctrine's
data fixtures. Developers write fixture classes that create the content, then load them (typically via
Drush) to populate a site with known content for tests, demos or local development, and can purge and
reload for a clean state. It ships a `content_fixtures_example` submodule showing the pattern.

Use it to make test/demo content reproducible and version-controlled rather than hand-created. It is a
development tool — fixtures are code authored by developers and loaded in dev/test/CI contexts, not a
runtime feature. Do not load demo fixtures on production. It provides Drush commands for loading
fixtures.

---

- Define content fixtures in code.
- Load reproducible test/demo content.
- Model fixtures on Doctrine data fixtures.
- Populate a site with known content.
- Load fixtures via Drush.
- Purge and reload for a clean state.
- Write fixture classes for entities.
- Use content_fixtures_example as a pattern.
- Version-control demo content.
- Support tests and CI.
- Create nodes/terms/users as fixtures.
- Avoid hand-created test content.
- Load fixtures in dev/test only.
- Not load demo fixtures on production.
- Provide Drush commands for fixtures.
- Reproduce content states.
- Seed local development content.
- Declare content declaratively.
- Reset content between test runs.
- Serve as a development tool.
