# Media Library Translate — manual setup guide

**Media Library Translate** (`media_library_translate`) adds a small **translate
button** to items selected in the Media Library widget. On a multilingual site,
an editor who has just picked an image on a node form can jump straight to that
media item's translation overview — to translate its alt text, name, or caption —
without abandoning the form they were filling in.

The problem it solves is friction. Media metadata such as alt text lives on the
media entity, not on the node using it, so translating it normally means leaving
the content form, navigating to the media entity, finding its translations tab,
translating, and coming back. That is enough of a detour that in practice it often
doesn't happen, and sites end up with English alt text across every language. This
module puts the action where the decision is made: a button on the selected media
item opens the media entity's translation overview (currently in a modal).

It is a deliberately small module — it changes no translation behaviour of its
own, adds no routes, permissions, or configuration, and is simply a shortcut into
the translation UI that Drupal already provides. That makes it cheap to adopt and
cheap to drop. It depends on core's **Media**, **Media Library**, and **Content
Translation** modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   set up the multilingual prerequisites.

There is **no configuration page** for this module. The one thing you do turn on
is the button itself, per Media reference field — described under "How to use it"
below.

## Where it lives in the admin menu

The module adds no admin page of its own. You enable its button on a field's
**Manage form display**, and editors then see it inside the Media Library widget
on content forms.

## How to use it

The button only makes sense once your site is genuinely multilingual, so the
setup has three parts:

1. **Enable media translation.** After enabling Content Translation, visit
   **Configuration → Regional and language → Content language and translation**
   (`/admin/config/regional/content-language`) and enable translation for your
   media types.
2. **Add more than one language.** Add the languages your site needs at
   **Configuration → Regional and language → Languages**
   (`/admin/config/regional/language`).
3. **Turn on the translate button.** On the content type that has your Media
   reference field, open its **Manage form display**, click the gear (settings)
   icon for the field that uses the **Media Library** widget, and enable the
   **Show translation button** option. Save.

Now, when an editor selects a media item in that widget, a translate button
appears on the selected item and opens the media entity's translation overview.
