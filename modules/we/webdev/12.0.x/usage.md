Webdev is a development-tools meta-package whose default recipe installs and configures a curated bundle of contributed site-building modules.

---

Webdev (machine name `webdev`, project "Web Development") is a thin meta-package from the Webship suite. It ships almost no PHP of its own: an `.info.yml`, an `.install` file, and a `recipes/default` recipe. On install (`webdev_install()`) it applies that recipe, which installs and enables a fixed set of contrib modules — Ctools, Token, Diff, Pathauto, Metatag, Field Group, Smart Trim, Entityqueue, Inline Entity Form, Better Exposed Filters, Link Attributes, Token Filter, and the whole UI Suite (UI Patterns, UI Styles, UI Icons, UI Skins) plus Display Builder with its submodules — imports each module's default config, provisions a Pathauto `content` URL-alias pattern (`[node:title]`), and imports the Display Builder default profile and HTML text format. A few further modules (Shield, Devel, User Redirect, Autocomplete Deluxe) are declared as Composer requirements so they are downloaded and available, but the recipe does not enable them. It has no routes, services, permissions, or config schema of its own; each bundled module keeps its own behaviour and access model, so review what is enabled and remove anything the site does not need.

---

- Bootstrap a new Drupal 11.4+/12 site with a common set of development and site-building modules in one install.
- Enable and configure Ctools, Token, Diff, Pathauto, Metatag, Field Group, Smart Trim, Entityqueue, Inline Entity Form, Better Exposed Filters, Link Attributes and Token Filter together.
- Install the full UI Suite (UI Patterns 2 with Blocks, Field, Field formatters, Layouts, Library and Views) via the recipe.
- Enable UI Styles (with Block, Library and UI Patterns integration) for utility-class styling of components.
- Enable UI Icons (with Library and Patterns) for an icon picker across the UI.
- Enable UI Skins for theme skin management.
- Enable Display Builder (with Entity view, Page layout, UI and Views) for component-based page and display building.
- Get a ready-made Pathauto URL-alias pattern for content nodes (`[node:title]`) without hand-configuring it.
- Get the Display Builder default profile and its `display_builder_html` text format provisioned automatically.
- Add Composer-managed access to Shield, Devel, User Redirect and Autocomplete Deluxe so they can be enabled later without another `composer require`.
- Standardise the contrib baseline across multiple projects by requiring one package.
- Re-run the recipe's outcome by enabling the module on a fresh site (the install hook applies `recipes/default`).
- Use Token and Token Filter to embed tokens in fields and filtered text.
- Use Diff to compare content revisions and Entityqueue to curate ordered lists of entities.
- Use Better Exposed Filters to turn Views exposed filters into selects, checkboxes, sliders and autocompletes.
- Use Metatag to manage per-entity meta tags and Field Group to organise entity-form and display fields.
- Use Inline Entity Form and Smart Trim for richer content-authoring forms and trimmed teaser output.
- Pin a consistent version range of each bundled module through Webdev's `composer.json` constraints.
- Audit an existing site's module baseline against the Webdev bundle to spot gaps.
- Enable the module through a site-install recipe or profile that lists `webdev` to pull in the whole toolset.
- Remove or uninstall individual bundled modules afterwards if a given site does not need them.
- Serve as the module layer of a Webship-based site alongside its UIkit/HTMX theme.
