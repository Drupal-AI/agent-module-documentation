# Configuration

Entity Add Another needs one quick setup step before the button appears: you tell
it which entity types and bundles should carry a "Save and add another" button on
their creation forms.

## Choose where the button appears

1. Log in as a user with permission to administer the module's settings (an
   administrator by default).
2. Go to **Configuration → Content authoring → Entity Add Another**, or navigate
   directly to `/admin/config/content/entity_add_another`.
3. On the settings form, enable the button for the entity types and bundles you
   want. For example, tick a few of your content types so their "Add content" forms
   gain the button, while leaving others untouched.
4. Save the form.

From then on, whenever an editor creates a new entity of an enabled type, the
creation form shows a **Save and add another** button next to the standard Save
button. Clicking it saves the entity and reopens a fresh, empty add form for the
same type.

## Permissions

The module defines two permissions, set at **People → Permissions**
(`/admin/people/permissions`):

- A permission to **administer the settings** — who can reach the configuration
  form above and decide where the button appears.
- A permission to **use the "Save and add another" button** — which roles actually
  see and can use the button on the enabled forms.

Grant the "use" permission to your content editors, and keep the "administer"
permission limited to site administrators. Remember that the button never lets a
user create anything they could not already create — normal *create* access for
each entity type still applies.
