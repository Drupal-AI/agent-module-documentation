# Plugin types Flag defines

Flag defines two plugin types; both are chosen per flag in the flag form.

## Flag Type — what can be flagged
- Namespace: `Plugin/Flag`
- Annotation: `Drupal\flag\Annotation\FlagType`
- Manager: `plugin.manager.flag.flagtype`
- Alter hook: `hook_flag_type_info_alter()`
- Core plugins: `EntityFlagType`, `CommentFlagType`, `UserFlagType`
  (base `Drupal\flag\FlagType\FlagTypeBase`).

```php
namespace Drupal\mymodule\Plugin\Flag;

use Drupal\flag\Annotation\FlagType;
use Drupal\flag\FlagType\FlagTypeBase;

/**
 * @FlagType(
 *   id = "my_thing",
 *   title = @Translation("My thing"),
 *   entity_type = "my_entity",
 * )
 */
class MyThingFlagType extends FlagTypeBase {}
```

## Action Link — how the flag/unflag link renders
- Namespace: `Plugin/ActionLink`
- Annotation: `Drupal\flag\Annotation\ActionLinkType`
- Manager: `plugin.manager.flag.linktype`
- Alter hook: `hook_flag_link_type_info_alter()`
- Core plugins: `AJAXactionLink` (`ajax_link`), `Reload` (`reload`),
  `ConfirmForm` (`confirm`), `FieldEntry` (`field_entry`).
  Bases: `ActionLinkTypeBase`, `FormEntryTypeBase` (interface `FormEntryInterface`).

After adding a plugin, `drush cr`; it appears as a selectable type in the flag form.
