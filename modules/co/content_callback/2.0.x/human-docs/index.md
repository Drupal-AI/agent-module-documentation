# Content callback — manual setup guide

**Content callback** (`content_callback`) provides a **field type whose stored value
is a plugin** — a "content callback". When the field is displayed, the selected
plugin runs and renders dynamic content into the entity. In effect, it lets editors
pick from a curated list of developer‑built dynamic snippets — a widget, a computed
listing, a formatted block of markup — and drop one into a node or other entity,
without ever exposing arbitrary code. It depends on core's Field and Options
modules.

The appeal is that the chosen callback's output lives inside a real entity, so it
inherits everything an entity gives you: a URL alias, a menu item, meta tags, and —
notably — it becomes **searchable**. Developers define the available callbacks as
annotated **ContentCallback plugins** (extending `PluginBase`); each plugin can offer
its own configuration options. The field widget then simply shows editors a select
list of those plugins, and the field formatter renders the chosen one at display
time. Because the field stores a **plugin id chosen from a fixed list** — never a
user‑supplied function name — there's no arbitrary code execution; the design is
sound.

The module is deliberately developer‑facing: there's **no global settings page**.
You add a Content callback field to a bundle, developers supply the plugins, and
optional submodules extend where callbacks can appear. This project is covered by
Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and pick the submodules you need.

There is **no configuration page** for this module — you set it up by adding a field
and (as a developer) supplying callback plugins. See "How to use it" below.

## How to use it

1. **Add the field.** On a content type or other fieldable bundle (**Structure →
   Content types → *(type)* → Manage fields**), add a **Content callback** field. Its
   widget presents a **select list of the available callback plugins**.
2. **Editors choose a callback.** When creating content, an editor picks one of the
   offered callbacks; if that plugin exposes options, they're configured here too.
3. **Display it.** On **Manage display**, the Content callback field's formatter
   renders the chosen plugin's output when the entity is viewed.
4. **Developers define callbacks** by implementing the `@ContentCallback` plugin
   (extend `PluginBase`) in a custom module. A bundled `content_callback_examples`
   submodule shows Basic, Options, Alter, and Filter patterns to copy from.

Optional submodules extend reach: **`content_callback_block`** lets you place
callbacks as blocks, and **`content_callback_views`** adds a custom Views display
that becomes available through the Content callback field.
