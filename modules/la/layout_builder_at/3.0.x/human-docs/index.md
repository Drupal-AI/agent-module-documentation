# Layout Builder Asymmetric Translation — manual setup guide

**Layout Builder Asymmetric Translation** (`layout_builder_at`) lets every
translation of an entity have its **own** Layout Builder layout — different
sections, different blocks, a different order, per language. Out of the box, core
keeps the Layout Builder override field non-translatable, so all translations of a
node are forced to share one identical layout. This module makes that field
translatable and clears away the obstacles core puts in the way, so the *Layout*
tab becomes reachable on each translation and editors can arrange each language
independently.

It also ships one editor convenience: a field widget with a **"Copy blocks into
translation"** checkbox that appears on the *add translation* form. Tick it and the
new translation starts as a deep copy of the source layout — every section is
cloned, inline (non-reusable) blocks are duplicated so their text can be translated
separately, and reusable block placements are preserved. Leave it unticked and the
translation starts from an empty layout. A single setting controls whether that
checkbox starts unchecked, checked, or checked-and-hidden.

Because it works by making core's layout field translatable, there is **no settings
form** — you configure it entirely through the standard *Manage display*, *Content
language*, and *Manage form display* screens. It requires core's **Layout Builder**
and **Content Translation** modules, and it is mutually exclusive with **Layout
Builder Symmetric Translations** (`layout_builder_st`) — never enable both on the
same site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module
   and its two dependencies.

## Where it lives in the admin menu

There's no dedicated settings page. You set it up across three standard admin
screens:

- **Structure → Content types → *(your type)* → Manage display** — turn on Layout
  Builder overrides.
- **Configuration → Regional and language → Content language and translation**
  (`/admin/config/regional/content-language`) — enable translation and tick the
  *Layout* field.
- **Structure → Content types → *(your type)* → Manage form display** — place the
  "Copy blocks into translation" widget.

## How to set it up

After installing and enabling the module (see
[Installation](installation/index.md)), configure a content type in three steps:

1. **Enable Layout Builder overrides.** On the content type's **Manage display**
   tab, choose **Use Layout Builder** and tick **Allow each content item to have
   its layout customized**. Saving this creates the layout field — and because the
   module is active, that field is created as *translatable* automatically. (On a
   site that already used Layout Builder, enabling this module converts the existing
   layout fields to translatable for you.)

2. **Enable translation for the Layout field.** Go to **Configuration → Regional
   and language → Content language and translation**, enable translation for your
   entity type and bundle, and tick the **Layout** field. Core normally shows a
   "Non translatable" warning here — the module removes it so you can tick the box
   normally.

3. **Place the copy widget.** On the content type's **Manage form display** tab,
   set the widget for the Layout field to **Layout Builder Asymmetric Translation**
   (machine name `layout_builder_at_copy`). Its one setting, **Appearance**,
   controls the "Copy blocks into translation" checkbox on the add-translation
   form:

   | Appearance | Effect on the *add translation* form |
   |------------|--------------------------------------|
   | **Unchecked** *(default)* | Checkbox shown, unticked — the editor decides. |
   | **Checked** | Checkbox shown and ticked by default. |
   | **Checked (hidden)** | Copying is forced on and the checkbox is hidden from the editor. |

   Do **not** leave the core "Layout Builder Widget" selected here — once the layout
   field is translatable the module blocks saving the form with that widget and
   tells you to pick a different one.

Now, when you add a translation of a node, you get the "Copy blocks into
translation" checkbox: ticked, the translation starts as a full copy of the source
layout you can then edit freely; unticked, it starts empty. Either way, changes to
one language's layout no longer affect the others.

### Optional: inline block language

New inline blocks you create inside Layout Builder are automatically stamped with
the host entity's language. If you'd rather turn that off, add this to
`settings.php`:

```php
$settings['layout_builder_at_set_content_block_language_to_entity'] = FALSE;
```
