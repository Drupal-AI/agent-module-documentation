<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drutopia Dev is a helper module for developers and feature builders of the Drutopia distribution: it pulls in Devel and Entity Clone alongside the full Drutopia feature set and ships a Features bundle plus a cloneable "Dev node" Search API index.

---

Drutopia Dev has almost no PHP of its own. Its work is done through metadata and config: `drutopia_dev.info.yml` declares a long dependency chain (Devel, Entity Clone, Node, User, Search API, plus every `drutopia_*` content/feature module), so a single enable assembles the toolkit a Drutopia contributor expects. `drutopia_dev.features.yml` marks the module as a required part of the `drutopia` Features bundle, and `config/install/` installs that bundle definition (`features.bundle.drutopia.yml`) together with a template Search API index named "Dev node" (`search_api.index.dev_node.yml`) whose description explains its purpose: "Use the Dev node index to clone an index per content type." The project also carries a standalone maintenance script, `scripts/git-clone-origin-for-drutopia-projects.php`, that rewrites the git remote of checked-out `drutopia*` modules from the HTTPS clone URL to the SSH push URL — a manually-run developer convenience, not Drupal-loaded code. A sibling submodule, `drutopia_dev_findit`, targets the "Find It" install profile and is documented separately. Because it drags in Devel and Entity Clone, Drutopia Dev is intended for development and staging, not production. In this corpus it is documented from a development checkout (the `info.yml` carries no packaged `version:`).

---
- Assemble a full Drutopia developer/feature-builder toolkit in a single `drush en drutopia_dev`.
- Pull in Devel for dumping entities, tokens, and services while building a Drutopia site.
- Add Entity Clone so example content and config entities can be duplicated during development.
- Guarantee the complete Drutopia content feature set (article, blog, campaign, comment, event, group, home page, landing page, page, people, related content, resource, SEO, site, social, storyline, user) is present for testing.
- Install the `drutopia` Features bundle so Features exports and imports use the distribution's assignment plan.
- Provide the "Dev node" Search API index as a starting template to clone one index per content type.
- Standardize the dev toolkit across a Drutopia contributor team so everyone has the same baseline modules.
- Keep dev-only modules grouped behind one meta-module instead of enabling each piecemeal.
- Strip the whole dev toolkit before release by uninstalling this one module.
- Bootstrap a Features-building workflow on a Drutopia distribution.
- Reproduce a known-good Drutopia dev stack on a new machine or CI environment.
- Pair with `drutopia_core` and `drutopia_search` configuration when developing search features.
- Inspect nodes, users, and taxonomy via Devel during feature development.
- Test Search API indexing behavior against the bundled "Dev node" index.
- Clone a content type's index quickly by copying the "Dev node" template.
- Use `scripts/git-clone-origin-for-drutopia-projects.php` to switch cloned drutopia* modules from HTTPS to SSH git remotes for push access.
- Document and enforce the intended dev-only scope of the toolkit.
- Exclude the module from production module lists and deployments.
- Add the `drutopia_dev_findit` submodule when working on a Find It install profile.
- Serve as a single dependency to require in a Drutopia development composer setup.
