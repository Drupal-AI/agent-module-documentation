# Configuration

DXPR Builder has several pieces to configure: the global **settings** form (most
importantly your licence key), the optional **AI settings**, per-role **profiles**,
reusable **templates**, and finally turning the builder on for a specific field.
All the admin pages live under **DXPR Studio** at
`/admin/dxpr_studio/dxpr_builder`. You'll need the **Administer DXPR Builder
configuration** permission for the settings and AI pages.

## Global settings

Go to **DXPR Studio → Settings**
(`/admin/dxpr_studio/dxpr_builder/settings`). The key fields:

- **Licence key / API key (JWT)** — this is what activates the editor. You can
  either paste the JWT directly (stored in plain config), or choose to store it in
  a **Key entity** and select the key you created during
  [installation](../installation/index.md). The Key-entity option is strongly
  recommended so the secret stays out of exported configuration. Changing the key
  triggers a re-sync of your users against DXPR's licence service.
- **Bootstrap version** — which version of Bootstrap DXPR loads, so the builder's
  grid and components match your theme.
- **Editor formatting styles** — the set of text-editor formatting styles offered
  inside the builder.
- **Editor assets source** — where the editor's JavaScript/CSS assets are served
  from.
- **Apply text-format filters to output** — whether the builder's stored HTML is
  run through the field's text-format filters when rendered, or output as-is.
- **Media browser** — which image picker the builder uses (for example *Media
  Library*, or basic upload if left empty). The **DXPR Builder Media** submodule
  provides the media-library option.
- **Smooth-scroll offset selector** — a CSS selector used so in-page anchor links
  account for a sticky/fixed header (the default targets DXPR's own sticky header
  classes).

Save the form. You can inspect the stored values at any time with
`drush cget dxpr_builder.settings`.

## AI settings

DXPR Builder includes an optional AI feature set (generate page content and
images from inside the builder). Configure it at **DXPR Studio → AI settings**
(`/admin/dxpr_studio/dxpr_builder/ai_settings`). Notable options:

- **Enable AI**, and separately **enable page generation** and **image generation**.
- **Default AI model**, and whether editors may pick their own model.
- **Provider selection** — automatic (the default) or a weighted list of providers.
- **Tone-of-voice** and **commands** taxonomies — optionally drive the AI's tone
  and available commands from vocabularies you control.
- **Output sanitization** — restrict AI output to **allowed HTML tags**, strip
  specific tags, and limit generated images to **allowed domains**, for safety and
  brand control.

> If you're wiring up an AI provider here, note that DXPR's AI settings expect a
> provider/model configuration; consult DXPR's own documentation for the current
> provider list and any keys they require, and store any provider secrets in
> environment variables / Key entities rather than plain config.

## Profiles — govern what each role can build

A **DXPR Builder profile** binds a set of **roles** to allow-lists of what those
roles may use in the builder: which elements, blocks, Views, page templates, and
user templates, plus which inline/modal buttons. This is how you give, say,
marketers a rich toolset while keeping other roles constrained.

1. Go to **DXPR Studio → Profiles**
   (`/admin/dxpr_studio/dxpr_builder/profile`).
2. Add a profile, give it a label, tick the roles it applies to, and either allow
   everything of a given kind (the "all elements / all blocks / …" switches) or
   pick specific items.
3. Save. Managing profiles requires the **Administer DXPR Builder profile**
   permission.

## Templates

- **Page templates** (`/admin/dxpr_studio/dxpr_builder/page_template`) are reusable
  full-page designs editors can drop in as a starting point. Five ship by default
  (about me, about us, basic homepage, split content and buttons, text columns).
- **User templates** (`/admin/dxpr_studio/dxpr_builder/user_templates`) are
  reusable snippets (sections/rows) that editors save themselves for later reuse.

Creating and editing page/user templates requires core's **Administer site
configuration** permission.

## Turn the builder on for a field

DXPR Builder is applied as a **field formatter**, so you enable it per field on the
entity's display:

1. Go to the content type's **Manage display** — for example
   **Structure → Content types → Article → Manage display**.
2. Find the long-text field you want to make visual (it must be a *Text*,
   *Text (formatted, long)*, or *Text (formatted, long, with summary)* field) and
   set its **Format** to **DXPR Builder**.
3. Save.

Now users with the **Edit with DXPR Builder** permission edit that field in place
on the front end using the visual editor. The stored field value is the builder's
HTML.

## Permissions

DXPR Builder ships three permissions:

- **Edit with DXPR Builder** (`edit with dxpr builder`) — the per-editor
  permission that lets a user build and edit content with the front-end visual
  editor. This is also what counts a user as a "billable user" against the licence.
  It does **not** grant access to the admin screens.
- **Administer DXPR Builder configuration** (`administer dxpr builder
  configuration`) — access to the DXPR Studio settings, AI settings, licence/user
  pages, and page-template creation.
- **Administer DXPR Builder profile** (`administer dxpr_builder_profile`) —
  create/edit/delete the per-role profiles.

Note that even with *Edit with DXPR Builder*, the live editor's AJAX routes are
additionally gated by a valid licence and billable-user status — so a user can
hold the permission but still be unable to edit if the site has no valid key or
they aren't an authorized ("avowed") billable user. You manage which users count
against your licence from the DXPR Studio user-license pages (avow/disavow).
