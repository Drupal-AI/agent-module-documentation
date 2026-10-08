<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor Remove Format provides a single text-format filter that strips all HTML tags from content on output.

---

CKEditor Remove Format ships one filter plugin, "Remove Format Filter" (`filter_remove_format`). When
enabled on a text format, it runs PHP `strip_tags()` on the content as it is rendered, removing every
HTML tag and leaving only plain text. Despite the project name and README, there is no JavaScript,
no CKEditor 5 plugin, and no toolbar button in the module — it is purely a server-side output filter.
It is in the User interface package, has no dependencies, and works on Drupal 10.1 and 11.

Enable the filter per text format at Configuration → Content authoring → Text formats and editors
(`/admin/config/content/formats`). Because it removes all markup indiscriminately, it flattens that
format's rendered output to plain text; it is not a selective clear-inline-formatting tool and has no
settings. It has no access-control role.

---

- Provide the "Remove Format Filter" text-format filter.
- Strip all HTML tags from content on render via strip_tags().
- Enable the filter on a text format at /admin/config/content/formats.
- Flatten rich-text output to plain text.
- Remove tag attributes while keeping inner text.
- Run at output/render time, not on save.
- Work as a server-side filter with no JavaScript.
- Add no toolbar button and no CKEditor 5 plugin.
- Have no settings and no configuration page.
- Have no dependencies or third-party libraries.
- Have no permissions or routes.
- Have no access-control role.
- Clean up pasted or imported markup by removing it.
- Depend on filter execution order on the format.
- Support Drupal 10.1 and 11.
