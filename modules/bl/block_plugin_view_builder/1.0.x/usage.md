<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Block Plugin View Builder gives developers a straightforward way to render a block plugin from code, without placing it in a region.

---

Drupal's block system conflates two things: a **block plugin**, which is a piece of code that produces a render array, and a **block placement**, which is a configuration entity saying that plugin appears in a region under conditions. Most of the time both are wanted. Sometimes only the first is — a controller that needs the site's search form in its output, a custom page assembling several plugins, a mail template wanting a rendered component, a test that needs a plugin's output without a page around it. Doing that by hand means fetching the block manager, creating the plugin instance with its configuration, checking its access, calling `build()`, and attaching the cache metadata the plugin returned — which is five steps that are easy to get wrong in a specific way: **the access check and the cache metadata are the ones people skip**, because the output looks correct without them. A helper that does the whole sequence is worth having for that reason rather than for the typing it saves. Version **1.0.6** on core `^10 || ^11`, no dependencies, no UI. Two things worth attaching. **Rendering a plugin bypasses the placement's visibility conditions**, which is the point — but those conditions are sometimes where a site expressed "this block is only for administrators", so a plugin rendered directly may appear somewhere the configuration said it should not. And **a block plugin's cache metadata belongs to whatever renders it**: a plugin varying by user renders differently per user, and code that drops its cacheability produces a fragment cached for everyone, which is the standard way this becomes a disclosure rather than a bug.

---

- Render a block plugin from a controller.
- Include a search form in custom output.
- Build a page from several block plugins.
- Render a block into a mail template.
- Test a block plugin's output.
- Render a plugin without placing it.
- Compose a custom dashboard from blocks.
- Render a menu block programmatically.
- Include a block in a custom render array.
- Build a preview of a block plugin.
- Render a block in an API response.
- Reuse a block plugin's output.
- Render a plugin with custom configuration.
- Build a component from a block plugin.
- Include a block in a PDF template.
- Render a block for a decoupled front end.
- Test a plugin's access behaviour.
- Assemble output from plugin instances.
