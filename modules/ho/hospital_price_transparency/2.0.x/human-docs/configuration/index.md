# Configuration

Hospital Price Transparency works out of the box with sensible defaults. The main
things you'll touch are the **allowed file types**, the **permissions** that govern
who can manage and view HPT files, and the routine of **creating and publishing**
an HPT entity.

## Module settings — allowed file types

By default an HPT entity's file field accepts the CMS‑supported machine‑readable
formats: **XML, CSV, and JSON**. The module's settings form lets you adjust this
list of allowed extensions if your workflow needs it — but stay within what CMS
accepts for the standard‑charges file. Open the module's settings page (linked from
the module's entry under **Extend** / its help description) and save any changes.

## Permissions

The module provides its own permissions for creating and managing HPT entities.
Grant these on **People → Permissions** (`/admin/people/permissions`) to the roles
responsible for maintaining the charges file — typically an administrator or a
compliance‑focused editor role.

Crucially, **viewing** a published HPT file requires only Drupal's standard
**access content** permission, which anonymous visitors have by default. Leave that
as is: CMS requires the information to be accessible free of charge, without a user
account or password, and without submitting any personally identifying
information. Do **not** put the published file behind a login or a registration
wall.

## Create and publish a charges file

1. Create a new **HPT** entity.
2. Upload your standard‑charges file — CSV, JSON, or XML. For files too large to
   upload directly, use the **zip‑upload** support.
3. Fill in the required **EIN** and **hospital name** fields. The module uses these
   to generate the path alias in the CMS‑mandated form
   `[ein]_[hospitalname]_standardcharges.[json|csv]`.
4. **Publish** the entity. Its canonical URL now serves the file's contents
   directly, so a plain link to the entity is a direct link to the file.

## Make it findable

- **Link to it** from a publicly available page on your site — CMS requires a link
  posted on a public website.
- **Add it to your sitemap.** The HPT entities are compatible with the major
  contributed sitemap modules, so automated searches can discover the file.

## Data‑handling note

The charges file is **public compliance data** — it's meant to be seen by
consumers and regulators. There's nothing sensitive to protect here; the priorities
are that the file is **accurate** and that it is **served at the required public
path** without any barrier to access.
