<!-- SPDX-License-Identifier: LicenseRef-DXPR-Commercial -->
DXPR Builder is a commercial visual drag-and-drop page/layout builder for Drupal: editors design rich content (sections, columns, elements, animations) directly on the front end of a text field, backed by Bootstrap markup.

---

DXPR Builder turns a long-text field into a full front-end visual editor. You enable it by setting a field's display **formatter** to **DXPR Builder** (`dxpr_builder_text`, for `text` / `text_long` / `text_with_summary` fields); users with the *Edit with DXPR Builder* permission then edit that field in place. The module is **licensed** — it needs a JWT/API key (entered at `admin/dxpr_studio/dxpr_builder/settings` or stored in a Key entity) and enforces per-user "billable user" access via a central license service, so on a site without a valid key the live editor will not fully load; its configuration surface, however, is fully inspectable. Global settings live in the `dxpr_builder.settings` config object (Bootstrap version, media browser, text-format handling, editor asset source, JWT/key storage, and an extensive AI feature set: providers, model, page/image generation, tone/command taxonomies, output sanitization). Three config **entity types** shape the experience: `dxpr_builder_profile` (per-role allow-lists of which elements, blocks, views, and templates a role may use), `dxpr_builder_page_template`, and `dxpr_builder_user_template` (reusable saved designs). Admin pages hang under **DXPR Studio** (`/admin/dxpr_studio/dxpr_builder`). It also provides helper Block plugins (license info, user register, Webform embed), Action plugins to avow/disavow users from billing, a Views field, content locking, and hooks to extend the utility-class and button lists. Three submodules add ready-made drag-and-drop **content** (`dxpr_builder_page`), a drag-and-drop **block type** (`dxpr_builder_block`), and a **media browser** (`dxpr_builder_media`).

---

- Give marketers a front-end drag-and-drop editor to build landing pages without code.
- Enable visual editing on an existing body/text field by switching its formatter to DXPR Builder.
- Build multi-column, section-based layouts with Bootstrap grid markup.
- Restrict which elements/blocks/views a given role can use via a DXPR Builder profile.
- Offer reusable page templates editors can drop in as a starting point.
- Let editors save their own reusable "user templates" (sections/rows) for later.
- Add a drag-and-drop landing-page content type quickly (dxpr_builder_page submodule).
- Add a drag-and-drop custom block type for reusable page components (dxpr_builder_block submodule).
- Provide a media-library/entity-browser image picker inside the builder (dxpr_builder_media submodule).
- Embed existing Drupal blocks and Views inside builder content.
- Embed a Webform into builder content via the provided Webform block.
- Generate page content or images with AI from inside the builder (AI settings).
- Constrain AI output to allowed HTML tags and image domains for safety/brand control.
- Choose the default AI model and whether editors may pick a model.
- Store the DXPR license/API key securely in a Key entity instead of plain config.
- Select the Bootstrap version DXPR loads to match a theme.
- Choose a media browser (e.g. Media Library) for image selection in the builder.
- Manage which users count against the DXPR user license (avow/disavow actions).
- Lock content being edited so two users don't overwrite each other (content lock service).
- Display remaining license/user info to admins via the License Info block.
- Add a front-end user-register block styled for DXPR marketing pages.
- Extend the builder's utility CSS class list via hook_dxpr_builder_classes().
- Add custom button styles via hook_dxpr_builder_buttons_folders().
- Set a smooth-scroll offset selector so in-page anchor links respect a sticky header.
- Apply text-format filters to builder output (or bypass them) via the format_filters setting.
- Roll out a consistent, governed page-building experience across an editorial team.
- Deploy builder profiles, page templates and settings as exportable configuration.
