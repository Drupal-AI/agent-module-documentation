# Use the Tabs layout

The module has **no configure route and no settings**. Its only "configuration" is choosing the
`tabs` layout for a Layout Builder section; that choice is stored in the entity view display.

## In the UI

1. Enable Layout Builder for a display: *Structure → Content types → [type] → Manage display →*
   check **Use Layout Builder** (optionally *Allow each content item to have its layout customized*).
2. Click **Manage layout** (or edit an individual entity's layout).
3. **Add section** → choose **Tabs** (listed under the *Extra Layouts* category).
4. **Add block** into the section. Each block becomes one tab; the tab label is the block's
   rendered title, falling back to the block's configured label.
5. Reorder blocks to reorder tabs (the template sorts by each block's `#weight`).
6. **Save layout**.

## Where it lives in config

Layout Builder stores sections on the entity view display config entity:

```
core.entity_view_display.<entity_type>.<bundle>.<view_mode>
  third_party_settings:
    layout_builder:
      enabled: true
      sections:
        - layout_id: tabs
          layout_settings: { ... }
          components: { <uuid>: { ... block components ... } }
```

A Tabs section is any element of that `sections` array whose `layout_id` is `tabs`.

## Add a Tabs section programmatically

```php
use Drupal\layout_builder\Section;

$display = \Drupal::entityTypeManager()->getStorage('entity_view_display')
  ->load('node.article.default');
// Turn on Layout Builder if needed.
$display->enableLayoutBuilder();
// Append a Tabs section (blocks are added as SectionComponents into region "tabs").
$display->appendSection(new Section('tabs'));
$display->save();
```

Read back which layouts a display uses:

```php
$display = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
foreach ($display->getSections() as $i => $section) {
  printf("section %d -> %s\n", $i, $section->getLayoutId());
}
```

There is no other configuration surface — appearance is controlled through the theme/CSS
(see [theming/template.md](../theming/template.md)).
