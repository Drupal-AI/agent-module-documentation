# Drush command

Registered via `drush.services.yml`; class
`Drupal\flush_single_image\Commands\FlushSingleImageCommands` (extends `DrushCommands`,
injected with `@flush_single_image`).

| Command | Alias | Argument | Option |
|---|---|---|---|
| `flush_single_image` | `fsi` | `path` — source image URI/path to flush (required) | `--check-styles` — list the cached derivatives and prompt for confirmation before flushing |

Behavior:
- If `path` does not exist on disk (`file_exists($path)`), errors out and does nothing.
- Runs `service->getStylePaths($path)`; if none are cached, prints a success "No cached image
  found" and stops.
- With `--check-styles`: prints each available derivative path, then asks "Flush Image Style(s)"
  — answering no prints "Flush Image Styles cancelled" and stops.
- Otherwise (and after a yes): runs `service->flush($path)`, which uses the default
  **Unlink** action (the CLI has no regenerate flag), printing each flushed path.

```bash
# Delete all cached derivatives of one image.
drush flush_single_image public://assets/foo/bar/image.jpg

# Review + confirm first.
drush fsi public://assets/foo/bar/image.jpg --check-styles
```
