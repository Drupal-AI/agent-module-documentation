# Configuration

Configuring FFT is two jobs: point it at a **safe template directory**, then
**write a template** and apply it to a field.

## Set the template directory

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Content authoring → Field Formatter Template**
   (`/admin/config/content/fft`).
3. Change the **template directory** from the default.

The default value is `sites/all/formatter` — a **Drupal 7 path that does not exist
on Drupal 8 and later**. Until you change it, FFT finds no templates and does
nothing, and the form gives no guidance about where to point it.

**Choose the directory carefully.** The setting is not validated, so it will
happily accept the public files directory (`sites/default/files`) — which is
exactly the wrong choice, because that folder is writable by the web server and
web‑accessible. A template planted there would be discovered and rendered with no
warning. Instead:

- Put the directory **inside your code repository** (so templates are version
  controlled and reviewed like the code they are).
- Keep it **outside `public://`** and **not writable by PHP**.
- Restrict who can write to it — anyone who can add a Twig file there controls
  markup FFT renders, and a hostile template can emit unescaped `<script>` (stored
  XSS).

After changing the setting, **clear the cache** so the change takes effect
(`drush cr`).

## Write a formatter template

Create a Twig file in your chosen directory. Two rules make it discoverable:

- The filename must start with the **`fft-`** prefix, e.g. `fft-inline-tags.html.twig`.
- The file must contain a **`{# Template Name: … #}`** header comment — the name
  shown in the formatter list.

An optional `{# Settings: … #}` block passes per‑template settings. Example:

```twig
{# Template Name: Inline Tags #}
{# Settings:
delimiter = >>
#}
{% set values = [] %}
{% for item in data %}
  {% set term = link(item.name.value, 'internal:/taxonomy/term/' ~ item.tid.value)|render %}
  {% set values = values|merge([term]) %}
{% endfor %}
{{ values | join(' ' ~ settings.delimiter ~ ' ') | raw }}
```

Inside the template you have three variables:

- **`data`** — all the values of the selected field.
- **`entity`** — the entity the field is attached to.
- **`settings`** — any extras declared in the `{# Settings: … #}` block.

## Apply the template to a field

1. Open **Structure → (your content type or bundle) → Manage display**.
2. For the field you want, choose the **Formatter Template** formatter.
3. Use the formatter's settings (the gear icon) to select your template — e.g.
   **Inline Tags**.
4. **Save**, then **clear the cache** (`drush cr`) so the new template renders.

The field now displays through your Twig template instead of a core formatter.

## Views Formatter (vff)

If you enabled the `vff` submodule, the same approach is available on a Views
field's formatter, letting you render Views output through an FFT template.
