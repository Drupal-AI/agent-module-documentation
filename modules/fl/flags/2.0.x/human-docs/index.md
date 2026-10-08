# Flags — manual setup guide

**Flags** (`flags`) renders flag icons for countries and languages from a bundled
CSS‑sprite icon set, and provides a small mapping API (code → flag) plus
configuration entities for overriding which flag a given code maps to. It's the
foundation for showing country flags next to content, adding flags to the language
switcher, and building flag‑decorated country/language fields on a multilingual
site.

The base module itself is a toolkit: it gives you a `flags` theme hook that turns a
country or language code into a `<span class="flag flag-xx">` styled by the
bundled sprite (so there are no per‑flag image requests), a canonical list of 250+
flag codes and names, and mapping services you can reuse in custom render arrays.
Because flags don't always line up with codes (for example, you may want the
English language to show the GB or US flag), you can create **mapping overrides**
that point a code at a different territory's flag, and manage them as exportable
configuration.

On its own the base module ships **no UI and no field integration** — those come
from four submodules you enable as needed:

- **Flags: Country** (`flags_country`) — a formatter and select/autocomplete
  widgets for country fields.
- **Flags: Language** (`flags_language`) — a formatter and widget for the core
  language field, plus flags on the language‑switcher block and links.
- **Flags: Language Field** (`flags_languagefield`) — formatter and widget for the
  contrib Language Field module.
- **Flags: UI** (`flags_ui`) — the admin screens for creating and editing the
  code‑to‑flag mapping overrides (guarded by the *Administer flag mapping*
  permission).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it, and choose the submodules you need.
2. [Configuration](configuration/index.md) — managing code‑to‑flag mapping
   overrides with the Flags UI submodule, and where the field/switcher settings
   live.

## Where it lives in the admin menu

The base module adds no admin page. Once you enable the **Flags: UI** submodule,
mapping overrides are managed under the admin interface behind the *Administer flag
mapping* permission (see [Configuration](configuration/index.md)). Field flag
settings live on the usual **Manage form display** / **Manage display** tabs once
the relevant field submodule is enabled, and language‑switcher flags come from the
**Flags: Language** submodule.

## How to use it

The base module is mostly used through its submodules and its theme hook:

- **Country/language field flags** — enable **Flags: Country** and/or
  **Flags: Language**, then choose the Flags formatter (and widget) on your field's
  display/form‑display tabs. The formatters can place the flag before, after, or
  instead of the label. (The flag‑decorated *select* widgets need the Select Icons
  module.)
- **Language switcher flags** — enable **Flags: Language** to add flags to the core
  language switcher block and its links, for a flag‑based language menu.
- **Render a flag anywhere (developers)** — use the `flags` theme hook in a render
  array, passing the code and the source (`country` or `language`), and attach the
  `flags/flags` library so the sprite CSS loads:

  ```php
  $build['flag'] = [
    '#theme' => 'flags',
    '#code' => 'fr',
    '#source' => 'country',
  ];
  $build['#attached']['library'][] = 'flags/flags';
  ```

  You can also reuse the `flags.mapping.country` / `flags.mapping.language`
  services and `FlagsManager::getList()` (the 250+ code/name list, alterable via
  `hook_flags_alter`) in your own code.
