# Readonly Html Field — manual setup guide

**Readonly Html Field** (`readonly_html_field`) adds a new field type whose job is
to show a fixed block of formatted HTML — a note, an instruction, a terms‑of‑
service blurb — right on an entity's add/edit form (and on its rendered display),
without ever being editable per entity. You write the text once, in the field's
settings, and every add/edit form for that bundle then shows it read‑only.

It's the clean answer to a common need: "I want a paragraph of guidance to appear
above these fields on the node form." Rather than hacking it into a template or a
custom module, you add a Readonly Html field, type the guidance into a WYSIWYG
editor in the field settings, and you're done. Because the value lives in the
field's configuration rather than in each entity, the field deliberately stores
nothing per entity — it always reports as empty — so it never bloats your content
or shows up as editable data.

Two things make it handy for real sites. First, the content is **translatable**:
you can enter different text per site language, and if a translation is missing it
falls back to the default language. Second, it is **safe by design**: whatever you
type is always run through Drupal's text‑format filtering (`check_markup()`) with
the format you choose — it is never printed as raw HTML. Because the format is
picked by whoever configures the field, choose a restricted format such as
**Basic HTML** when less‑trusted roles can edit fields.

Typical uses are a webmaster/editor note on a content type's add/edit form, or a
terms‑of‑service block on the user registration form. The module depends only on
Drupal core and has no admin settings page of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module. You add and set up the field
through **Field UI**, described in "How to use it" below.

## Where it lives in the admin menu

Readonly Html Field adds no admin page. You work with it from **Manage fields** on
any bundle — for example **Structure → Content types → *(your type)* → Manage
fields**, or **Configuration → People → Account settings → Manage fields** for the
user registration form.

## How to use it

1. Go to the bundle's **Manage fields** and click **Create a new field** (or
   **Add field**).
2. Choose **Readonly Html field** (in the *formatted text* category) and give it a
   label, then save.
3. On the field **settings** form, enter the HTML you want to show. There is one
   WYSIWYG editor **per site language**, grouped in collapsible sections; the
   default language's box is open and required. Each box has its own **text
   format** (default **Basic HTML**) — pick a restricted format for text authored
   by less‑trusted roles.
4. Save. From now on, the entity's **add/edit form** shows the current language's
   text read‑only (falling back to the default language when a translation is
   empty), and the field's **formatter** shows the same HTML on the entity's
   display.

To reuse the same note across several bundles, add the field to each of them and
enter its text in the field settings.
