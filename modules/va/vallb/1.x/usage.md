<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Ajax Lazy Builder Block provides Ajax-lazy-loaded copies of your Views block displays that render a lightweight placeholder up front and fetch the real view output over Ajax once an IntersectionObserver sees the block enter the viewport.

---

For each Views block display, this module exposes a parallel block (plugin id `vallb_block`, labelled with a `[Lazy Loaded]` category suffix) that you place instead of the stock Views block. On initial page load the block renders only a small "Loading..." SVG placeholder; a client-side IntersectionObserver (`js/lazy-load.js`, using `core/once`) watches the placeholder and, when it scrolls into view, calls `Drupal.ajax()` against the `vallb.lazy_builder` route (`/vallb/{view}/{display_id}/{nojs}`). The controller (`Drupal\vallb\Renderer::output`) builds the real view render array and returns an Ajax `ReplaceCommand` that swaps the placeholder for the rendered view. This lets a page carry many heavy Views blocks — dashboards, chart-laden reports — without stalling on an uncached first hit, and without needing BigPipe. Access on the Ajax path is delegated to the view's own display access via `Renderer::checkOutputAccess` (`$view->access($display_id)`), and exposed filters plus contextual arguments are forwarded through the request query so lazy blocks behave like their inline counterparts.

---

- Lazy-load a heavy Views block below the fold so it renders only when scrolled into view.
- Speed up an uncached dashboard page carrying 20+ Views blocks.
- Defer data-intensive chart blocks (e.g. Charts module) until they are visible.
- Replace a stock Views block with its `[Lazy Loaded]` counterpart in Block layout.
- Avoid needing BigPipe to get progressive rendering of view blocks.
- Prevent a page stall on first (uncached) visit to a report-heavy page.
- Render a "Loading..." placeholder while the real view fetches over Ajax.
- Serve exposed-filter input to the lazy block via the page query string.
- Pass contextual/argument values to a lazy view through `vallb_views_arguments`.
- Inject a taxonomy term id as a view argument from `hook_preprocess_vallb`.
- Preload libraries a lazy block will need (charts, exporting) before its Ajax call.
- Keep the view's own display access rules enforced on the deferred render.
- Load many independent view blocks in parallel as each enters the viewport.
- Reduce time-to-first-byte on pages that aggregate multiple views.
- Trim initial render cost for authenticated (cache-bypassing) users.
- Support multiple instances of the same view/display with distinct arguments on one page.
- Provide a graceful placeholder for slow third-party-data views.
- Use IntersectionObserver instead of scroll listeners for efficient triggering.
- Fetch each block only once (observer unobserves after the first intersection).
- Theme or restyle the placeholder via `css/placeholder.css` and the `vallb` template.
- Add contextual (admin) links to the lazily rendered view output.
- Migrate an existing dashboard from inline Views blocks with minimal reconfiguration.
