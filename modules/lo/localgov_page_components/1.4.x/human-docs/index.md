# LocalGov Page Components — manual setup guide

**LocalGov Page Components** (`localgov_page_components`) re-presents Drupal's
"Paragraphs library" feature as **Page components** — a friendlier name for
editors — and adds the pieces needed to build pages out of reusable, centrally
managed content blocks. Create a component once (a contact card, a call-to-action,
a link block), and reuse it across many pages, editing it in one place.

Out of the box it ships a ready-made, unlimited-cardinality node field,
`localgov_page_components`, that references paragraphs-library items, plus an
optional **Entity Browser** modal so editors can either pick an existing component
or create a new one inline without leaving the node form. It contributes no admin
settings page and no permissions of its own — access is governed by the underlying
Paragraphs library, Entity Browser, and node permissions.

Its most distinctive feature is **LinkIt** integration. Two LinkIt plugins let
rich-text authors link to reusable components: a *Page components* matcher that
lets you filter and group autocomplete suggestions by paragraph bundle (and honours
each item's view access), and a substitution plugin that resolves a selected
Contact or Link component to its real destination URL instead of an unhelpful
admin path. Although it's built for the LocalGovDrupal distribution (used by the
`localgov_services_page` content type), it works on any content type. An optional
**workflow** submodule adds content-moderation cascade behaviour.

This guide is written for a **human** setting things up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (several contrib
   dependencies), enable the module, and optionally the workflow submodule.

## Where it lives in the admin menu

There's no settings page. You work with existing UIs:

- **Reusable components** are managed as Paragraphs library items (presented as
  "Page components"), under **Content** (the paragraphs library listing).
- **The field** is attached on a content type's **Manage fields** / **Manage form
  display**.
- **LinkIt** integration is set up at **Configuration → Content authoring → LinkIt**
  (`/admin/config/content/linkit`).

## How to use it

1. Install and enable the module and its dependencies (see
   [Installation](installation/index.md)).
2. **Add the field to a content type.** The module ships only the field *storage*
   (`localgov_page_components`, an entity reference to paragraphs-library items). On
   the content type's **Manage fields**, add a field instance using that storage.
   (LocalGovDrupal attaches it to `localgov_services_page` for you.)
3. **Choose the Entity Browser widget.** On the content type's **Manage form
   display**, set the field's widget to **Entity browser** and select the
   `page_components` browser. This gives editors a modal with an *Available
   components* list (to select) and a *Create component* form (to add a new one
   inline). The browser config only installs if its supporting View is present.
4. **Build pages.** When editing a node, use the **Add/Select component** button to
   pick existing components or create new reusable ones.
5. **(Optional) Set up LinkIt.** At **Configuration → Content authoring → LinkIt**,
   edit a profile's matchers, **Add matcher → Page components**, restrict it to the
   *Link* and *Contact* paragraph bundles, enable *Group by bundle*, and set the
   **Substitution Type** to *Page components* so links resolve to real URLs. (This
   needs the LocalGov paragraph bundles.)

### Extending the LinkIt URL mapping

The substitution plugin has a built-in bundle-to-URL-field mapping (`localgov_contact`
→ `localgov_contact_url`, `localgov_link` → `localgov_url`), and other bundles fall
back to the component's own canonical URL. There's no config form for this mapping,
so supporting additional bundles means subclassing the substitution plugin or
patching the map — see the [`agent/` LinkIt docs](../agent/plugins/linkit.md).

### Workflow submodule

The bundled **`localgov_page_components_workflow`** submodule adds content-
moderation cascade behaviour, so component changes can be gated behind node
publication. Enable it only if you use content moderation and want that behaviour.
