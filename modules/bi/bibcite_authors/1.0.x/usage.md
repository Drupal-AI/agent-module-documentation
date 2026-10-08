Bibcite Authors adds field formatters for Bibcite's contributor field that display author names last-name-first and can link them to matching Drupal user accounts.

---

Bibcite Authors is a lightweight companion to the Bibcite bibliography suite. It defines three `@FieldFormatter` plugins for the `bibcite_contributor` field type — the field that stores a reference's authors/editors as `bibcite_entity` Contributor entities. The formatters read each Contributor's `first_name`, `middle_name` and `last_name` and render them either plainly (last-name-first, or first-name-first) or as an HTML link to a Drupal user profile. Linking works when a user account carries a `field_author` entity reference pointing at the Contributor: the formatter looks the account up by that field and, if found, wraps the name in an `<a href="/user/{uid}">`. The module has no settings form, no config schema, no routes and no permissions — you use it purely by choosing one of its formatters on a reference entity's Manage Display page or in a view. Enabling it requires the `bibcite` project (its Contributor entity comes from the `bibcite_entity` submodule).

---

- Display a reference's authors last-name-first (e.g. "Smith, John A") on a bibliography node.
- Show contributor names in a citation list using the "Authors (Last name first)" formatter.
- Render author names first-name-first with the "Authors (with link to user)" formatter when no linked account exists.
- Turn author names into clickable links to the site's matching user profiles.
- Connect a scholarly publication's authors to the researcher accounts on the site.
- Let visitors click an author's name to jump to that person's Drupal profile page.
- Build a "publications by this person" experience by linking Contributors to users.
- Choose the formatter per view mode (teaser vs full) on the reference's Manage Display page.
- Use the formatter inside a View that outputs the contributor field.
- Fall back gracefully to plain text when a Contributor has no associated user account.
- Associate a user account with a Contributor by adding a `field_author` reference field to the user entity.
- Keep author display consistent across reference types (journal article, book, etc.) that share the contributor field.
- Show middle names when present, and omit them cleanly when absent.
- Present author lists where each name is a separate rendered element (one per contributor delta).
- Surface the profile link only for contributors that are actually mapped to accounts.
- Integrate a bibliography module's author output with the site's people directory.
- Display editor/author roles from Bibcite entities without writing a custom formatter.
- Provide a simple, no-configuration display option for site builders using Bibcite.
- Render author names in a faculty/staff publications section that deep-links to profiles.
- Swap between the three formatters to change name order and linking behavior without code.
