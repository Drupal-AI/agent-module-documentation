Entity Display Modes Listing adds each non-default view/form display mode of a node type or taxonomy vocabulary as its own operation link on the admin bundle-listing pages.

---

Entity Display Modes Listing is a small site-building convenience module (single `hook_entity_operation()` implementation, no routes, permissions, config, or services of its own). On the *Content types* listing (`/admin/structure/types`) and the *Taxonomy* vocabulary listing (`/admin/structure/taxonomy`), it inspects each bundle's configured display modes via core's `entity_display.repository` service and adds one extra operation per non-`default` view mode ("Manage display …") and per non-`default` form mode ("Manage form display …"). Each operation deep-links straight to that specific display mode's *Manage display* / *Manage form display* page, so builders can jump to a named mode without opening the default mode first and clicking through the display-mode tabs. It only affects node types and taxonomy vocabularies, only augments pages that admins already have access to, and works across Drupal core 8 through 11.

---

- Jump directly to a content type's non-default *Manage display* page from `/admin/structure/types`.
- Jump directly to a content type's non-default *Manage form display* page from the same listing.
- Reach a vocabulary's non-default view-mode display page from `/admin/structure/taxonomy`.
- Reach a vocabulary's non-default form-mode display page from the same listing.
- See at a glance which display modes are actually enabled on each content type without opening each bundle.
- See which form modes are enabled per bundle from the listing's operations dropdown.
- Skip the extra clicks of opening the default display mode then switching tabs to a secondary mode.
- Speed up theming work that spans several view modes (e.g. Teaser, RSS, Full, Search index).
- Speed up editing across multiple form modes (e.g. a custom "register" or "compact" form mode).
- Audit display-mode coverage across all content types during a site-build review.
- Onboard new site builders by exposing the per-mode display links right in the operations menu.
- Confirm a newly created custom view mode is active on the intended bundles.
- Confirm a newly created custom form mode is active on the intended bundles.
- Navigate to a specific view mode's field layout when configuring Layout Builder or field display.
- Reduce navigation friction on sites with many content types and many display modes.
- Provide consistent per-mode deep links whether the bundle is a node type or a taxonomy vocabulary.
- Use it purely as an admin UI aid — it stores no data and needs no configuration after enabling.
- Enable it on multilingual or multi-team sites so any admin editing structure gets the shortcuts.
- Keep it enabled as a permanent site-building quality-of-life improvement.
- Disable/uninstall it cleanly at any time, since it adds only operation links and nothing else.
