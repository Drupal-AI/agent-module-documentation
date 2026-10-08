<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Organic Groups Prepopulate lets an Organic Groups audience field be filled straight from a short query parameter — `/node/add/page?og_audience=12` — instead of the long `edit[...][widget][0][target_id]` syntax of the parent Prepopulate module.

---

This submodule ships inside the `prepopulate` project and requires both `prepopulate` and `og`. It implements `hook_field_widget_WIDGET_TYPE_form_alter()` for the Organic Groups `og_complex` widget: when the current request has a query parameter whose name matches the field's machine name (e.g. `?og_audience=12`), it adds `og_prepopulate_after_build()` to the widget element's `#after_build`. That callback reads the first element of `#parents` as the field name, pulls the value from the query string, and calls `populateForm($element, ['target_id' => $entity_id])` on the `og_prepopulate.populator` service. That service is `Drupal\og_prepopulate\Populate`, a subclass of the parent `Drupal\prepopulate\Populate` with the current user injected, which overrides `formatEntityAutocomplete()`: instead of the parent's `view label` access check it uses `Og::isMember($entity, $current_user)`, and when the user really is a member of the group it both writes the `Label (id)` value **and** sets `#access = FALSE` so the audience field is hidden from the form. As a second convenience, when no query parameter is present but the audience field already has a value, the widget alter sets `#access = FALSE` too, hiding a group field the editor should not change. There is no settings form, no route, no permission and no configuration — the whole module is one `.module` file, one service definition and one subclass. **Caveat, verified on Drupal 11.4 with OG 2.0.2:** the automatic half of that no longer runs — `hook_field_widget_WIDGET_TYPE_form_alter()` was removed in Drupal 10 (core now invokes `hook_field_widget_single_element_WIDGET_TYPE_form_alter()`), and OG 2.x ships no `og_complex` widget at all (only `og_autocomplete`, which applies to plain `entity_reference` fields, so an `og_audience` field of type `og_standard_reference` falls back to `options_select`). The `og_prepopulate.populator` service and its `Og::isMember()` rule still work perfectly when invoked directly, so on modern Drupal the module is best treated as a reusable service plus a small `hook_field_widget_single_element_form_alter()` bridge you write yourself.

---

- Give group members an "Add content to this group" link that pre-selects the group: `/node/add/article?og_audience=12`.
- Hide the group audience selector once the group has been chosen by the URL.
- Hide the audience field on an edit form where the group is already set, so editors cannot move content between groups by accident.
- Build group-homepage buttons that create content already scoped to that group.
- Let a group dashboard offer one "new discussion" link per group without custom code.
- Prepopulate an OG audience field from an invitation email link.
- Keep the group assignment out of the editor's hands while still creating content in the right group.
- Show the group as `Group name (12)` in the widget rather than a bare entity id.
- Fall back to the raw id when the current user is not a member of the referenced group.
- Use the short `?field_name=id` syntax rather than the parent module's nested `edit[...]` array.
- Prefill the audience for anonymous-facing group submission forms.
- Combine with the parent module to prefill both the title and the group in a single link.
- Drive per-group content creation links from a Views listing of groups.
- Provide QR codes that open a group-scoped content form on mobile.
- Route "report an issue" links from a group page to a prefilled node form.
- Avoid writing a custom `hook_form_alter()` for every group-enabled content type.
- Reuse the parent `prepopulate.populator` behaviour (whitelist, no-overwrite, escaping) for OG fields.
- Extend `Drupal\og_prepopulate\Populate` further if your site needs a different membership rule.
- Multi-step forms are untouched after the first build, so a prefilled group survives validation errors.
- Keep group scoping consistent between a "create content" call to action and the resulting node.

