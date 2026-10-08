# Media Library Widget Texts — manual setup guide

**Media Library Widget Texts** (`media_library_texts`) lets you overwrite the text
shown in Drupal core's **Media Library widget**. The classic example is changing the
**"Add media"** button to say **"Add image"** — but the same applies to the widget's
empty‑selection notice and its "items remaining" messages. You get per‑field, per‑site
phrasing (and clearer guidance for your editors) without overriding Twig templates or
patching core.

It's a small, focused module. There is **no separate settings page and no dedicated
permission**: you configure the wording directly on each field's **Manage form display**
entry, in the settings for the **Media library** widget. Your text then replaces core's
defaults wherever that field's widget appears.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — where you enter your replacement texts,
   on the field's **Manage form display** → **Media library** widget settings.

## Where it lives in the admin UI

There is no "Media Library Texts" page under Configuration. Instead you edit the wording
per field, at **Structure → (your entity type) → Manage form display** — for a content
type that's `/admin/structure/types/manage/<type>/form-display`. Set the media field's
widget to **Media library**, then click the **gear/cog icon** to reveal the text fields.
See [Configuration](configuration/index.md) for the step‑by‑step.

## How to use it

Enable the module, open the **Manage form display** for the entity that has your media
field, make sure the field uses the **Media library** widget, click the gear icon, type
the wording you want in place of the defaults (for example replacing "Add media" with
"Add image"), and save. Editors then see your text on that field's widget.
