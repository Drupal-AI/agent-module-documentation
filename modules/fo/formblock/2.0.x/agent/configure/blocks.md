<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — placing and configuring the blocks

There is **no module settings page**. Configuration lives entirely on each block instance
(a `block` config entity in a theme, or a Layout Builder / Panels component).

## Stored settings per plugin

`block.block.<id>` → `settings` (the `id` key inside `settings` is the plugin ID):

```yaml
# formblock_node
settings:
  id: formblock_node
  label: 'Submit an article'
  provider: formblock
  type: article        # node type machine name (required)
  form_mode: default   # 'default' or a node form mode id
  show_help: false     # prepend the node type's submission guidelines
```

```yaml
# formblock_user_register
settings:
  id: formblock_user_register
  form_mode: register  # default; 'default' or a user form mode id
```

```yaml
# formblock_contact
settings:
  id: formblock_contact
  contact_form: feedback   # a contact_form config entity id; defaults to
                           # contact.settings:default_form
```

```yaml
# formblock_user_password
settings:
  id: formblock_user_password
  # no plugin-specific settings
```

The **form** element keys in the block configure UI are different from the stored keys —
`formblock_node_type`, `formblock_node_form_mode`, `formblock_show_help`,
`formblock_contact_form`, `formblock_user_form_mode`. Only `blockSubmit()` maps them onto
`type` / `form_mode` / `show_help` / `contact_form`. Always write the **stored** keys when
creating config programmatically.

The module ships **no `config/schema`**, so these keys are unvalidated by the config schema
system; a strict-schema test site may warn about them.

## Place a block in the UI

*Structure → Block layout →* pick a region *→ Place block*. The four plugins appear under
the **Forms** category. For `formblock_node` the *Node type* and *Form mode* selects are
`#required`.

In Layout Builder: *Add block →* **Forms** category → same configuration form.

## Place a block with Drush / PHP

```bash
drush php:eval '
  use Drupal\block\Entity\Block;
  Block::create([
    "id" => "myarticleform",
    "theme" => "olivero",
    "region" => "content",
    "plugin" => "formblock_node",
    "weight" => 0,
    "settings" => [
      "id" => "formblock_node",
      "label" => "Submit an article",
      "label_display" => "visible",
      "provider" => "formblock",
      "type" => "article",
      "form_mode" => "default",
      "show_help" => TRUE,
    ],
    "visibility" => [],
  ])->save();
'
```

Read one back:

```bash
drush config:get block.block.myarticleform settings
```

Find every Form block instance on the site:

```bash
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("block")->loadMultiple() as $b) {
    if (str_starts_with($b->getPluginId(), "formblock_")) {
      print $b->id() . " " . $b->getPluginId() . " " . json_encode($b->get("settings")) . "\n";
    }
  }
'
```

## Access / visibility behaviour (not configurable — it is code)

| Plugin | `blockAccess()` |
|---|---|
| `formblock_node` | node access handler `createAccess($type)`; adds the node type's cache tags |
| `formblock_user_register` | denied for non-administrators when `user.settings:register` is `admin_only`; cache context `user.roles` |
| `formblock_contact` | contact form entity `view` access **and** the `access site-wide contact form` permission |
| `formblock_user_password` | none — inherits core block access only |

`formblock_contact` additionally checks core's contact flood limits
(`contact.settings:flood.limit` / `flood.interval`) in `build()`; when tripped it renders
the "You cannot send more than N messages in …" message *instead of* the form, unless the
user has `administer contact forms`.

## Form modes

The *Form mode* selects list `entity_display.repository`'s form modes for `node` / `user`
plus a literal `default`. A brand-new site typically has **no** node form modes and only
`register` for user, so create form modes first (*Structure → Display modes → Form modes*)
if you want anything other than `default`.
