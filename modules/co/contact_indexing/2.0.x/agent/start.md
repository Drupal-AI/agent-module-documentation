<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contact Form Indexing (contact_indexing) — agent index

info.yml name **Contact Form Indexing**, version **2.0.2**, core `^9 || ^10 || ^11`, package Custom.
No dependencies, no libraries. Entire module is one procedural file: `contact_indexing.module`
(plus README, LICENSE, info.yml). No routes, no services, no permissions file, no config schema,
no install file, no templates, no src/.

## What it actually does (read the source, not the old stub)

It is **not** a submission-storage / Search-API indexer. It is a small SEO add-on that lets an
admin flip a per-contact-form flag so that form's canonical page emits a `robots` meta tag with
`content="index, follow"`. Two mechanisms:

- **`hook_form_FORM_ID_alter` for `contact_form_form`** (the contact-form *config-entity* edit form,
  at `/admin/structure/contact/*`): adds an **Enable form indexing** checkbox
  (`contact_indexing_robot_crawling`). Its value is stored as a third-party setting
  `contact_indexing.robot_crawling` on the `contact_form` config entity via an `#entity_builders`
  callback (`contact_indexing_contact_form_form_builder`). Default FALSE.
- **`hook_preprocess_html`**: on route `entity.contact_form.canonical` only, if the form's
  `robot_crawling` third-party setting is truthy, it either rewrites an existing `robots` head meta
  tag's `content` to `index, follow`, or appends a new `robots` meta tag `index, follow`. Does
  nothing (no tag added) when the flag is off — it never emits `noindex`; it only *promotes* selected
  forms to indexable.
- **`hook_help`** for `help.page.contact_indexing`.

## The URL-alias side-effect (note this)

`contact_indexing_contact_form_form_submit` (appended to the edit form's submit handlers) reads a
form value **`contact_storage_url_alias`** and creates/updates/deletes a `path_alias` entity for the
contact form's canonical path. That form field is **not defined by this module** — it comes from the
**contact_storage** contrib module. So the alias logic is effectively dead unless contact_storage (or
something else) adds a `contact_storage_url_alias` element to the contact-form edit form; with plain
core Contact the submit handler runs but the value is empty and no alias is written. This is an admin
-only path (editing contact forms requires `administer contact forms`).

## Data / config

- No config entities or settings form of its own. The single setting is a **third-party setting**
  (`robot_crawling`) on each core `contact_form` config entity. The module ships **no** config schema
  for it.

## Files
- `data.json` — metadata.
- `usage.md` — one-liner + mechanism + use-case bullets.
- `human-docs/` — human setup guide (no central settings page; per-form checkbox).
