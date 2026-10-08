# Extend — the response subscriber

## The subscriber

`Drupal\minifyhtml\EventSubscriber\MinifyHTMLExit` (registered in
`minifyhtml.services.yml` as service `minifyhtml_exit`, tagged `event_subscriber`).

- Subscribes to `KernelEvents::RESPONSE` with method `response()` at priority **-10000** —
  intentionally the last thing to touch the response.
- Constructor args: `@config.factory`, `@datetime.time`, `@logger.factory`,
  `@path.matcher`, `@path.current`.
- Runs only when `minifyhtml.config:minify` is TRUE.
- Acts only on these response classes (others pass through untouched):
  `Drupal\Core\Render\HtmlResponse` and `Drupal\big_pipe\Render\BigPipeResponse`.

## Processing pipeline (`response()` → `minify()`)

1. Return early if the current path matches `exclude_pages`.
2. Replace `<textarea>`, `<pre>`, `<iframe>`, `<script>`, `<style>` blocks with placeholder
   tokens (`%MINIFYHTML_<rand>-<n>%`) so their contents are protected. Script/style blocks
   get inner whitespace/comment cleanup first; `application/ld+json` scripts are left
   newline-safe; IE conditional comments are preserved.
3. If `strip_comments` is on, remove HTML comments (`<!-- … -->`) except IE conditionals.
4. `minifyHtml()` collapses whitespace: trims non-space whitespace after `>` and before `<`,
   shortens whitespace runs, strips whitespace around block/undisplayed elements, trims each
   line.
5. Restore placeholders (in reverse) and `setContent()` on the response — unless a stray
   `%<token>` remains, in which case it logs `Minifyhtml failed.` to the `minifyhtml` logger
   and leaves the original content (safe fallback). Regex errors are logged and the
   pre-error content is kept.

## How to extend / override

The module exposes no plugin type, no `*.api.php`, and no service you are meant to call.
To change behavior, override the subscriber itself:

- **Swap the class** — in a custom module's `*.services.yml`, redefine the `minifyhtml_exit`
  service `class` to your subclass of `MinifyHTMLExit`, overriding the protected helpers
  (`minify()`, `minifyHtml()`, the per-tag placeholder callbacks) to add/remove passes. Keep
  the `event_subscriber` tag and the same constructor arguments.
- **Add your own late subscriber** — register another `KernelEvents::RESPONSE` subscriber at
  a priority below `-10000` if you need to run after minification, or above it to alter the
  HTML before minifyhtml sees it. Guard on `get_class($response)` the same way.
- **Adjust ordering** via the priority in `getSubscribedEvents()` if subclassing.

There is no hook to alter the minified output; extension is entirely through the
service/subscriber layer.
