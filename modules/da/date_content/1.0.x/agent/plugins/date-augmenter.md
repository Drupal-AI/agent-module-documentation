# The `content` Date Augmenter plugin

The module's whole runtime behaviour lives in one Date Augmenter plugin. It is discovered by the
`date_augmenter` module's plugin manager and runs whenever a date-field formatter that supports Date
Augmenter renders a value.

- Class: `Drupal\date_content\Plugin\DateAugmenter\Content` (`src/Plugin/DateAugmenter/Content.php`).
- Annotation: `@DateAugmenter( id = "content", label = "Content", weight = 0 )`, description
  "Adds content to an event, for example to add a meeting presenter and topic."
- Base class: `date_augmenter\DateAugmenter\DateAugmenterPluginBase`; implements
  `Core\Plugin\PluginFormInterface`; uses `date_augmenter\Plugin\PluginFormTrait` and
  `RedirectDestinationTrait`.

## Enabling it (per formatter, not a settings page)

There is no module settings form. You enable and configure the augmenter on the **date field's
formatter**: *Manage display* → the date field → formatter settings → the **Date Augmenter** section
exposed by `date_augmenter` → enable **Content** and set its options. Settings are stored in that
formatter's third-party settings by `date_augmenter`; this plugin only supplies the form fields
(`configurationFields()`) and the render logic (`augmentOutput()`).

## Configuration keys (`defaultConfiguration()`)

| Key | Type | Default | Meaning |
|---|---|---|---|
| `bundles` | array (checkboxes) | `[]` | Which `date_content` bundles may be added here. Empty ⇒ **all** bundles are used. |
| `past_events` | bool | `TRUE` | If `FALSE`, the augmenter renders nothing once the value's end (or start, if no end) is in the past. |
| `target` | string | `''` | Link target: `''` = normal page, `tray` = off-canvas dialog, `modal` = modal dialog. Non-empty adds `use-ajax` + `data-dialog-*` attributes. |
| `width` | int | `600` | Dialog width (px) when `target` is `tray`/`modal`. |
| `form_mode` | string\|null | `NULL` | Only shown when `form_mode_control` is installed **and** the entity type has >1 form mode. (Note: the controller currently always builds the `default` form — see below.) |

## `augmentOutput()` mechanism (`Content.php:45`)

Signature: `augmentOutput(array &$output, DrupalDateTime $start, DrupalDateTime $end = NULL, array $options = [])`.
It returns early unless `$options['delta']` and `$options['entity']` are set. It then, per selected
bundle, runs an entity query against `date_content` matched on `type`, `parent_id` = host entity id,
`parent_type` = host entity type, `field_name` = `$options['field_name']`, `field_delta` =
`$options['delta']` (query uses `->accessCheck(FALSE)`):

- **Existing match** → renders the entity with the `full` view mode and appends **Edit**
  (`date_content.revise`) and **Remove** (`entity.date_content.delete_form`) links, each gated by the
  viewer's permission (`administer date content entities`, or `edit`/`delete date content entities`).
- **No match** → appends an **Add `<bundle>` content** link to `date_content.add_form_param`, gated by
  `administer date content entities` or `add date content entities`.

Assembled links are placed under `$output['date_content'][<bundle>]`. Links are built by
`structureLink()`, which sets a `destination` return query and, for `tray`/`modal`, the AJAX dialog
attributes.

## The add / revise flow

The Add link points at `date_content.add_form_param`, whose controller `DateContentController::addByParam`
pre-creates a `date_content` entity with `parent_type`/`parent_id`/`field_name`/`field_delta`/`type`
prefilled and returns its **`default`** add form. The Edit link points at `date_content.revise` →
`DateContentController::revise`, which returns the entity's **`default`** edit form. (Both hardcode the
`default` form mode today, so the `form_mode` setting above is collected but not yet honoured.)

## Writing your own augmenter

To add a *different* augmenter (this module does not define the plugin type), implement a
`DateAugmenter` plugin in your module — that plugin type is owned by `drupal/date_augmenter`
(`Plugin/DateAugmenter` discovery dir, `DateAugmenterPluginBase`). This `content` plugin is a reference
implementation of that contract.
