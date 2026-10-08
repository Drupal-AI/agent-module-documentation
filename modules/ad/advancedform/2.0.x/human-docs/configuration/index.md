# Configuration

Advanced Form is configured from its own settings form
(`advancedform.settings_form`), where you choose which form features to hide and
under what conditions.

## Set the permission first

Go to **People → Permissions** (`/admin/people/permissions`) and grant Advanced
Form's permission to the roles that should be allowed to manage which form
features are hidden. Because hiding elements shapes what editors see, keep this to
trusted administrators.

## Open the settings form

Navigate to the module's settings form (`advancedform.settings_form`), reachable
from the module's entry in the admin configuration once it is enabled.

## Choose what to hide and when

On the settings form you configure:

- **Which form features to hide** — the fields, options, or sections you want
  removed from view on the relevant admin/edit forms.
- **The conditions under which they are hidden** — so the elements disappear only
  in the situations you specify rather than always.

The result is a simpler, decluttered form for editors: the elements you select no
longer appear in the UI under the conditions you set.

## Save

Save the form when you are done. Your changes take effect on the affected forms
immediately.

## Remember: hiding is not access control

This is the single most important point about the module. Hiding a form element
only removes it from the visible UI — it does **not** remove it from the form or
the route, and it does **not** change any permissions or data behind it. A user
who can reach the form can still submit a hidden field by crafting the request
directly, and the underlying value is written just as it would be if the field
were visible.

So use Advanced Form purely for **tidiness**. If your goal is to genuinely prevent
someone from seeing or changing a setting or field, do not rely on this module —
use Drupal's real **permissions** and **field access** controls instead.
