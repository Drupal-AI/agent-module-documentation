# Configuration

Menu Title length has a single setting: the maximum number of characters allowed in
a menu link title. It ships with a default of **20**, so you only need to visit
this form if you want a different limit.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Menu Title Length settings**, or navigate
   directly to `/admin/config/system/menu-title-length/settings`.

## The maximum length field

The form has one field — the **maximum menu title length** (in characters). Enter
the number you want and save. From then on, the menu link title field will refuse
input longer than that value across all `menu_link_content` links on the site.

- **Lower it** (for example to 20 or 30) to enforce short, consistent navigation
  labels that fit your theme's design.
- **Raise it** (up toward core's original 255) if some menus genuinely need longer
  labels.

Remember this changes the field's input‑validation length only; it does not touch
the database column, so you can adjust it freely without a storage migration.

## Save

Click **Save configuration**. The new limit takes effect immediately on the menu
link forms.

## Overriding the limit in settings.php

If you prefer to set the limit per environment (for instance a stricter cap on
production), you can override it in `settings.php` instead of — or in addition to —
the form. Add:

```php
$settings['menu_title_length'] = 40;
```

The module resolves the effective limit in this order: the value saved through the
settings form, then this `settings.php` value, then the built‑in default of 20 if
nothing is set. A `settings.php` value is a good way to lock the limit for a given
environment so it cannot be changed from the UI there.
