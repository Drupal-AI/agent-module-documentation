# AJAX routes, flood limiter and cron cleanup

All hotspot mutations happen through one controller,
`Drupal\image_hotspots\Controller\ImageHotspotsController`
(`src/Controller/ImageHotspotsController.php`). The `image_hotspots.edit`/`.view` JS posts to these
routes with jQuery `$.post`; each returns a `Symfony\Component\HttpFoundation` `AjaxResponse` whose
payload is the hotspot parameters (or an `error`/message string) and whose HTTP status carries the
outcome. Every route requires `_permission: 'edit image hotspots'`.

| Route name | Path | Method (controller) | Purpose |
|---|---|---|---|
| `image_hotspots.create_hotspot` | `/image-hotspots/create` | `createAction(Request)` | Create a hotspot from POST fields. |
| `image_hotspots.update_hotspot` | `/image-hotspots/{hid}/update` | `updateAction($hid, Request)` | Overwrite an existing hotspot. |
| `image_hotspots.delete_hotspot` | `/image-hotspots/{hid}/delete` | `deleteAction($hid)` | Delete a hotspot. |
| `image_hotspots.translate_hotspot` | `/image-hotspots/{hid}/{langcode}/translate` | `translateAction($hid, $langcode, Request)` | Add/update a per-language translation of title/description/link. |

## Request fields

`createAction` / `updateAction` read `$request->request->all()` and use:

- `title`, `description`, `link`, `target` — text fields; the controller passes each through
  `Drupal\Component\Utility\Xss::filter()` and strips `javascript:` URIs before saving.
- `x`, `y`, `x2`, `y2` — region coordinates.
- create also needs `field_name`, `fid`, `image_style`, `langcode` (the target tuple); `uid` is forced
  to the current user.

`updateAction` sets title/description/link/target/coordinates on the loaded entity and saves; returns
404 if `hid` does not resolve. `translateAction` loads the entity, gets or adds the `$langcode`
translation, and sets title/description/link only (no coordinates/target).

`deleteAction` loads the entity, reads its `getTarget()` for cache invalidation, and deletes it.

## Flood limiter (`accessCallback()`)

Beyond the route permission, each action first calls the protected `accessCallback()`
(`ImageHotspotsController.php:207`), a **rate limiter** built on `\Drupal::flood()` keyed by client IP
(`image_hotspots.action`):

- Anonymous: at most 1 action per 20-second window.
- Authenticated: at most 5 actions per 10-second window.

When the limit is exceeded the action returns HTTP 403 with a "wait some seconds" message. This is a
throttle, not the authorization check — authorization is the route `_permission`.

## Cache invalidation

After a successful create/update/delete/translate, `disableCache($target)`
(`ImageHotspotsController.php:245`) invalidates the tag
`hotspots:{field_name}:{fid}:{image_style}`, which is the same tag the formatter attaches to each
rendered image — so an edit made on one display refreshes everywhere the image appears.

## Cron cleanup of orphaned hotspots

`image_hotspots.module` implements two delete hooks that keep hotspots from dangling:

- `image_hotspots_file_delete()` — when a file is deleted, entity-queries every `image_hotspot` with
  that `fid`.
- `image_hotspots_image_style_delete()` — when an image style is deleted, queries every hotspot with
  that `image_style`.

Both push `['hid' => …]` items onto the `cron_image_hotspots_deletion` queue. The queue worker
`Drupal\image_hotspots\Plugin\QueueWorker\CronHotspotsWorker` (`cron = {"time" = 10}`) loads and
deletes each hotspot on the next cron run.
