# Configuration

Setup is short: choose which languages the side‑by‑side interface loads by
default, and grant the permission to the roles that should use it.

## Open the settings form

1. Log in as an administrator.
2. Go to `/admin/config/system/entity-translate-side-by-side`.

## Choose the default languages

On the settings page, **select the languages to be loaded by default** in the
side‑by‑side interface. These are the language columns a translator sees when they
open the translation screen. Users can adjust which languages they work with, but
these defaults set the starting point. Save the form when you're done.

## Grant the permission

The module adds a dedicated permission, **Access Entity Translate Side by Side**.
Assign it to the roles that should be able to use the side‑by‑side translation
screen:

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Find **Access Entity Translate Side by Side** and tick the box for each role
   that should have it.
3. Save permissions.

Grant this permission to the roles responsible for translating your site's
content.

## Using it

With the defaults and permission in place, open a translatable entity, choose
**"Translate side by side"** from the operations dropdown, and edit the languages
next to each other. Only translations you actually change are saved, and you can
drag‑and‑drop to navigate the languages.
