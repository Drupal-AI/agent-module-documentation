# Action plugin: `flush_single_image_action`

`Drupal\flush_single_image\Plugin\Action\FlushSingleImageAction` (`ConfigurableActionBase`,
type `media`). This is why the module depends on core `action`. It ships as an installed action
config entity `system.action.flush_single_image_action`, so it appears as a bulk operation on
media (image) admin listings / views without any manual setup.

## Access

`access()` returns FALSE unless the account has the `flush media image` permission, then requires
`update` access on the target media entity (`$media->access('update', $account, TRUE)`).

## Execute

For each selected entity, acts only when it is a `MediaInterface` of bundle `image` that has a
non-empty `field_media_image`. It reads that field's file URI (`->entity->getFileUri()` — the
media's own managed file, never a request-supplied path) and calls
`service->flush($image_uri, $action)`, adding a message per flushed derivative.

## Configuration

| Config key | Values | Default |
|---|---|---|
| `fsi_action` | `1` Unlink / `2` Regenerate | `FlushSingleImage::ACTION_UNLINK` |

Set the default at `/admin/config/system/actions/configure/flush_single_image_action`
(`buildConfigurationForm()` renders the Unlink/Regenerate select). The module's settings form
determines which media bundles are considered images elsewhere, but this action itself hard-codes
the `image` bundle check.
