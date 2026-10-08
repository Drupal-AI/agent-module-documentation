Custom Classes adds or removes CSS classes on form elements based on route, path or form ID, configured entirely from an admin page instead of a custom hook_form_alter().

---

The module ships one admin settings form (`/admin/config/system/custom-classes`) that stores a multi-line rule list in the config object `custom_classes.settings:class_mappings`. Each rule is a semicolon-separated line with six fields — route name, URL/path, form ID, a PHP-style path to the target element (`$form["actions"]["submit"]`), classes to add, and classes to remove — where `*` (or an empty field) is a wildcard. On every form build a global `hook_form_alter()` delegates to the `custom_classes.controller` service, which matches the current route, path and form ID against each rule and, for matching rules, merges the added classes onto the targeted element's `#attributes[class]`. Classes to add are sanitized with `Xss::filter()` and normalized with `Html::getClass()`. Removal is deferred: the rule adds a `#process` callback that appends a trusted `#pre_render` callback (`FormElementRemoveClasses::doRemoveClasses`) so classes are stripped only after the element's own process/pre-render have produced the final class list. The module warns that removing a class other code relies on (e.g. a Commerce Add-to-cart submit class) can cause AJAX/serialization errors, so removal is a last resort. Adding rules requires the `administer custom_classes configuration` permission; if forms are cached, rebuild caches after changing the configuration.

---

- Add a unique CSS class to a submit button that a module renders without one, so a theme can target it.
- Add a `button--primary` class to the submit of a specific node form (e.g. `node_article_form`).
- Add a call-to-action class to the Add-to-cart / product submit on `entity.commerce_product.canonical`.
- Add a class to the Preview button on any node edit page using the path pattern `/node/*/edit`.
- Style a form element site-wide by matching form ID with `*` wildcards (e.g. `webform_*`).
- Restrict a class change to a single route by giving the exact route name (e.g. `user.login`).
- Restrict a class change to specific URLs/paths with `*` glob patterns (e.g. `/admin/*`).
- Target a deeply nested element via its render-array path, e.g. `$form["actions"]["preview"]`.
- Add multiple classes at once by space-separating them in the "classes to add" field.
- Remove a class added by another module or by core from a specific button.
- Remove several classes at once by space-separating them in the "classes to remove" field.
- Combine add and remove on one element in a single rule (add one class, drop another).
- Apply the same class rule across a whole content type's forms by matching the form ID pattern.
- Adjust button styling without deploying custom module code — configuration only.
- Preview all saved rules as a table in the settings form to audit what is configured.
- Use exact route matching to avoid affecting look-alike paths that share a URL prefix.
- Normalize inconsistent third-party button markup by adding a shared utility class.
- Add BEM/utility classes to match a design system on forms you cannot easily override.
- Export the `custom_classes.settings` config with your site config so rules travel between environments.
- Keep styling tweaks reviewable in configuration management instead of scattered in theme/module code.
