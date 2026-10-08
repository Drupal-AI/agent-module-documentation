<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drupal Helpers (druhels) is a code-only developer library of static helper classes that wrap common, repetitive Drupal coding tasks.

---

Drupal Helpers provides a namespaced set of static utility classes (`Drupal\druhels\*Helper`) that custom modules and themes call directly from PHP. Each class groups related helpers: array/string manipulation, date math, entity/field access, node/taxonomy/paragraph context, user/role checks, file and image-style utilities, form tweaks, block rendering, Commerce cart calculations, SEO/schema.org markup attachment, and general Drupal runtime helpers (current route/title/langcode, timers, mail). The module declares no dependencies in its info file and has no routes, permissions, configuration, schema, or admin UI — it is purely a code library. Helpers that touch optional subsystems (node, taxonomy, file, image, block, block_content, paragraphs, commerce_*, field, and the `improvements` module referenced by `BlockHelper`) only work when the relevant module is installed. This documents the 2.x development branch; the on-disk `druhels.info.yml` carries no `version:` line.

---

- Detect page context: `NodeHelper::isNodePage()`, `TaxonomyHelper::isTermPage()`, `CommerceHelper::isProductPage()`, `EntityHelper::isEntityPage()`, `DrupalHelper::isFrontPage()`, `DrupalHelper::isAdminRoute()`, `DrupalHelper::isViewsPage()`.
- Get the current entity/node/term/product from the route without repeating boilerplate.
- Render an entity, node, or Commerce product to a render array via `EntityHelper::view()`, `NodeHelper::view()`, `CommerceHelper::productView()`.
- Walk taxonomy hierarchies: all/direct children, all parents, depth, root parent, and term-as-tree conversion.
- Look up or create taxonomy terms by name or by a names hierarchy (`TaxonomyHelper::createTermsByNamesHierarchy()`).
- Read field data cleanly: field labels, list-field allowed values/labels, field values as flat arrays, referenced entities keyed by id.
- Attach SEO markup to a render array: canonical link, robots noindex, arbitrary meta tags, JSON-LD, and schema.org microdata.
- Send a one-off email from code without implementing `hook_mail()` via `DrupalHelper::sendMail()`.
- Manipulate arrays: insert before/after a key, rename keys, remove empty/extra elements, sort by another array, CSV-to-array, key/value list conversions.
- Clean and transform strings: strip tags, remove double spaces, regex match, comma-decimal to float, strip HTML comments.
- Do date math: days between dates, in-range checks, season detection, timestamp conversion across string/int/DrupalDateTime.
- Check the current user's roles or admin status, and load the site's admin role/user.
- Get a file entity by URI, create a managed file entity, or build an image-style URL.
- Render a block by plugin id, config id, or content-block id as a render array.
- Compute Commerce cart totals, quantities, item counts, and add entities to the cart from code.
- Move form field labels into placeholders, or strip system elements from a GET form.
- Time and profile a code section with `DrupalHelper::timerStart()` / `timerStop()` (or the `timer_start()` / `timer_stop()` global aliases).
- Set or read the current page title and current route name/path/alias.
- Get the default or current langcode and translate an entity to the current language.
- Look up entity/field SQL data-table names and image-field default-image info.
- Serve as a shared base dependency for other contrib/custom modules (for example Drupal Improvements).
