# Configuration

All of Data Layer's behavior lives in a single settings object
(`datalayer.settings`), edited from one admin form.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Search and metadata → Data Layer**, or navigate
   directly to `/admin/config/search/datalayer`.

## What always outputs

Even before you change anything — and even on pages with no content entity — the
dataLayer always includes the site name, the current language, the current
country, and the current user's uid (`userUid`). These come from your site and
date settings.

## Page and entity metadata

- **Add page meta** (`add_page_meta`, on by default) — when the page's route has a
  content entity, emit its metadata: type, bundle, id, and title.
- **Output terms** (`output_terms`, on by default) — also include the taxonomy
  terms the entity references, grouped under an `entityTaxonomy` key.
- **Vocabularies** (`vocabs`) — restrict the exposed terms to specific
  vocabularies. Leave it empty to include terms from all vocabularies.
- **Output fields** (`output_fields`, off by default) — publish the values of
  fields you have individually opted in (see *Expose a single field* below).
  There is no "expose everything" switch; only fields you mark are output.
- **Entity meta** (`entity_meta`) — a list of entity property names to output for
  *all* entity types, such as `created`, `changed`, or `status`.
- **Remove from admin routes** (`remove_from_admin_routes`, on by default) —
  suppress the dataLayer on admin pages so editorial metadata is not leaked there.

## Information-architecture categories

- **Enable IA** (`enable_ia`, off by default) — output components of the URL path
  as category values, useful as breadcrumb-style context.
- **IA depth** (`ia_depth`, default 3) — how many path components to emit.
- **Primary category key** (`ia_category_primary`, default `primaryCategory`) —
  the JSON key for the first path component.
- **Sub category key** (`ia_category_sub`, default `subCategory`) — the key prefix
  for the remaining components (`subCategory1`, `subCategory2`, …).

## Current-user detail

By default only the user's uid is exposed. To publish more, and only in the right
places:

- **Expose user details** (`expose_user_details`) — one or more URL patterns
  (Drupal path-match syntax) on which the extra user data is exposed. Empty means
  never.
- **Roles** (`expose_user_details_roles`) — restrict that exposure to specific
  roles. Empty means all roles.
- **Current user meta** (`current_user_meta`) — which user property names to
  output when the user is exposed.
- **Expose user fields** (`expose_user_details_fields`, off by default) — also
  output the exposed user's opted-in field values, under a `userFields` key.

## Group integration

- **Group** (`group`, off by default) — when the Group module is installed, add
  the owning group's name for nodes.

## The Google helper library

- **Library helper** (`lib_helper`, off by default) — attach Google's
  `data-layer-helper` library on dataLayer pages. This requires the library file
  to be present (see [Installation](../installation/index.md)).

## Renaming the JSON keys

To match an existing analytics data contract, you can rename the key each value is
pushed under. Each of these settings holds the literal JSON key name:

| Setting | Default JSON key |
|---------|------------------|
| `entity_type` | `entityType` |
| `entity_bundle` | `entityBundle` |
| `entity_identifier` | `entityId` |
| `entity_title` | `entityTitle` |
| `group_label` | `groupLabel` |
| `drupal_language` | `drupalLanguage` |
| `drupal_country` | `drupalCountry` |
| `site_name` | `siteName` |

There is also a **key replacements** map (`key_replacements`) for renaming
exposed field sub-keys before output.

## Expose a single field's value

Individual fields are opted in one at a time — not on this settings form, but on
the field itself:

1. Go to the field's settings/edit form (for example under **Structure → Content
   types → *(your type)* → Manage fields**, then edit the field).
2. Tick the **Expose to dataLayer** checkbox that Data Layer adds to the form, and
   optionally give it a **label** — the JSON key its value will be pushed under.
3. Back on the Data Layer settings form, make sure **Output fields**
   (`output_fields`) is enabled.

Un-ticking the expose checkbox and saving automatically removes the stored
setting, so the field stops appearing in the dataLayer.

## Editing from the command line

Every option is stored in `datalayer.settings`, so you can read or change it with
core config commands instead of the form:

```bash
drush cget datalayer.settings                      # dump all settings
drush cset datalayer.settings output_terms true -y # toggle a boolean
drush cset datalayer.settings entity_type contentType -y  # rename a JSON key
```

## Verify the output

The simplest check is to load a front-end page and read `window.dataLayer` in your
browser's developer console. To confirm the always-present defaults without a
browser:

```bash
drush php:eval 'require_once DRUPAL_ROOT."/modules/contrib/datalayer/datalayer.module"; print json_encode(_datalayer_defaults());'
```
