# Configuration

Entity Display Template has no standalone settings page. You configure a template
per view mode, directly on that view mode's **Manage Display** form.

## Open the display form

1. Log in as a user allowed to administer the entity type's display (a
   site-builder/administrator).
2. Go to **Structure → (your entity type) → Manage display** — for example
   **Structure → Content types → Article → Manage display**.
3. Pick the **view mode** you want to override (Default, Teaser, Full, or a
   custom one). If the view mode isn't shown yet, enable it under *Custom display
   settings* at the bottom of the form first.

## The "Display Template options" section

Scroll down and expand **Display Template options**. It has two controls:

- **Enabled** — a checkbox. When ticked, this view mode renders your custom Twig
  instead of the default field output. Leave it unticked to fall back to normal
  rendering at any time (your template text is kept, just not used).
- **Twig template** — a CodeMirror editor where you write the inline template.

Both values are stored as third-party settings on the view-display config entity
(`entity_display_template.enabled` and `entity_display_template.twig`), so they
travel with your configuration export and deploy like any other display setting.

## What you can print in the template

Every field **enabled** on this display is available by its machine name as a
render array — print it with double braces:

```twig
<article class="card">
  <h2><a href="{{ link }}">{{ label }}</a></h2>
  {{ field_summary }}
  {% if user_is_logged_in %}{{ field_body }}{% endif %}
</article>
```

A field must be enabled on the display to be printable — if you hid a field, it
won't be in the template context.

Alongside your fields, these helper variables are always available:

- `link` — URL to the entity's canonical page.
- `entity_id` — the entity's ID.
- `active_theme` and `active_theme_directory` — the current theme and its path,
  handy for building asset URLs.
- `base_path` — the site's base path.
- `front_page` / `is_front_page` — the configured front page and a flag for
  whether the current page is it, so you can vary output on the home page.
- `current_language` — the active language code, useful for localized output.
- `user_is_admin` and `user_is_logged_in` — booleans to branch your markup on
  who is viewing.

## Save

Click **Save** at the bottom of the Manage Display form. The view mode renders
your template immediately.

## Important security note

The template is executed through Drupal's `inline_template` **without Twig's
sandbox**. In practical terms, anyone who can edit this display can run arbitrary
Twig — which is code execution — for every visitor who sees this view mode. That
is by design, but it means:

- Treat the display-administration permission as **PHP-equivalent trust**. Only
  grant it to people you trust to run code on the server.
- Do **not** enable this module on sites where semi-trusted users (for example
  contributors who can reach Manage Display) exist.

There is no user-facing form or route that feeds untrusted input into the
template — the only way a template gets set is through this admin form.
