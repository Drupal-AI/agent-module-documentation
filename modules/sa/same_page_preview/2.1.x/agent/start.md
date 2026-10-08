<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Same Page Preview (same_page_preview) — agent index

Renders a live node preview in a **pane beside the edit form** rather than replacing it.
Version **2.1.4**. Core requirement `^10 || ^11`.

**This release fatals on Drupal 11.4 — verified live.**
`PreviewPaneController::$formBuilder` is typed **`FormBuilderInterface`** while core's
`NodePreviewController` (which it extends) declares **`?FormBuilderInterface`** — nullable, because
core made the constructor argument optional in 11.4 with a deprecation for callers that omit it:

```
Type of Drupal\same_page_preview\Controller\PreviewPaneController::$formBuilder
must be ?Drupal\Core\Form\FormBuilderInterface (as in class Drupal\node\Controller\NodePreviewController)
```

PHP rejects the narrowed property type and fatals **on class load**. On this install
**`drush pm:uninstall` itself could not run**, and the module had to be removed from
`core.extension` by a **direct configuration edit**.

**The upstream fix is one character.** Until it lands the module cannot be enabled on 11.4 — and a
site already running it **breaks on the core update rather than at install time**, which is the
worse order for a discovery.

**The feature is worth having:** the edit→preview→back loop is where editorial work happens, and a
loop costing two page loads and a scroll is one people stop using — which is how content ships
without anyone having seen it rendered.
