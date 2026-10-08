<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ComputerMinds tools is a grab-bag of site-builder and developer tools by the ComputerMinds agency: a token-protected uptime-monitoring URL, a Paragraphs-as-table field formatter and widget, a Webform page-level validation handler, a session cache context, an update-report security sort, and static array/translation helper classes.

---

ComputerMinds tools (cm_tools) collects several unrelated conveniences into one small module. It exposes a stable, token-gated monitoring endpoint at `/cm_tools/monitoring/{token}` that external uptime services can poll — it bypasses the page cache and returns a site-constant hash plus the live server time, and answers even in maintenance mode. It ships a "Paragraphs table" field formatter and matching widget that render and edit an `entity_reference_revisions` (Paragraphs) field as a compact HTML table, one column per configured field, instead of stacked subforms. It provides a "Page level validation" Webform handler that sets a whole-form validation error driven by Webform Conditions, optionally scoped to chosen wizard pages. For developers it adds a `cm-session` calculated cache context (vary on the existence of a session or a named session key), an `ArrayHelper` of stable-sort and positional-insert utilities, a `TranslationHelper` to guarantee locale translations of simple strings exist, and a preprocess hook that sorts the available-updates report by security status. It has no permissions and no settings form of its own; the Paragraphs plugins require the `paragraphs` module and the Webform handler requires the `webform` module, but neither is a hard dependency, so those features load only where those modules are present.

---

- Poll site uptime from UptimeRobot/StatusCake/NewRelic via the stable `/cm_tools/monitoring/{token}` URL.
- Get a fresh, cache-bypassing response proving the site actually booted (live timestamp + constant hash).
- Keep monitoring working during maintenance mode (`_maintenance_access: TRUE`).
- Protect the monitoring URL with a high-entropy per-site token stored in State (shown on the status report).
- Display a Paragraphs reference field as a table, one column per field, using a chosen view mode.
- Edit a single-bundle Paragraphs field inline as a table using a chosen form display mode.
- Let other modules post-process each rendered paragraphs table via `hook_paragraphs_table_formatter_alter()`.
- Add a whole-form ("page level") validation error to a webform, controlled by Webform Conditions.
- Restrict that validation error to specific wizard pages of a multi-step form.
- Vary render caching on whether a session exists, or whether a named session key is set, with `cm-session`.
- Insert an element into an array immediately after/before a given key, value, or offset.
- Rename an array key while keeping its position, or remove elements by value.
- Sort arrays stably (equal items keep their order) with `cm_tools_stable_usort` / `cm_tools_stable_uasort`.
- Ensure specific locale (interface) translations of simple strings exist from install/update code.
- Validate target langcodes before writing translations (throws on an unconfigured language).
- Surface security-relevant module updates at the top of `admin/reports/updates`.
- Use it purely as a developer dependency for the `ArrayHelper` / `TranslationHelper` utilities.
- Add it because another custom/contrib module lists it as a dependency.
- Adopt only the pieces you need — features are independent and unused ones stay dormant.
- Run it on Drupal 9, 10, or 11 with no other module dependencies (PHP 8.0+).
