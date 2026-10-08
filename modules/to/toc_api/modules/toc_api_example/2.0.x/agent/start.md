<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TOC API example — agent index

A **reference implementation** of the TOC API: one `hook_node_view()` in
`toc_api_example.module`, no config, no routes, no permissions. Depends on `toc_api`.
Read the parent's [../../../../2.0.x/agent/api/services.md](../../../../2.0.x/agent/api/services.md)
for the service API this demonstrates.

## What it does

`toc_api_example_node_view(&$build, $node, $display, $view_mode)`:

1. Acts only when `$node->getType()` is `page` or `article`, `$view_mode === 'full'`, and
   `$build['body'][0]` exists.
2. Renders the body to an HTML string.
3. Loads the `default` `toc_type` and its `getOptions()`.
4. `$toc = \Drupal::service('toc_api.manager')->create('toc_filter', $body, $options);`
5. If `$toc->isVisible()` (body has ≥ `header_count`, default 2, top-level headers), replaces
   `$build['body'][0]` with:
   ```php
   [
     'toc'     => $toc_builder->buildToc($toc),      // navigation
     'content' => $toc_builder->buildContent($toc),  // body + header ids + back-to-top
   ]
   ```

## To adapt it

Copy the hook into your module and change the content-type list, the view mode, or the
`TocType::load('<id>')` preset. That's the entire intended use — it is not meant to be
configured, only read and copied.
