<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Manage Display makes entity **base fields** — node/term title, author (`uid`), created date, comment subject and parent — configurable on the *Manage display* page, so you can reorder them, pick a formatter and set a wrapper tag instead of hard-coding them in Twig.

---

Core marks most base fields as not display-configurable, so `title`, `uid` and `created` never appear on *Manage display*; themes print them from `node.html.twig` via `label`, `display_submitted` and the page title block. Manage Display flips that: `hook_entity_base_field_info_alter()` calls `setDisplayConfigurable('view', TRUE)` and sets default display options for a fixed list of base fields on node, user, taxonomy_term, comment, aggregator_feed and aggregator_item. It ships three field formatters to render them the way core's templates used to — `title` (a `StringFormatter` subclass that adds a **Tag** select, default `h2`, plus core's `link_to_entity`), `submitted` (an `AuthorFormatter` subclass that adds a **user picture view mode** setting) and `in_reply_to` (comment `pid` rendered as "In reply to *subject* by *author*"). `hook_entity_type_build()` sets core's `enable_base_field_custom_preprocess_skipping` and `enable_page_title_template` flags so the theme layer stops double-printing the values, and it makes `name` the label key for users. At render time `hook_entity_view_alter()` watches for the `submitted` formatter on the owner field and re-assembles the `uid`, `created` and (for comments) `pid` components into a single `submitted` themed element, so "Submitted by X on Y" stays one sentence. Two admin forms are pruned to avoid conflicting controls: the *Display settings* fieldset on the content-type form and the node/comment user-picture toggles in theme settings. There is no configure route, no permissions, no Drush and no services — the module's whole persistent footprint is the component entries it enables inside `core.entity_view_display.*` config.

---

- Show a node title on the *Manage display* page so it can be reordered relative to fields.
- Wrap a node title in `h1` instead of the default `h2` on the full view mode.
- Render a teaser title as `h3` while the full view uses `h1`.
- Turn the node title into a non-linked heading by unsetting `link_to_entity`.
- Hide the title entirely on a view mode used inside a Layout Builder block.
- Move the "Submitted by … on …" line below the body instead of above it.
- Show the author line on the teaser view mode but hide it on the full node.
- Add a user picture to the submitted line and choose which user view mode renders it.
- Remove the author byline from an article without editing `node.html.twig`.
- Display the created date on its own, formatted with a chosen date format, separate from the author.
- Give taxonomy term pages a configurable term-name heading.
- Configure a comment subject's heading tag and permalink behaviour from *Manage display*.
- Show the "In reply to <subject> by <author>" line on threaded comments as a configurable component.
- Reorder comment author, date and subject without a custom comment template.
- Expose the user `name` base field on the user *Manage display* page.
- Format aggregator feed titles, images and descriptions through the display UI.
- Build a card teaser where title, image and byline order is set purely by display config.
- Ship a title formatter tag change through exported configuration instead of a theme deploy.
- Standardise heading levels for accessibility audits across every content type from one screen.
- Let site builders change byline/title presentation without front-end developer involvement.
- Replace a custom preprocess hook that only existed to move the node title.
- Use the `title` formatter inside a custom view mode consumed by Views or Layout Builder.
- Stop the theme printing the page title twice by relying on `enable_page_title_template`.
- Hide the content type "Display settings" fieldset so editors only use *Manage display*.
- Override the `submitted.html.twig` template to change the byline wording site-wide.
- Migrate an old site's hard-coded title markup into configuration during a redesign.
