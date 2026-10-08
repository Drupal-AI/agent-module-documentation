<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a post-save redirect for a bundle

No global settings page. You configure it on the **bundle's edit form**, or by writing the
bundle config's third-party settings directly.

## Where it is stored

On the bundle config entity (e.g. `node.type.article`):

```yaml
third_party_settings:
  entity_redirect:
    redirect:
      add:                     # one of: add | edit | delete | anonymous
        active: true           # must be true or the redirect is skipped
        destination: add_form  # see destinations below
        url: ''                # local path when destination = url (e.g. /thanks)
        external: ''           # external URL when destination = external
```

Supported bundle config entities (schema ships for each): `node.type.*`, `media.type.*`,
`taxonomy.vocabulary.*`, `contact.form.*`, `paragraphs.paragraphs_type.*`, `profile.type.*`,
and `webform.settings`.

## Actions

- `add` — after creating a new entity.
- `edit` — after editing an existing entity.
- `delete` — after deleting (destinations `edit_form` and `created` are not offered here).
- `anonymous` — overrides the destination **for anonymous users only** (checked first).

## Destinations (`destination`)

| Value | Goes to |
|---|---|
| `default` | No change (Drupal's normal post-save redirect). |
| `add_form` | A fresh add form for the same bundle. |
| `edit_form` | The entity's edit form. |
| `created` | The saved entity's canonical page. |
| `url` | A **local** path from the `url` setting (e.g. `/thanks`). |
| `previous_page` | The page the form was submitted from (HTTP referrer). |
| `layout_builder` | The entity's `…/layout` page — only when `layout_builder` is enabled. |
| `external` | The `external` URL — only for users with `set external entity redirects` (uses `TrustedRedirectResponse`). |

## Via the UI

1. Edit the bundle (content type: `/admin/structure/types/manage/<bundle>`).
2. Open the **workflow** tab → **Redirect after Entity Operations**.
3. Expand an action (Add/Edit/Delete/Override for Anonymous), tick **Enable**, pick a
   **Redirect Destination**, and fill **Local Destination Url** / **External Destination Url**
   if relevant.
4. **Save**.

## Via drush php:eval (scriptable)

```php
$type = \Drupal\node\Entity\NodeType::load('article');
$redirect = $type->getThirdPartySetting('entity_redirect', 'redirect', []);
$redirect['add'] = ['active' => TRUE, 'destination' => 'add_form', 'url' => '', 'external' => ''];
$type->setThirdPartySetting('entity_redirect', 'redirect', $redirect);
$type->save();
```

Read it back:

```bash
drush cget node.type.article third_party_settings.entity_redirect.redirect
```

## Permission

`set external entity redirects` gates the **External URL** destination (and its field on the
form). Without it, only local destinations are available.
