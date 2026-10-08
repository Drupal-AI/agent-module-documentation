Synfilters is a site-specific add-on for Better Exposed Filters that tweaks how one Commerce catalog View (the `product` View's `embed` display) renders its exposed filter form.

---

Despite the generic name, Synfilters is not a general "extra widgets" module. It hard-codes behavior for a single Views configuration: a View whose id is `product` with an `embed` display, of the kind produced by a Commerce product catalog using Better Exposed Filters. Through two Views hooks it (1) hides that display's exposed filter form whenever the current page is a parent taxonomy term that still has child terms, so shoppers see filters only on leaf category pages, and (2) rewrites the exposed form's HTML `action` to the current page's path alias so the filter form posts back to the pretty URL. On install it also patches the `views.view.product` config to add `taxonomy.vocabulary.product_options` to its config dependencies and `taxonomy` + `better_exposed_filters` to its module dependencies. It declares no routes, permissions, services, config schema, or settings form, and depends on `better_exposed_filters`. It is most useful as a reference/template for how to conditionally hide and retarget a BEF exposed form via `hook_form_views_exposed_form_alter()` and `hook_views_pre_render()`, or on a site that already runs the matching `product` catalog View.

---

- Suppress the exposed filter form on a category landing page that only lists sub-categories, showing filters only once a shopper drills into a leaf term.
- Keep an `embed`-display product catalog's exposed filters out of the way on parent taxonomy terms.
- Point a Views exposed form's submit `action` at the current path alias instead of the raw internal path, so filtering stays on the clean URL.
- Add Better Exposed Filters conditional-display behavior to a Commerce product catalog without writing a custom module.
- Automatically register the taxonomy vocabulary and modules a product catalog View depends on when the module is installed.
- Serve as a worked example of `hook_form_views_exposed_form_alter()` keyed on a specific exposed-form `#id` (`views-exposed-form-product-embed`).
- Serve as a worked example of `hook_views_pre_render()` overriding `$view->exposed_widgets['#action']`.
- Show how to detect a taxonomy-term route parameter and test for child terms with `loadTree()` inside a form alter.
- Hide the filter UI for anonymous and authenticated shoppers alike on parent-term pages (the check is route/term based, not role based).
- Provide a lightweight, config-free companion to Better Exposed Filters (no admin settings to manage).
- Restore or re-apply the `product` View's config/module dependencies by reinstalling the module.
- Template for retargeting an AJAX-less exposed form's action to a path alias so bookmarked/shared filter URLs stay pretty.
- Reference for a `SynapseF`-package site build that ships a Commerce mattress/furniture-style faceted catalog.
- Reference for pairing taxonomy-term pages with a `taxonomy_index_tid`-filtered BEF catalog.
- Base to fork when you need parent-vs-leaf conditional exposed-filter display for a different View id or display.
- Understand why a `product`/`embed` catalog's exposed form is hidden on some term pages after this module is enabled.
- Ensure the exposed form appears only where filtering is meaningful (leaf categories with products), reducing UI clutter.
- Ground a code review of the two Synfilters hooks against the actual `views.view.product` shipped config.
- Confirm the module has no runtime configuration and cannot be tuned via the UI (behavior is code-defined).
- Decide whether to adopt it as-is (only useful with a matching `product` View) or lift its patterns into your own module.
