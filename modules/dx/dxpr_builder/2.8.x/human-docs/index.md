# DXPR Builder — manual setup guide

**DXPR Builder** (`dxpr_builder`) is a commercial visual, drag-and-drop
page/layout builder for Drupal. It turns an ordinary long-text field into a
full front-end editor: editors design rich content — sections, columns, elements,
animations — directly on the front end of the page, with Bootstrap markup
underneath. It's aimed at giving marketers and editorial teams a governed,
low-code way to build landing pages without touching code or Views admin.

You switch it on for a specific text field by setting that field's display
**formatter** to **DXPR Builder**. Users who have the *Edit with DXPR Builder*
permission can then edit that field in place on the front end. Beyond raw layout,
DXPR Builder offers reusable page templates and user-saved snippets, per-role
"profiles" that control exactly which elements, blocks, and Views each role may
use, an embeddable set of blocks (License Info, user register, Webform), content
locking so two editors don't overwrite each other, and an extensive optional
AI feature set for generating page content and images.

> **This is a commercial, licensed product.** DXPR Builder requires a valid
> **licence key (a JWT/API key)** from DXPR to run. Without a key, the live visual
> editor will not fully load — the module enforces per-user "billable user" access
> against DXPR's central license service. The module's *configuration* is still
> fully usable (settings, profiles, templates, the field formatter) without a key,
> but real editing needs the licence. The module is distributed under DXPR's
> commercial terms (see <https://dxpr.com/legal/terms>), not GPL, and it lives in
> the `dxpr/dxpr_builder` Composer namespace rather than `drupal/…`. The
> [Installation](installation/index.md) page covers how to store the key securely
> in an environment variable and a Key entity.

Three optional submodules extend it: **DXPR Builder Page** (`dxpr_builder_page`)
adds a ready-made drag-and-drop content type, **DXPR Builder Block**
(`dxpr_builder_block`) adds a drag-and-drop custom block type, and **DXPR Builder
Media** (`dxpr_builder_media`) adds a media-library image picker inside the
builder.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and submodules, and store your licence key securely.
2. [Configuration](configuration/index.md) — the settings form, licensing, AI
   settings, profiles and templates, and how to turn the builder on for a field.

## Where it lives in the admin menu

All of DXPR Builder's admin pages sit under **DXPR Studio**
(`/admin/dxpr_studio/dxpr_builder`):

- **Settings** — `/admin/dxpr_studio/dxpr_builder/settings` (licence key,
  Bootstrap version, media browser, and more).
- **AI settings** — `/admin/dxpr_studio/dxpr_builder/ai_settings`.
- **Profiles** — `/admin/dxpr_studio/dxpr_builder/profile` (per-role allow-lists).
- **Page templates** — `/admin/dxpr_studio/dxpr_builder/page_template`.
- **User templates** — `/admin/dxpr_studio/dxpr_builder/user_templates`.

## How to use it

At a high level: install and licence the module, decide which roles can build
(via permissions and a profile), then enable the builder on a field by setting
that field's formatter to **DXPR Builder** under the content type's *Manage
display*. Editors with *Edit with DXPR Builder* then edit that field visually on
the front end. See [Configuration](configuration/index.md) for the step-by-step.
