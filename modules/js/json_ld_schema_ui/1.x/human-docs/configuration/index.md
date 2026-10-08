# Configuration

There are two places to configure this module: the per‑bundle schema tab (where
most of the work happens) and a small global settings page.

## Configure schema for a bundle

1. Go to the bundle you want to describe — for example **Structure → Content types
   → *(your type)* → manage**, or a block type at
   `/admin/structure/block/block-content/manage/basic`.
2. Open the **schema configuration (vertical) tab** the module adds to that form.
3. **Choose one or more schema types** for the bundle (for example *Article*,
   *Event*, *Product*, *Movie*).
4. For each type, **select the properties to enable** and **set default values**
   for them. If the Token module is installed, a token browser appears to help you
   use entity‑specific tokens in those defaults. (Tokens are replaced whether or
   not the Token module is installed — it just makes browsing them easier.)
5. For properties that **reference another schema type**, expand them and configure
   the referenced type's (nested) properties just like top‑level ones — for
   example, enabling a Movie's `actor` and then the Person `name` or `birthDate`
   underneath it.
6. Save the bundle form.

Once a bundle has schema settings, the module creates a **field** on it to hold the
per‑entity values. When editing content, the field's widget lets you pick one of
the configured schema types and fill in the enabled properties (pre‑filled with
your defaults). On render, the resulting JSON‑LD snippet is added to the page head.

## Manage all bundles at once

You can review and manage the configurations for every bundle in one place at
**Configuration → Search and metadata → Content Schema Settings**
(`/admin/config/search/schemaorg/settings`).

## Global settings

The same area has a **Settings** page (**Content Schema Settings → Settings**,
`/admin/config/search/schemaorg/settings`) with some basic module‑wide options.
The defaults are fine for most sites.

- **Select2‑based selector (optional).** If the Select2 module is installed, you
  can enable a Select2‑based schema‑type configuration instead of the default
  hierarchical Ajax‑based selector.

> **Caution:** These global settings are currently not fully validated, so changing
> them carelessly can break the module's functionality. Change them only when you
> know what a setting does, and leave the defaults in place otherwise.

## Save

Click **Save configuration** to store your changes. To confirm the markup is being
emitted, view a piece of content that has schema values set and check the page
source for a `<script type="application/ld+json">` block in the head — or run the
URL through Google's Rich Results Test.
