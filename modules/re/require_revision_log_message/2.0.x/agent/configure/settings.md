# Configure which content types require a revision log message

All state lives in one config object: **`require_revision_log_message.adminsettings`**.

```yaml
content_types:            # sequence of node-type machine names the rule applies to
  article: article        # keyed by machine name; presence = "on" for that type
require_for_new_nodes: false   # also require on NEW nodes? default false (edits only)
```

Shipped default (`config/install`): `content_types: {}` and `require_for_new_nodes: false`
(nothing required).

## Via the UI

1. Go to **Configuration → Content authoring → Require Revision Log Messages**
   (`/admin/config/require-revision-log/adminsettings`), route
   `require_revision_log_message.admin_settings_form`. Requires the
   `administer require_revision_log_message` permission.
2. Tick the content types that must have a revision log message.
3. Optionally tick **Require revision log message for new nodes** to also enforce it on node
   creation (otherwise it only applies when editing existing nodes).
4. Save. The submit handler stores `array_filter($content_types)` so only checked types are
   written (unchecked ones are dropped, not stored as `0`).

## Via drush (scriptable)

```bash
# Require log messages on Article edits:
drush php:eval '\Drupal::configFactory()->getEditable("require_revision_log_message.adminsettings")
  ->set("content_types", ["article" => "article"])
  ->set("require_for_new_nodes", FALSE)->save();'

# Read it back:
drush cget require_revision_log_message.adminsettings
```

`drush cset require_revision_log_message.adminsettings require_for_new_nodes true -y` toggles
the new-node behavior.

## What it does to the node form

For an affected type, `require_revision_log_message_form_node_form_alter()`:
- Forces `$form['revision']['#value'] = TRUE` and disables the checkbox (can't be unchecked).
- Sets `#required = TRUE` on `revision_log` and its nested widget elements
  (`widget`, `widget[0]`, `widget[0]['value']`), and clears its `#states`.

It early-returns (no requirement) when: the current user has
`bypass require_revision_log_message`; the node's bundle is not in `content_types`; or the
node `isNew()` and `require_for_new_nodes` is FALSE. The affected bundle is detected from
`$form['#process'][1][0]->getTargetBundle()`.
