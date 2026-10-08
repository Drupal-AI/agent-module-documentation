# Strip field outer div — manual setup guide

**Strip field outer div** (`field_stripouter`) gives themers a simple way to remove
the wrapping `<div>` markup around a field's output — controlled from the field's
**Manage display** formatter settings rather than from code. It adds a **"Strip
outer div"** checkbox to every field formatter and, at render time, exposes your
choice to the field template as a Twig variable named `stripouter_valueonly`.

The module itself doesn't strip any markup — it provides the flag. Your theme's
`field.html.twig` reads the variable and decides whether to render the field's
value with or without Drupal's default wrapper divs. Because the setting lives on
the display, you can have the surrounding divs on one field in one view mode and
strip them on another, all without a separate template override per field.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** for this module — it has no settings form, no
routes, and no permissions of its own. Setup happens in your field template and on
each field's display, described in "How to use it" below.

## How to use it

1. In your custom (or sub‑) theme, copy `field.html.twig` from Drupal core
   (`core/modules/system/templates/field.html.twig`) or from the parent theme.
2. Edit the copy so it honors the flag, for example:

   ```twig
   {% if stripouter_valueonly %}
     {% for item in items %}
       {{ item.content }}
     {% endfor %}
   {% else %}
     {# ...the normal wrapped markup... #}
   {% endif %}
   ```

3. Clear the cache so Drupal picks up the template.
4. Go to **Structure → Content types → *(your type)* → Manage display**, edit a
   field's formatter settings, and tick **Strip outer div**. The formatter summary
   shows **"Outer divs stripped"** so you can see at a glance which fields have it
   enabled.

The checkbox appears wherever formatter settings do, and editing display settings
already requires the relevant field/display administration permission — so there's
nothing extra to grant.
