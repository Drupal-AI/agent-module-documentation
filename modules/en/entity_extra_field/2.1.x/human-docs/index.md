# Entity Extra Field — manual setup guide

**Entity Extra Field** (`entity_extra_field`) lets you attach configurable
"extra" fields — really *pseudo* fields — to any content entity's display,
positioned right alongside your real fields on the *Manage display* and *Manage
form display* tabs. An extra field isn't stored data; it's a piece of computed
output you assemble from one of six building blocks: a **block**, an embedded
**view**, a **token** value, an inline **Twig** template, an **entity link**
(canonical/edit/delete), or a **Single Directory Component**. Once placed, it
renders like any other field and can be dragged into position among them.

Each extra field you create is saved as configuration (an `entity_extra_field`
config entity) that records which entity type and bundle it targets, whether it
appears on the view or the form display, which building-block plugin it uses and
that plugin's settings, and any visibility conditions. Conditions use Drupal's
core Condition plugins (path, role, node type, and so on) and can be combined
with AND ("all must pass") or OR ("any passes"), so an extra field can appear
only in the situations you choose.

The base module has **no admin screen of its own** — it is the engine. To create
and manage extra fields through the UI you enable the bundled
**entity_extra_field_ui** submodule, which adds a "Manage extra fields"
operation to each bundle plus the add/edit/delete forms. A report at
**Reports → Extra fields** (`/admin/reports/extra-fields`) lists everything you
have configured. Everything is gated by the **Administer entity extra field**
permission — treat it as trusted-admin-only, because the Twig building block can
run arbitrary template code and the token block has a raw-HTML option.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and turn on the UI submodule.

## Where it lives in the admin menu

The base module adds no menu link. Once you enable **entity_extra_field_ui**,
each content type / bundle gains a **Manage extra fields** tab, for example
`/admin/structure/types/manage/article/extra-fields`. A site-wide audit of every
configured extra field is at **Reports → Extra fields**
(`/admin/reports/extra-fields`).

## How to use it

1. Enable the **entity_extra_field_ui** submodule (see
   [Installation](installation/index.md)); it requires core's **Field UI**.
2. Go to the bundle you want to extend — for a content type that is
   *Structure → Content types → (your type) → Manage extra fields*.
3. Click **Add extra field**, give it a label and machine name, choose whether
   it lives on the **view** or the **form** display, and pick a field type:
   - **Block** — render any block plugin (a menu, a custom block, a system
     block) with its own configuration form.
   - **Views** — embed a view display, optionally passing a token such as
     `[node:nid]` as a contextual argument, with offset and title control.
   - **Token** — output a token value like `[node:author:name]` as plain text,
     as a formatted (text-format) value, or — only if you deliberately need
     markup — as unfiltered raw HTML.
   - **Twig** — render an inline Twig template that can read `entity` and site
     context (`{{ entity.title.value }}`, current theme, language, and so on).
   - **Entity link** — output one of the entity's link templates, such as the
     canonical, edit-form, or delete-form link.
   - **Component** — render a Single Directory Component with props and slots
     mapped from the entity.
4. Optionally add **visibility conditions** and choose whether **all** must pass
   (AND) or **any** (OR).
5. Save, then go to the bundle's **Manage display** (or **Manage form
   display**) tab. Your new extra field starts in the *Disabled* region — drag
   it up into position among the real fields and save.

Because everything is stored as configuration, you can safely **disable the UI
submodule in production** once your extra fields exist — the fields keep
rendering. A couple of building blocks carry power that deserves respect: the
**Twig** field runs admin-entered template code (effectively arbitrary code for
whoever can edit extra fields), and the **token** field's *unfiltered* option
emits raw HTML. Both are gated behind *Administer entity extra field*, so grant
that permission only to people you trust.
