Simplify de-clutters Drupal's content-authoring forms by hiding particular built-in fields and fieldsets (Authoring information, Promotion options, Revision information, URL path settings, Text format selectors, and more) from node, user, taxonomy, comment, block, media and menu-link forms.

---

Simplify implements `hook_form_FORM_ID_alter()` on the standard entity edit/create forms and marks selected elements as hidden — usually by adding the `visually-hidden` CSS class, and for a few elements (URL path settings) by setting `#access` to FALSE. It ships one settings form at `/admin/config/user-interface/simplify` (route `simplify.admin`, permission `administer simplify`) whose checkboxes are saved to the `simplify.global` config object as per-entity-type arrays of element keys (`simplify_nodes_global`, `simplify_users_global`, `simplify_taxonomies_global`, `simplify_comments_global`, `simplify_blocks_global`, `simplify_media_global`, `simplify_menu_links_global`, `simplify_profiles_global`, `simplify_eck_global`). Beyond these site-wide (global) settings, per-bundle overrides can be added directly on each content type, comment type, vocabulary and block type edit form (stored in `simplify.content_type.*`, `simplify.comment_type.*`, `simplify.vocabulary.*`, `simplify.block_type.*`). Which options appear depends on the enabled modules — e.g. `menu`, `path`, `comment`, `book`, `content_translation`, `metatag` and `redirect` add their own hideable rows. The list of core hideable elements per type is fixed in code (`simplify_get_fields()`) and can be extended with `hook_simplify_get_fields_alter()`. Hidden fields are only concealed from users who lack the `view hidden fields` permission; User 1 and admin-role users always see them unless the `simplify_admin` flag is turned on. Because fields are visually hidden (not removed), their data is preserved and still submitted.

---

- Hide the "Authoring information" (author/date) fieldset from all node edit forms so editors don't change it.
- Hide "Promotion options" (Promoted to front page / Sticky) from node forms to prevent accidental promotion.
- Hide "Revision information" from node forms when editors shouldn't write log messages.
- Hide the "URL path settings" fieldset (uses `#access` FALSE) so editors can't set manual aliases.
- Hide "Menu settings" from node forms so menu placement is controlled centrally.
- Hide "Comment settings" from node forms to lock the site-wide commenting policy.
- Hide "Book outline" from node forms on sites using the Book module.
- Hide the "Status metadata" (`meta`) block from node forms.
- Hide text-format ("Text format" select under body/other rich-text fields) selectors to force a single format.
- Hide the "Status (blocked/active)" control on user account forms.
- Hide "Locale settings" (timezone/language) from user account and registration forms.
- Hide "Contact settings" from user forms when the Contact module is enabled.
- Simplify the user *registration* form (same global user settings apply) for a cleaner sign-up.
- Hide "Relations" and "Revision information" from taxonomy term edit forms.
- Hide the "URL alias" row from taxonomy term forms.
- Hide "Name", "Authoring information" or "URL alias" from media add/edit forms.
- Hide "Parent link", "Description" or "Display settings" from menu-link content forms.
- Hide "Revision information" or the text-format selector from custom block forms.
- Apply different hidden-field sets per content type (e.g. hide Promotion options only on "Article") via the content-type edit form.
- Apply per-vocabulary term-form simplification via the vocabulary edit form.
- Apply per-comment-type or per-block-type overrides on their respective edit forms.
- Give trusted power users the `view hidden fields` permission so they still see everything while regular editors get the simplified forms.
- Force even admin users to see the simplified forms by enabling "Hide fields from admin users" (`simplify_admin`).
- Hide third-party fieldsets such as Metatag ("Meta tags"), Redirect ("URL redirects") or XML Sitemap when those modules are installed.
- Reduce cognitive load for non-technical content editors without removing fields or losing data.
- Roll out a consistent, minimal editing UI across an entire multisite by exporting the `simplify.*` config.
- Extend the hideable-field list for a custom field with `hook_simplify_get_fields_alter()` and control how it's hidden with `hook_simplify_hide_field_alter()`.
