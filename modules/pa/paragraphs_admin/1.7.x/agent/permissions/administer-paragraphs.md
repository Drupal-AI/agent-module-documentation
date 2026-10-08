<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permission: `administer paragraphs`

The module defines exactly one permission (in `paragraphs_admin.permissions.yml`):

```yaml
'administer paragraphs':
  title: 'Administer paragraphs'
  description: 'Allows to view and delete paragraphs from admin screen.'
  restrict access: true
```

- **`administer paragraphs`** — gates the paragraphs overview at `/admin/content/paragraphs`
  (the shipped `paragraphs` view's access). Marked `restrict access: true`, so Drupal shows the
  "grant with care" warning on the permissions page (it lets a user see and delete any paragraph).

Note the **delete route** (`/paragraph/{paragraph}/delete`) is instead gated by the entity
access check `paragraph.delete`, not by this permission directly.

Grant it via the UI (People → Permissions) or:

```bash
drush role:perm:add editor 'administer paragraphs'
```

Or in `drush php:eval`:

```php
\Drupal\user\Entity\Role::load('editor')
  ->grantPermission('administer paragraphs')->save();
```
