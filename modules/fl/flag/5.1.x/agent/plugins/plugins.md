# Plugin types Flag defines

Flag defines two plugin types; both are chosen per flag in the flag form.

## Flag Type — what can be flagged
- Namespace: `Plugin/Flag`
- Annotation: `Drupal\flag\Annotation\FlagType`
- Manager: `plugin.manager.flag.flagtype`
- Alter hook: `hook_flag_type_info_alter()`
- Core plugins: `EntityFlagType` (`entity`, derived per entity type via
  `EntityFlagTypeDeriver`), `CommentFlagType` (`entity:comment`),
  `UserFlagType` (`entity:user`). Base `Drupal\flag\FlagType\FlagTypeBase`.
- Governs `actionAccess()` / `actionPermissions()` and the flag's display options
  (show in links, as field, on form, in contextual links).

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
- Core plugins: `AJAXactionLink` (`ajax_link`), `Reload` (`reload`, default),
  `ConfirmForm` (`confirm`), `FieldEntry` (`field_entry`).
  Bases: `ActionLinkTypeBase`, `FormEntryTypeBase` (interface `FormEntryInterface`).
- Each plugin supplies the route/URL for its link and builds the `#theme => 'flag'`
  render array via `getAsFlagLink()`; access is resolved before rendering.

The `flag_count` submodule adds a `CountLink` (`count_link`) plugin extending
`AJAXactionLink` that swaps the theme to `flag_count` to append a `[n]` count.

After adding a plugin, `drush cr`; it appears as a selectable type in the flag form.
