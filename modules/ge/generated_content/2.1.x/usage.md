<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Generated Content provides a framework to programmatically generate content entities, for demos, testing and local development.

---

Generated Content provides a framework for programmatically generating content — nodes, terms,
users, media and other entities — defined in code, for populating a site with demo/test content. Unlike
random generators, it lets developers declare exactly what to create (and clean up), making generated
content reproducible for demos, automated tests and local development. It ships example submodules
(`generated_content_example1`/`2`), provides Drush commands and its own permissions.

Use it to seed a site with known content during development, demos or CI. It is a developer tool —
generation is code authored by developers and run in dev/test contexts, and it can remove generated
content to reset state. Do not run content generation on production. Access to generation is gated by
permission and the Drush/CLI context.

---

- Programmatically generate content.
- Seed demo/test content.
- Declare content to create in code.
- Generate nodes, terms, users, media.
- Clean up generated content.
- Use example submodules.
- Provide Drush commands.
- Provide its own permissions.
- Populate a site for demos.
- Support automated tests.
- Reset state by removing content.
- Not run generation on production.
- Seed local development.
- Make content reproducible.
- Generate known content.
- Run in dev/test/CI.
- Author generators in code.
- Gate generation by permission.
- Create content in bulk.
- Reproduce content states.
