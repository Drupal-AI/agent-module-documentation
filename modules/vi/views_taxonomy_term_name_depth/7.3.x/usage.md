<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Taxonomy Term Name Depth adds a Views contextual filter (argument) that matches content by taxonomy **term name** — not term ID — and can also include content tagged with parent or child terms via a configurable **depth**.

---

The module registers a single Views argument handler, `taxonomy_index_name_depth`, exposed on the node base table as **"Has taxonomy term NAME (with depth)"** (`node_field_data.term_node_taxonomy_name_depth`). Where Drupal core's contextual filters key off numeric term IDs, this one accepts a human-readable term name in the URL (e.g. `/my-view/News` instead of `/my-view/17`), which is convenient for clean, SEO-friendly paths. Because Pathauto is a hard dependency, the handler resolves the incoming name by running both the URL argument and each term's stored name through Pathauto's alias cleaner (`pathauto.alias_cleaner`), so a slugified value like `my-news` matches the term "My News". The **depth** option walks the `taxonomy_term__parent` hierarchy: a positive depth also returns nodes tagged with descendant terms (filtering "Fruit" at depth 1 also returns nodes tagged "Apple"), while a negative depth walks upward toward ancestors. A **vocabularies** option restricts which vocabularies are searched (useful when the same term name exists in several), and an **Allow multiple values** (`break_phrase`) option lets a visitor pass `Apple+Pear` as an OR match. The module ships a companion default-argument plugin, `taxonomy_tpid` ("Taxonomy term parent ID from URL"), that supplies a term's parent ID from the current taxonomy-term or node route. It defines no admin settings form, no permissions, and no Drush commands — all configuration lives inside the Views UI on the contextual filter itself.

---

- Build a page view whose URL takes a taxonomy term **name** instead of a numeric term ID (`/articles/news` rather than `/articles/12`).
- Show all content tagged with a category **and** all of its sub-categories on one page by setting a positive depth.
- Create a "section landing page" that lists nodes from a parent term plus every descendant term below it.
- Filter a listing to a term's ancestors by using a negative depth value.
- Give editors clean, readable contextual-filter URLs that mirror Pathauto term aliases.
- Match terms case- and separator-insensitively (e.g. `New-Products` matches the term "New Products") thanks to the Pathauto alias cleaner.
- Restrict a name-based contextual filter to specific vocabularies so identically named terms in other vocabularies are ignored.
- Let visitors combine several term names in one request with `Term-A+Term-B` (OR matching) via the "Allow multiple values" option.
- Power a related-content block that lists nodes sharing a term (or its child terms) with the current node.
- Build a blog view where the category segment of the URL is the term name, aligning the Views path with Pathauto-generated aliases.
- Drive a REST or feed display that accepts a term name argument for external consumers who don't know internal term IDs.
- Aggregate content across a multi-level taxonomy tree (e.g. Region > Country > City) into a single depth-based listing.
- Create documentation/knowledge-base sections keyed by a readable topic name in the path.
- Replace a core "Has taxonomy term ID (with depth)" contextual filter when you want names in the URL but keep depth behaviour.
- Set up product-catalog category pages that include products from every nested sub-category.
- Provide a fallback term argument from the current node's referenced terms using the `taxonomy_tpid` default-argument plugin.
- Default a view's argument to the current taxonomy term's **parent** term (so a child term page shows the whole parent section).
- Expose an event calendar filtered by an event-type term name with its subtypes included at depth.
- Build newsroom "topic hub" pages where `/news/topic-name` surfaces the topic and all narrower topics.
- Let content strategists rename terms without breaking URLs that key on the (Pathauto-cleaned) name rather than a brittle numeric ID mapping.
