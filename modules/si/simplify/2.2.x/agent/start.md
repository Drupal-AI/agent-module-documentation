# Simplify — agent index

Hides selected built-in fields/fieldsets (Authoring information, Promotion options, Revision
information, URL path settings, text-format selectors, …) from node, user, taxonomy, comment,
block, media and menu-link forms to de-clutter the editing UI. Fields are *visually hidden*,
not deleted — data is preserved and still submitted. Only affects users lacking the
`view hidden fields` permission.

- **Configure which elements are hidden (settings form, config keys, per-bundle overrides)** → [configure/simplify.md](configure/simplify.md)
- **Permissions (`administer simplify`, `view hidden fields`, `simplify_admin` flag)** → [permissions/simplify.md](permissions/simplify.md)
- **Extend the hideable-field list / change how a field is hidden (hooks)** → [api/simplify.md](api/simplify.md)
