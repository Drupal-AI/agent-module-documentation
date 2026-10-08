# Configuration

Configuring Field Bundle mirrors how you configure content types: define bundle
types, add fields, then grant permissions.

## 1. Create a bundle type

1. Log in as a user with permission to administer Field Bundle configuration.
2. Go to **`/admin/structure/field-bundle`** (the bundle‑type collection).
3. Add a new **bundle** and give it a label and machine name. Each bundle is a
   `field_bundle_config` configuration entity — the equivalent of a content type
   for this entity.

## 2. Add fields to the bundle

Field Bundle uses the standard **Field UI**, so this will feel familiar:

1. From the bundle you created, open its **Manage fields**.
2. Add any Drupal field types you need, and arrange the form and display under
   **Manage form display** and **Manage display**.

## 3. Set permissions

Field Bundle ships a granular permission set (defined in
`field_bundle.permissions.yml`). On the **People → Permissions** page
(`/admin/people/permissions`) you can grant, per role:

- **Create / view / update / delete** operations, with **own** vs **any**
  distinctions.
- **Revision** operations.
- Access to **unpublished** bundle content ("view any" vs "view own").
- The dedicated permission to **administer bundle configuration**.

Grant these deliberately — because Field Bundle enforces proper entity and revision
access checks, the permissions you set here are the real control over who can see
and change this data.

## 4. Create content

With bundles, fields, and permissions in place, create Field Bundle entities from
the overview. They behave like other content entities: they can be revised,
translated, referenced from other entities, and (with the canonical submodule) given
their own page.

## Optional submodules

- **Field Bundle Canonical** adds a canonical URL/page for entities.
- **Group Field Bundle** lets you add Field Bundle entities as content in a
  [Group](https://www.drupal.org/project/group). Configure it from the Group type's
  content‑enabler settings once enabled.
