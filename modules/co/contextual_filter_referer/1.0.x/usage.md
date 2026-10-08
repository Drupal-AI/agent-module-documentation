Contextual Filter Referer supplies a View's contextual filter (argument) from the referring page's URL, so context survives an AJAX request.

---

A View placed as a block takes its argument from the page it is on — a node id, or some path component. The visitor then clicks the pager or submits an exposed filter, the View reloads over Views' AJAX endpoint, and the request no longer originates from that page: it comes from `/views/ajax`, where the original URL context is gone. Page one is right and every later page is wrong — the classic "the pager is broken" report. The same failure hits entity-reference fields whose allowed values come from a View. This module ships two Views *argument default* plugins that read the `Referer` request header instead of the current URL: **Content ID from Referer** (`node_referer`) resolves the referring path to a route and returns its `node` parameter's id, and **Raw value from Referer URL** (`referer_raw`) returns a chosen path component (1-based index, optionally after resolving the path alias). You pick one of these as the "default value" source on a contextual filter, exactly as you would core's own "Content ID from URL" or "Raw value from URL". Enable the module, edit the View's contextual filter, choose *"Provide default value"*, and select the referer option. `Referer` is client-supplied and may be absent (privacy settings, some proxies, direct navigation) or spoofed, so use it to carry presentation context, and always give the argument a sensible fallback for the no-referer case; never let it stand in for an access check.

---

- Keep a contextual filter value across Views AJAX pagination.
- Fix a block View pager that returns wrong results after page one.
- Fix an exposed-filter submit that loses the page's node context.
- Filter a block View by the node of the page it is placed on, through AJAX reloads.
- Supply allowed values to an entity-reference field that are filtered by a View.
- Use "Content ID from Referer" (`node_referer`) to get the referring page's node id.
- Use "Raw value from Referer URL" (`referer_raw`) to grab one path component of the referring URL.
- Pick the 3rd path segment of the referring URL as the argument (index is 1-based).
- Resolve the referring path through its path alias before extracting a component.
- Replace core's "Content ID from URL" default on a View that renders inside an AJAX region.
- Set a "Provide default value" source on a Views contextual filter to the referer plugin.
- Give the contextual filter a fallback for visitors whose browser strips the Referer header.
- Diagnose a View that is correct on the first page but empty or wrong on later pages.
- Preserve section/category context in a paged listing embedded as a block.
- Test View behaviour with referer-stripping browsers or privacy proxies.
- Audit which Views rely on referer-derived context before an upgrade.
- Migrate a site off the unmaintained `swilmes/3204196` sandbox to this full project.
- Document for the team why a Views argument is derived from the referring page.
- Review referer-based contextual filters during a site audit.
- Confirm the module's two argument-default plugins still resolve after a Drupal core upgrade.
