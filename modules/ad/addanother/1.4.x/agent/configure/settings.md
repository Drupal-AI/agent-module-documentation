<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Add Another

Everything is stored in the single config object **`addanother.settings`**. There is no per-node
state — behavior is decided per content type at form-build time.

## Global defaults (settings form)

Route `addanother.admin_config` → `/admin/config/content/addanother` (permission
`administer add another`). Four booleans that seed **new** content types:

| Key | Default | Effect for new types |
|---|---|---|
| `default_button` | `true` | "Save and add another" button on the node add form |
| `default_message` | `true` | "Add another…" message after a normal save |
| `default_tab` | `true` | "Add another" local-task tab on node pages |
| `default_tab_edit` | `true` | also show that tab on the node **edit** page |

```bash
drush cget addanother.settings
drush cset addanother.settings default_button 0 -y   # stop offering the button by default
```

## Per-content-type overrides

The module alters the **node type edit form** (`hook_form_node_type_form_alter`) to add an
"Add another settings" section with four checkboxes. Saving writes type-keyed values into the
same config object:

```yaml
# addanother.settings
button:
  article: true       # button.<type>
message:
  article: true       # message.<type>
tab:
  article: false      # tab.<type>
tab_edit:
  article: false      # tab_edit.<type>
```

When a per-type key is unset, the matching `default_*` value is used. Set them scriptably:

```bash
drush cset addanother.settings button.article 1 -y
drush cset addanother.settings message.article 0 -y
```

Or in PHP:

```php
\Drupal::configFactory()->getEditable('addanother.settings')
  ->set('button.article', TRUE)
  ->set('tab.article', TRUE)
  ->save();
```

## Runtime behavior

- The **button** and **message** are only added on the node **add** form (a new, unsaved node)
  and only for users with the `use add another` permission. "Save and add another" redirects to
  `node.add` for the same type and suppresses the default creation message.
- The **tab** is the route `addanother.redirect` (`/node/{node}/addanother`), which just
  redirects to `node.add` for that node's type. Its access callback requires `use add another`,
  the type's `tab.<type>` flag, and (on the edit route) `tab_edit.<type>`.

## Permissions

- `administer add another` — reach the settings form / configure content types.
- `use add another` — actually see and use the button, message, and tab.
