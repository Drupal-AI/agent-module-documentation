# Configure VAPN + set per-node view access

## 1. Enable VAPN on content types

VAPN does nothing until you enable it on one or more node bundles.

### Via the UI
Go to `/admin/config/people/vapn` (route `vapn.settings`, needs `administer vapn`), tick the
content types that should get per-node view access, Save. Saving also clears cached field
definitions so the `vapn` field attaches to those bundles.

### Where it is stored
Config object `vapn.settings`, key `bundles` — a **map of enabled bundle machine name →
`true`**:

```yaml
# vapn.settings
bundles:
  article: true
  page: true
```

Baseline (shipped `config/install`) is empty: `bundles: {}`.

### Via drush (scriptable)
```php
// Enable VAPN on the 'article' bundle.
$c = \Drupal::configFactory()->getEditable('vapn.settings');
$bundles = $c->get('bundles') ?: [];
$bundles['article'] = TRUE;
$c->set('bundles', $bundles)->save();
// Re-attach the vapn field to bundles.
\Drupal::service('entity_field.manager')->clearCachedFieldDefinitions();
```
```bash
drush cget vapn.settings bundles      # read enabled bundles
drush cr
```

## 2. The `vapn` field (attached automatically)

For each enabled bundle the module attaches a computed field **`vapn`** — an unlimited
entity-reference to `user_role`, defined in `_vapn_create_field_definition()` (not a
configurable/exported field). On the node edit form it appears as a **View access per node**
vertical tab (details in the `advanced` group), rendered with the `options_buttons`
(checkboxes) widget. Roles with *bypass node access* are not offered.

## 3. Set which roles can view a node

Edit a node of an enabled type, open the **View access per node** tab, and check the roles
allowed to view it. Programmatically it is just the `vapn` field:

```php
$node->set('vapn', ['editor', 'manager']);   // role IDs
$node->save();
// read back:
$rids = array_column($node->get('vapn')->getValue(), 'target_id');
```

## 4. How view access is decided (`hook_node_access`, op `view`)

- User has **`bypass vapn`** → allowed (always).
- Node has **one or more roles** selected → allowed only if the user has at least one of
  them; otherwise **forbidden**.
- Node has **no roles** selected → VAPN returns **neutral** (it abstains; core/other modules
  decide). So an empty `vapn` field means "VAPN does not restrict this node".

Only the **view** operation is affected. The result is cached per node and varies by
`user:roles`.

## Notes
- Selecting even one role turns VAPN on for that node and denies everyone without a matching
  role — including anonymous, unless the anonymous role is selected.
- Because it uses only `hook_node_access`, it composes with other access modules (any module
  returning forbidden still wins).
