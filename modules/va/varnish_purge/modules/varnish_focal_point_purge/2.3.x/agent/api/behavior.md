# Behaviour — Varnish Focal Point Purger

No config, no services, no plugins, no routes. It is a single `.module` file implementing
two hooks.

## `hook_entity_update()`

Runs on every entity save but returns immediately unless
`$entity->bundle() === 'focal_point'` (the Focal Point / Crop module's crop entity). Then:

1. Finds configured Varnish purgers via a config query
   `LIKE 'varnish_purger.settings%'`; reads each one's `hostname`/`port`. Returns if none.
2. Loads the cropped file: `File::load($entity->entity_id->value)`; returns if not a
   `FileInterface`.
3. Loads all image styles (`ImageStyle::loadMultiple()`), builds each derivative URL
   (`$style->buildUrl($file->getFileUri())`).
4. Fires a concurrent `URIBAN` request per derivative URL through a Guzzle `Pool`
   (concurrency = `VarnishPurger::VARNISH_PURGE_CONCURRENCY` = 10). Failures are logged to
   the `varnish_focal_point_purge` logger channel.

## `hook_help()`

Adds the About text and the required VCL snippet on `help.page.varnish_focal_point_purge`.

## Required Varnish VCL

Your Varnish must handle the `URIBAN` method (same as `varnish_image_purge`):

```vcl
if (req.method == "URIBAN") {
  ban("req.http.host == " + req.http.host + " && req.url == " + req.url);
  return (synth(200, "Ban added."));
}
```

## Setup

`drush en varnish_focal_point_purge -y`. Needs `varnish_purger` + `purge` enabled and at
least one configured `varnish` purger (for the hostname/port lookup), plus the Focal Point
module in use. There is nothing else to configure.
